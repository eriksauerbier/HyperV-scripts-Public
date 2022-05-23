# Skript zum Ausgeben der vorhandenen Cluster VMs
# Stannek GmbH - v.1.1 - 12.05.2022 - E.Sauerbier

# Parameter
$FileOutputName = "Name Cluster-VMs.csv"

$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$FileOutput = $PSScriptRoot + "\" + $FileOutputName

# Alle Cluster VMs auslesen und in CSV exportieren
Get-ClusterResource -Cluster RZCLuster | Where ResourceType -eq "Virtual Machine" | Select OwnerGroup | Export-Csv -path $FileOutput

# Alle Cluster VMs auslesen und in Shell ausgeben
Get-ClusterResource -Cluster RZCLuster | Where ResourceType -eq "Virtual Machine" | Select OwnerGroup, Name

# Aufforderung zum beenden des Skripts
Read-Host "`nZum beenden beliebige Taste drücken"