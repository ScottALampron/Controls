# vars.py
import datetime

# Variables for backup.py
CUTOFF_TIME = datetime.datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
BACKUP_SOURCE_DIR = "D:\\"
BACKUP_DESTINATION_DIR = "Z:\\"
# Variables for versioning
VERSIONING_ENABLED = True  # Set to False to disable versioning
VERSION_PREFIX = "_"
VERSION_SUFFIX = "_v"  # Suffix for versioning, e.g., "_v" for "_v1"
VERSION_MAX_COUNT = 3  # Maximum number of versions to keep
# Include original file as "_original.xyz" (Boolean)
INCLUDE_ORIGINAL = True

# Variables for Shutdown && updater (Choco)
CHOCO_INSTALL_PROMPT = "Chocolatey is not installed. Do you want to install it? (Y/N)"
CHOCO_INSTALL_SUCCESS = "Chocolatey installed successfully."
CHOCO_INSTALL_CANCEL = "Installation of Chocolatey canceled. Exiting."
SHUTDOWN_PROMPT = "Do you want to shut down the computer? (Y/N)"
SHUTDOWN_MESSAGE = "Shutting down the computer in {time} minutes..."
SHUTDOWN_TIMEOUT_MESSAGE = "No response received. Shutting down the computer in {time} minutes..."
BACKUP_UPDATE_SUCCESS = "Device has been backed-up and has been updated!   :]"
NO_RESPONSE_MESSAGE = "No response received. Exiting."
