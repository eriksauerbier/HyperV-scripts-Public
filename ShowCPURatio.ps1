# Dieses Skript liest den CPU Überbuchungsfaktors am Hyper-V Host aus
# Stannek GmbH - E.Sauerbier - v.1.0 - 30.05.2022

## Funktionen laden

# Funktion zum auslesen der Hyper-V Host Infos. Written by Haiko Hertes | www.hertes.net
function Get-HyperVHostInfo()
{   $vCores = ((Get-VM -ComputerName $env:COMPUTERNAME).ProcessorCount | Measure-Object -Sum).Sum

    $Property = "numberOfCores", "NumberOfLogicalProcessors"
    $CPUs = Get-Ciminstance -class Win32_Processor -Property  $Property -ComputerName $env:COMPUTERNAME| Select-Object -Property $Property 
    $Cores = ($CPUs.numberOfCores | Measure-Object -Sum).Sum
    $logCores = ($CPUs.NumberOfLogicalProcessors | Measure-Object -Sum).Sum

    $os = Get-Ciminstance Win32_OperatingSystem -ComputerName $env:COMPUTERNAME
    $MemFreePct = [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2)

    $object = New-Object -TypeName PSObject
    $object | Add-Member –MemberType NoteProperty –Name PhysicalCores –Value $Cores
    $object | Add-Member –MemberType NoteProperty –Name LogicalCores –Value $logCores
    $object | Add-Member –MemberType NoteProperty –Name VirtualCores –Value $vCores
    $object | Add-Member –MemberType NoteProperty –Name MemTotalGB -Value ([int]($os.TotalVisibleMemorySize/1mb))
    $object | Add-Member –MemberType NoteProperty –Name MemFreeGB -Value ([math]::Round($os.FreePhysicalMemory/1mb,2))
    $object | Add-Member –MemberType NoteProperty –Name MemFreePct -Value $MemFreePct

    Return $object
}

# Hyper-V Host Info auf dem Hyper-V Host abfragen
$Hostdata = Get-HyperVHostInfo -HyperVHost $env:computername

# Überbuchungsfaktor errechnen
$CPURatio = $([math]::Round(($Hostdata.VirtualCores) /  ($Hostdata.PhysicalCores),2))
$logCPURatio = $([math]::Round(($Hostdata.VirtualCores) /  ($Hostdata.LogicalCores),2))

# Ergebnis ausgeben

Write-Host "Der Host $env:computername hat $($Hostdata.PhysicalCores) physische Cores, $($Hostdata.LogicalCores) logische Cores und $($Hostdata.VirtualCores) virtuelle Cores" -ForegroundColor Green
Write-Host "Der physische Überbuchungsfaktor liegt bei 1 zu $CPURatio"
Write-Host "Der logische Überbuchungsfaktor liegt bei 1 zu $logCPURatio"
