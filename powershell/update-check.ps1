# update-check.ps1

# Import variables from vars.py
. ..\vars.vars

# Function to check if Chocolatey is installed
function CheckChocolatey {
    $chocoPath = Get-Command choco -ErrorAction SilentlyContinue
    if (-not $chocoPath) {
        # Chocolatey is not installed, prompt to install
        $installChoco = Read-Host $CHOCO_INSTALL_PROMPT
        if ($installChoco -eq "Y" -or $installChoco -eq "y") {
            # Install Chocolatey
            iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
            Write-Host $CHOCO_INSTALL_SUCCESS
        }
        else {
            # User chose not to install Chocolatey
            Write-Host $CHOCO_INSTALL_CANCEL
            Exit
        }
    }
}

# Function to update programs using Chocolatey
function UpdatePrograms {
    # Check if Chocolatey is installed
    CheckChocolatey

    # Update programs using Chocolatey
    choco upgrade all -y
}

# Call the function to update programs
UpdatePrograms

# Prompt for shutdown
$shutdownPrompt = Read-Host $SHUTDOWN_PROMPT
if ($shutdownPrompt -eq "Y" -or $shutdownPrompt -eq "y") {
    # Get the shutdown grace period from vars.py
    $shutdownGracePeriod = $SHUTDOWN_GRACE_PERIOD
    Write-Host $SHUTDOWN_MESSAGE.Replace("{time}", $shutdownGracePeriod)
    Start-Sleep -Seconds ($shutdownGracePeriod * 60)
    shutdown /s /f /t 0  # Shutdown immediately
}
elseif ($shutdownPrompt -eq "N" -or $shutdownPrompt -eq "n") {
    Write-Host $BACKUP_UPDATE_SUCCESS
}
elseif ($shutdownPrompt -ne "") {
    # Get the shutdown timeout for no response from vars.py
    $shutdownTimeout = $SHUTDOWN_TIMEOUT
    Write-Host $SHUTDOWN_TIMEOUT_MESSAGE.Replace("{time}", $shutdownTimeout)
    Start-Sleep -Seconds ($shutdownTimeout * 60)
    shutdown /s /f /t 0  # Shutdown immediately
}
else {
    Write-Host $NO_RESPONSE_MESSAGE
}
