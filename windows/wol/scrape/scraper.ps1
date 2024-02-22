#scraper.ps1
# Import variables from vars.ps1
. .\vars.ps1

# Check open ports
$openPorts = Test-NetConnection -ComputerName localhost -Port $PortsToCheck | Where-Object { $_.TcpTestSucceeded -eq $true } | Select-Object -ExpandProperty RemotePort

# Output results to text file
$output = @"
MAC Address: $($MacAddress)
Open Ports: $($openPorts -join ", ")
IP Address: $($IpAddress)
WoL Enabled in BIOS: $($WoLStatusMessages[$BiosWoLEnabled])
WoL Enabled in Windows: $($WoLStatusMessages[$WindowsWoLEnabled])
"@

$output | Out-File -FilePath $OutputFilePath
