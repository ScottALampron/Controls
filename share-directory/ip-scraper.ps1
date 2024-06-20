# Get the desktop path
$desktopPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop')

# Define the output file path
$outputFilePath = [System.IO.Path]::Combine($desktopPath, 'IPAddress.txt')

# Get the IP address
$ipAddress = Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -ne 'Loopback Pseudo-Interface 1' } | Select-Object -ExpandProperty IPAddress

# Export the IP address to a text file
$ipAddress | Out-File -FilePath $outputFilePath

# Output message
Write-Host "IP address exported to $outputFilePath"
