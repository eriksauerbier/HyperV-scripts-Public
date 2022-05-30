# Skript zum Anzeigen von vorhandenen Snaptshot in einem Hyper-V Cluster
# Stannek GmbH - v.1.1 - 12.05.2022 - E.Sauerbier

# Parameter
$ClusterName = "Cluster"

# Alle VirtuelleMaschinen im Cluster nach Snapshots abfragen
$SnapShots = Get-VM -ComputerName (Get-ClusterNode -Cluster $ClusterName) | Get-VMSnapshot | Select VMName,Name,SnapshotType,CreationTime,ComputerName

# Ausgabe des Ergebnis
If ($SnapShots -eq $Null) {Write-Host "`nIm Cluster $ClusterName befinden sich keine SnapShots"}
Else {Write-Host "`nIm Cluster $ClusterName befinden sich SnapShots auf folgenden VirtuelleMaschinen:" + $SnapShots.VMName}
