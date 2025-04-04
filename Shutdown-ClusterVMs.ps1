# Skript zum herunterfahren von VMs und Host durch USV in einem Cluster
# Stannek GmbH - v.1.2 - 31.03.2025 - E.Sauerbier

# Cluster auslesen
$Cluster = get-cluster -Domain $env:USERDOMAIN

# Cluster Knoten ermitteln
$ClusterNodes = Get-ClusterNode -Cluster $Cluster

# laufenden VMs auslesen und herunterfahren 
Foreach ($ClusterNode in $ClusterNodes) {
        $RunningVMs = Get-VM -ComputerName $ClusterNode.Name | Where State -eq "Running"
        # einzelne VM herunterfahren
        foreach ($RunningVM in $RunningVMs) {
           # VMs mit Servername abgleichen 
           If ($RunningVM.Name -ne $env:ComputerName) {
                Write-Host "VM $($RunningVM.Name) auf dem Node $($ClusterNode.Name) wird heruntergefahren"
                Stop-vm -ComputerName $ClusterNode.Name -Name $RunningVM.Name
                }            
            }
        
        }

# 1 Minute warten
Start-Sleep -Seconds 60

# Server herunterfahren
Stop-Computer -ComputerName Localhost