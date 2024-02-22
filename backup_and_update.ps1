# backup_and_update.ps1

# Start the backup script and wait for it to finish
Write-Host "Starting backup script..."
Start-Process -FilePath "python.exe" -ArgumentList "..\python\backup.py" -Wait

# Start the update script
Write-Host "Starting update script..."
.\update-check.ps1
