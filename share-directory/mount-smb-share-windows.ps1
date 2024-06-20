# Define the folder path
$backupFolderPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Documents', 'backup')

# Check if the folder already exists
if (-Not (Test-Path -Path $backupFolderPath)) {
    # Create the backup folder
    New-Item -ItemType Directory -Path $backupFolderPath
    Write-Host "Backup folder created at $backupFolderPath"
} else {
    Write-Host "Backup folder already exists at $backupFolderPath"
}

# Define the share name
$shareName = "BackupShare"

# Remove the share if it already exists
if (Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue) {
    Remove-SmbShare -Name $shareName -Force
    Write-Host "Existing share '$shareName' removed"
}

# Create the new share with full access for everyone
New-SmbShare -Name $shareName -Path $backupFolderPath -FullAccess Everyone
Write-Host "SMB share '$shareName' created for path $backupFolderPath with full access for everyone"
