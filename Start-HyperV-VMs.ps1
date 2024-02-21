# Skript zum starten von Hyper-V VMs nach einen Neustart des Hosts
# Stannek GmbH - v.1.0 - 07.02.2024 - E.Sauerbier

# Parameter
$NameCRDC = 'DC01'
$NameCRFS = 'FS01'

# Starte DC, wenn noch nicht gestartet
If ((Get-VM -Name $NameCRDC -ErrorAction SilentlyContinue).State -eq "Off") {Start-VM -Name $NameCRDC}

# Warte einen Moment
Start-Sleep -Seconds 120

# Starte FS, wenn noch nicht gestartet
If ((Get-VM -Name $NameCRFS -ErrorAction SilentlyContinue).State -eq "Off") {Start-VM -Name $NameCRFS}

# Warte einen Moment
Start-Sleep -Seconds 60

# Starte die Restlichen VMs
$OfflineVMs = Get-VM | Where-Object {$_.State -eq "Off"}
foreach ($OfflineVM in $OfflineVMs) {
                Start-VM -Name $OfflineVM.Name
                Start-Sleep 10
                }
