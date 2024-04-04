# Skript zum herunterfahren von VMs
# Stannek GmbH - v.1.0 - 04.04.2024 - E.Sauerbier

$RunningVMs = Get-VM | Where State -eq "Running"
foreach ($RunningVM in $RunningVMs) {
            Write-Host "VMs auf diesen Host werden heruntergefahren"
            Stop-vm -Name $RunningVM.Name
            }