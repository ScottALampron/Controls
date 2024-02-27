# Common TCP ports to check
$commonTCPPorts = @(
    5,    # RJE
    6,    # Echo
    7,    # Echo
    8,    # Unassigned
    9,    # WOL
    10,   # Unassigned
    11,   # Active Users
    12,    # Unassigned
    22,   # SSH
    80,   # HTTP
    8080,  # HTTP
    443,   # HTTPS
    445   # SMB
    # Add more TCP ports as needed
)

# Network interface alias
$networkInterface = "Ethernet"

# Local IP address
$localIPAddress = "192.168.1.100"

# Output file path
$outputFile = "output.txt"

# Enable error text to be sent to output file
$enableErrorText = $true
