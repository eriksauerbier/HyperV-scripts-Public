# Skript zum Anzeigen von vorhandenen Snaptshot in einem Hyper-V Host
# Stannek GmbH - v.1.0 - 12.05.2022 - E.Sauerbier

# Alle VirtuelleMaschinen im Cluster nach Snapshots abfragen
$SnapShots = Get-VM | Get-VMSnapshot | Select VMName,Name,SnapshotType,CreationTime,ComputerName

# Ausgabe des Ergebnis
If ($SnapShots -eq $Null) {Write-Host "`nAuf dem Hyper-V Host befinden sich kein SnapShot"}
Else {Write-Host "`nAuf dem Hyper-V Host befinden sich SnapShots auf folgenden VirtuelleMaschinen:" + $SnapShots.VMName}
