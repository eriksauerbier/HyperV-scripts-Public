# Skript zum prüfen eines Hyper-V Hosts
# Stannek GmbH - E.Sauerbier - v.0.91(Beta) - 31.05.2022


# Parameter

$NTPServer1 = "ptbtime1.ptb.de"
$NTPServer2 = "time.services.datevnet.de"

# Windows-Build auslesen
$WinBuild = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\").CurrentBuild


## Freien Speicher auf allen ausgelesen AD-Objekten auslesen ##
Get-WMIObject Win32_LogicalDisk | Where-Object "DriveType" -eq "3" | Select-Object DeviceID, @{Name="FreeSpace (GB)";Expression={[Math]::round($_.FreeSpace / 1GB, 2)}}

## Zeitdifferenz auswerten ##

# Prüfen ob DATEV NTP-Server auflösbar ist
If (Resolve-DnsName $NTPServer2 -ErrorAction SilentlyContinue) {$NTPServer = $NTPServer2}
Else {$NTPServer = $NTPServer1}

$NTPTime = & "$env:windir\system32\w32tm.exe" /stripchart /computer:$NTPServer /samples:1 /dataonly
$TimeDiff = ($NTPTime | select-object -last 1).Substring(11)

## Ausgabe für Zeitdifferenz generieren ##
If ($NTPTime -match "Fehler") {$OutputNTP = "Es ist ein Fehler beim Zeitabgleich mit dem NTP-Server $NTPServer aufgetreten `n";$OutputNTPColor = "RED"}
Else {$OutputNTP = "Der Host hat eine Zeitdifferenz von $TimeDiff`n"}

## Datum der letzten WindowsUpdates auslesen ##

# Prüfen ob es sich um ein Server 2019 und neuer handelt, mit 2016/2012 können keine WindowsUpdates per PS geprüft werden
If ($WinBuild -le "14939") {$OutputWU = "WindowsUpdates bitte manuell prüfen`n";$OutputWUColor="Yellow"}
Else {$LastWUDate = Get-WULastInstallationDate | Select-Object -ExpandProperty DateTime

      # Zeitdifferenz der letzten WindowsUpdates berechnen
      $WUDiff = New-TimeSpan -Start $LastWUDate -End (Get-Date)
      If ($WUDiff.Days -gt "30") {$OutputWU = "Windows Updates wurde seht mehr als 30 Tage nicht mehr installiert";$OutputWUColor="Red"}
      Else {$OutputWU = "Windows Updates wurden zuletzt installiert am: $($LastWUDate)`n"}
     }

## Snapshots prüfen ##

$SnapshotsAvail = (Get-VM | Where-Object {$_.ParentSnapshotID -ne $Null} | Select-Object Name)
If ($SnapshotsAvail -ne $Null) {$OutputSnapshot = "Es sind Snapshots vorhanden: $($SnapshotsAvail.Name) `n";$OutputSnapshotColor = "RED"}
Else {$OutputSnapshot = "Es sind keine Snapshots vorhanden`n"}

## Windows Defender prüfen ##

$DefenderState = [PSCustomObject]@{
    Text     = ' '
    Installed = ' '
}

# Server Version Prüfen
if ($WinBuild -le "9600") 
  {if ((Get-WindowsFeature -Name Windows-Defender).Installed -eq $true) 
    {
     # Defender Status auslesen
     $DefenderState.Installed = "Yes"
     $DefenderState.Text = Get-MpComputerStatus | Select-Object AntivirusEnabled, AntivirusSignatureLastUpdated, OnAccessProtectionEnabled
     $DefenderDetection = Get-MpThreatDetection | Select-Object ActionSuccess, InitialDetectionTime, Resources 
    }
   Else {$DefenderState.Text = "Es ist kein Windows Defender installiert `n"; $DefenderState.Installed = "No"}
  }
Else {$DefenderState.Text = "Für Server 2012R2 und älter existiert noch kein Defender `n"; $DefenderState.Installed = "No"}

# Ausgabe für Virenschutz generieren
If (($DefenderState.Installed -eq "Yes") -and ($DefenderDetection -ne $Null)) {$OutPutDefender = "Der Defender hat Schadsoftware erkannt `n";$OutputDefenderColor = "RED"}
If (($DefenderState.Installed -eq "Yes") -and ($DefenderDetection -eq $Null)) {$OutPutDefender = "Der Defender ist installiert und hat folgenden Status: `n $($DefenderState.Text -replace ('@',''))`n"}
If ($DefenderState.Installed -eq "No") {$OutPutDefender = $DefenderState.Text;$OutputDefenderColor = "RED"}

## Veeam Agent prüfen ##
$VeeamBackupState = Get-EventLog -LogName "Veeam Agent" -Newest 1 -ErrorAction SilentlyContinue

# Wenn kein Veeam Agent Eventlog gefunden wurde, dann wird eine Warnung ausgegebn
if ($VeeamBackupState -eq $Null) {$OutputBackup = "Es ist kein Veeam Agent installiert";$OutputBackupColor = "Red"}
Else {# Nun wird das Eventlog der letzen 5 Tage nach Fehler und Warnungen durchsucht 
      $VeeamBackupState = Get-EventLog -LogName "Veeam Agent" -EntryType Error,Warning -After (get-date).AddDays(-5) -ErrorAction SilentlyContinue
      if ($VeeamBackupState -eq $Null) {$OutputBackup = (Get-EventLog -LogName "Veeam Agent" -InstanceId 190 -Newest 1).Message}
      Else {$OutputBackup = $VeeamBackupState}
     }

### Ausgabe ###

#Clear-Host

Write-Host "`n"

# Ausgabe WindowsUpdates
Write-Host "-- Windows Updates --`n" -ForegroundColor DarkGray
If ($OutputWUColor -ne $Null) {Write-Host $OutPutWU -ForegroundColor $OutputWUColor}
Else {Write-Host $OutPutWU}

# Ausgabe Uhrzeit
Write-Host "-- Uhrzeit --`n" -ForegroundColor DarkGray
If ($OutputNTPColor -ne $Null) {Write-Host $OutPutNTP -ForegroundColor $OutputNTPColor}
Else {Write-Host $OutPutNTP}

# Ausgabe Virenschutz Status
Write-Host "-- Virenschutz --`n" -ForegroundColor DarkGray
If ($OutputDefenderColor -ne $Null) {Write-Host $OutPutDefender -ForegroundColor $OutputDefenderColor}
Else {Write-Host $OutPutDefender}

# Ausgabe Snapshot Stauts
Write-Host "-- Snapshot --`n" -ForegroundColor DarkGray
If ($OutputSnapshotColor -ne $Null) {Write-Host "$OutputSnapshot `n" -ForegroundColor $OutputSnapshotColor}
Else {Write-Host "$OutputSnapshot `n"}

# Ausgabe Backup Status
Write-Host "-- Backup --`n" -ForegroundColor DarkGray
If ($OutputBackupColor -ne $Null) {Write-Host "$OutputBackup `n" -ForegroundColor $OutputBackupColor}
Else {Write-Host "$OutputBackup `n"}

# Ausgabe Speicherplatz
Write-Host "-- Speicherplatz --`n" -ForegroundColor DarkGray
Write-Output $Freespace

##