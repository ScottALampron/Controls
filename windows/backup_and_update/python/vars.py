import datetime

# Function to parse time
def parse_time(time_str):
    try:
        # Parse the time string and set the date to today's date
        time_obj = datetime.datetime.strptime(time_str, '%H:%M:%S').time()
        return datetime.datetime.combine(datetime.datetime.today(), time_obj)
    except ValueError:
        print("Error: Invalid time format. Please use HH:MM:SS.")
        exit()

# Variables for backup.py
CUTOFF_TIME_STR = "23:40:00"  # Cut  off time for back ups
CUTOFF_TIME = parse_time(CUTOFF_TIME_STR)
# Directories / folders
BACKUP_SOURCE_DIR = "D:\\"
BACKUP_DESTINATION_DIR = "Z:\\D_drive\\"

# Variables for versioning
# Variable to control whether the version number should be added as a prefix or a suffix
VERSION_AS_PREFIX = True  # Set to True to add the version number as a prefix, False to add as a suffix
VERSIONING_ENABLED = True  # Set to False to disable versioning
VERSION_PREFIX = "V"
VERSION_SUFFIX = "_v"  # Suffix for versioning, e.g., "_v" for "_v1"
VERSION_MAX_COUNT = 3  # Maximum number of versions to keep
INCLUDE_ORIGINAL = True  # Include original file as "_original.xyz" (Boolean)


### Under construction ###
# Variables for Shutdown && updater (Choco)
SHUTDOWN_PROMPT = "Do you want to shut down the computer? (Y/N)"
SHUTDOWN_MESSAGE = "Shutting down the computer at {time}..."
SHUTDOWN_TIMEOUT_MESSAGE = "No response received. Shutting down the computer at {time}..."
BACKUP_UPDATE_SUCCESS = "Device has been backed up and updated!   :]"
NO_RESPONSE_MESSAGE = "No response received. Exiting."

