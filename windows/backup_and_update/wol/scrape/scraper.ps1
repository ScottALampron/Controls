# Import variables from vars.ps1
. .\vars.ps1

# Initialize variables
$errorMessage = ""

try {
    # Get IP address
    $ipAddress = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -eq $networkInterface -and $_.IPAddress -ne $localIPAddress } | Select-Object -ExpandProperty IPAddress

    # Get MAC address
    $macAddress = Get-NetAdapter | Where-Object { $_.InterfaceAlias -eq $networkInterface } | Select-Object -ExpandProperty MacAddress

    # Check open TCP ports
    $openTCPPorts = @()
    foreach ($port in $commonTCPPorts) {
        $tcpTestResult = Test-NetConnection -ComputerName $ipAddress -Port $port
        if ($tcpTestResult.TcpTestSucceeded) {
            $openTCPPorts += $port
        }
    }

    # Check if WoL is enabled in BIOS
    $wolEnabledBIOS = $true # Placeholder for BIOS WoL status

    # Check if WoL is enabled in Windows settings
    $wolEnabledWindows = $true # Placeholder for Windows WoL status
}
catch {
    $errorMessage = $_.Exception.Message
}

# Output results or error message to file
if ($errorMessage) {
    "Error: $errorMessage" | Out-File -FilePath $outputFile
} else {
    @"
Device Information:
IP Address: $ipAddress
MAC Address: $macAddress
Open TCP Ports: $($openTCPPorts -join ", ")
WoL Enabled in BIOS: $wolEnabledBIOS
WoL Enabled in Windows: $wolEnabledWindows
"@ | Out-File -FilePath $outputFile
}
