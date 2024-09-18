<#
.SYNOPSIS
This script gathers and prints various system information such as system model, motherboard manufacturer, 
operating system and version, BIOS serial number, system SKU, installed memory, processor model and speed, 
and hard drive information.

.DESCRIPTION
The script uses WMI (Windows Management Instrumentation) to gather system information. It then prints the 
information in a clear and easy-to-read format. It's useful for system administrators who need to quickly 
assess system details.

.LINK
https://github.com/virtualox/Get-SystemInfo.ps1
#>

<# 
.SYNOPSIS
This script gathers and prints various system information such as system model, motherboard manufacturer, 
operating system and version, BIOS serial number, system SKU, installed memory, processor model and speed, 
and hard drive information.

.DESCRIPTION
The script uses CIM (Common Information Model) to gather system information. It then prints the 
information in a clear and easy-to-read format. It's useful for system administrators who need to quickly 
assess system details.

.LINK
https://github.com/virtualox/Get-SystemInfo.ps1
#>

# Gather the data
$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
$baseBoard = Get-CimInstance -ClassName Win32_BaseBoard
$operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
$physicalMemory = Get-CimInstance -ClassName Win32_PhysicalMemory
$processor = Get-CimInstance -ClassName Win32_Processor
$diskDrive = Get-CimInstance -ClassName Win32_DiskDrive
$BIOSSerialNumber = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
$systemSKU = (Get-CimInstance -ClassName Win32_ComputerSystem).SystemSKUNumber

# Print the data in a readable format
Write-Host "System Model: $($computerSystem.Model)"
Write-Host "Motherboard Manufacturer: $($baseBoard.Manufacturer)"
Write-Host "Motherboard Product Name: $($baseBoard.Product)"
Write-Host "Operating System and Version: $($operatingSystem.Caption)"
Write-Host "BIOS Serial Number: $BIOSSerialNumber"
Write-Host "System SKU: $systemSKU"
Write-Host "Installed Memory:"
foreach ($memory in $physicalMemory) {
    $sizeGB = [math]::Round($memory.Capacity / 1GB, 2)
    Write-Host "`t$($memory.DeviceLocator): $sizeGB GB"
}
Write-Host "Processor Model and Speed: $($processor.Name), $($processor.CurrentClockSpeed) MHz"
Write-Host "Hard Drive and Partition Information:"
foreach ($disk in $diskDrive) {
    $sizeGB = [math]::Round($disk.Size / 1GB, 2)
    Write-Host "`t$($disk.Model): $sizeGB GB"
}
