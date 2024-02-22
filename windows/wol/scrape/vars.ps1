# vars.ps1

# Output file path
$OutputFilePath = "output.txt"

# MAC address
$MacAddress = (Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }).MACAddress

# Ports to check
$PortsToCheck = @(80, 443, 3389)  # Example: HTTP, HTTPS, RDP

# IP address
$IpAddress = (Test-Connection -ComputerName localhost -Count 1).IPV4Address.IPAddressToString

# BIOS WoL status
$BiosWoLEnabled = $false  # Placeholder, customize the logic to check BIOS settings

# Windows WoL status
$WindowsWoLEnabled = (Get-WmiObject -Namespace root\StandardCimv2 -Query "SELECT * FROM MSNdis_DeviceWakeOnMagicPacketOnly").Enable

# WoL status messages
$WoLStatusMessages = @{
    $true  = "Enabled"
    $false = "Disabled"
}
