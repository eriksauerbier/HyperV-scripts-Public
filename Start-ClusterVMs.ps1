# Skript zum starten von Cluster VMs nach einen Neustart des Hosts
# Stannek GmbH - v.1.0 - 07.02.2024 - E.Sauerbier

# Parameter
$NameCRDC = 'Virtueller Computer "DC01"'
$NameCRFS = 'Virtueller Computer "FS01"'

# Starte DC, wenn noch nicht gestartet
If ((Get-ClusterResource -Name $NameCRDC).State -eq "Offline") {Start-ClusterResource -Name $NameCRDC}

# Warte einen Moment
Start-Sleep -Seconds 120

# Starte FS, wenn noch nicht gestartet
If ((Get-ClusterResource -Name $NameCRFS).State -eq "Offline") {Start-ClusterResource -Name $NameCRFS}

# Warte einen Moment
Start-Sleep -Seconds 120

# Starte die Restlichen VMs
$OfflineVMs = Get-ClusterResource | Where-Object {($_.ResourceType -EQ "Virtual Machine") -and ($_.State -eq "Offline")}
foreach ($OfflineVM in $OfflineVMs) {
                Start-ClusterResource -Name $OfflineVM.Name
                Start-Sleep 10
                }
