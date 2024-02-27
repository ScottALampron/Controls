# backup.py
import os
import shutil
from ..vars.vars import *

def backup_since_time(cutoff_time):
    source_dir = BACKUP_SOURCE_DIR
    destination_dir = BACKUP_DESTINATION_DIR

    # Iterate through all files and directories in the source directory
    for root, dirs, files in os.walk(source_dir):
        # Calculate the destination directory corresponding to the current directory
        relative_path = os.path.relpath(root, source_dir)
        destination_root = os.path.join(destination_dir, relative_path)

        # Create the destination directory if it doesn't exist
        os.makedirs(destination_root, exist_ok=True)

        # Copy only files modified since cutoff time
        for file in files:
            source_file = os.path.join(root, file)
            destination_file = os.path.join(destination_root, file)
            modified_time = datetime.fromtimestamp(os.path.getmtime(source_file))
            if modified_time >= cutoff_time:
                # Determine the version number of the file
                versions = {}
                if VERSIONING_ENABLED:
                    for f in os.listdir(destination_root):
                        if f.startswith(file):
                            version_num = int(f.split(VERSION_PREFIX)[-1].split(VERSION_SUFFIX)[0])
                            versions[f] = version_num
                    version = versions.get(file, 0) + 1

                    # Rename the existing files if necessary
                    if version > VERSION_MAX_COUNT:
                        oldest_version = min(versions, key=versions.get)
                        os.remove(os.path.join(destination_root, oldest_version))
                        version = VERSION_MAX_COUNT
                    if INCLUDE_ORIGINAL:
                        if version == 1:
                            destination_file = os.path.join(destination_root, f"{file}_original.{file.split('.')[-1]}")
                        else:
                            destination_file = os.path.join(destination_root, f"{file}{VERSION_SUFFIX}{version}.{file.split('.')[-1]}")
                    else:
                        destination_file = os.path.join(destination_root, f"{file}{VERSION_SUFFIX}{version}.{file.split('.')[-1]}")
                shutil.copy2(source_file, destination_file)  # copy2 preserves metadata

if __name__ == "__main__":
    # Get the cutoff time from vars.py
    cutoff_time = CUTOFF_TIME
    backup_since_time(cutoff_time)
