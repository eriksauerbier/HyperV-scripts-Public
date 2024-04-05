# Skript zum herunterfahren von VMs und Host durch USV
# Stannek GmbH - v.1.1 - 05.04.2024 - E.Sauerbier

# laufenden VMs auslesen
$RunningVMs = Get-VM | Where State -eq "Running"

# einzelne VM herunterfahren
foreach ($RunningVM in $RunningVMs) {
            Write-Host "VMs auf diesen Host werden heruntergefahren"
            Stop-vm -Name $RunningVM.Name
            }

# 1 Minute warten
Start-Sleep -Seconds 60

# Host herunterfahren
Stop-Computer -ComputerName Localhost