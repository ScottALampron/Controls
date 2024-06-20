
# PowerShell Script to Create a Backup Folder and Enable SMB Sharing

This PowerShell script performs the following tasks:
1. Defines the path for a backup folder in the current user's Documents directory.
2. Checks if the backup folder already exists; if not, it creates the folder.
3. Defines a name for the SMB share.
4. Removes any existing SMB share with the same name to avoid conflicts.
5. Creates a new SMB share with full access for everyone on the network.

## Script Explanation

### Define the Folder Path

```powershell
$backupFolderPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Documents', 'backup')
```

- This line combines the current user's profile path with the `Documents` directory and the desired `backup` folder name to define the path for the backup folder.

### Check if the Folder Already Exists

```powershell
if (-Not (Test-Path -Path $backupFolderPath)) {
    # Create the backup folder
    New-Item -ItemType Directory -Path $backupFolderPath
    Write-Host "Backup folder created at $backupFolderPath"
} else {
    Write-Host "Backup folder already exists at $backupFolderPath"
}
```

- This block checks if the backup folder already exists using the `Test-Path` cmdlet.
- If the folder does not exist, it creates the folder using `New-Item -ItemType Directory`.
- It prints a message indicating whether the folder was created or if it already existed.

### Define the Share Name

```powershell
$shareName = "BackupShare"
```

- This line sets the name for the SMB share as "BackupShare".

### Remove the Share if it Already Exists

```powershell
if (Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue) {
    Remove-SmbShare -Name $shareName -Force
    Write-Host "Existing share '$shareName' removed"
}
```

- This block checks if an SMB share with the name "BackupShare" already exists using the `Get-SmbShare` cmdlet.
- If the share exists, it removes it using `Remove-SmbShare -Force`.
- It prints a message indicating that the existing share was removed.

### Create the New Share with Full Access for Everyone

```powershell
New-SmbShare -Name $shareName -Path $backupFolderPath -FullAccess Everyone
Write-Host "SMB share '$shareName' created for path $backupFolderPath with full access for everyone"
```

- This line creates a new SMB share named "BackupShare" for the backup folder path using the `New-SmbShare` cmdlet.
- It grants full access to everyone on the network.
- It prints a message indicating that the SMB share was created successfully.

## How to Run the Script

1. **Save the Script**: Save the script to a file with a `.ps1` extension, e.g., `CreateBackupAndShare.ps1`. Or just download the file from here.
2. **Open PowerShell**: Open PowerShell with administrative privileges (necessary for creating SMB shares).
3. **Execute the Script**: Navigate to the directory containing the script and run it using `.\CreateBackupAndShare.ps1`.

This script ensures that the `backup` folder is created in the user's Documents directory and shared over the network with full access for everyone.