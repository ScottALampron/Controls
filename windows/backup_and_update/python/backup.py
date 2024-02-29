import sys
import os
import datetime
import shutil

# Get the current directory of the script
#script_dir = os.path.dirname(os.path.realpath(__file__))
# Move up one directory to access the vars folder
#parent_dir = os.path.abspath(os.path.join(script_dir, os.pardir))
# Add the vars folder to the Python path
#sys.path.append(os.path.join(parent_dir, 'vars'))
# Import variables from vars.py
from vars import *


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
            modified_time = datetime.datetime.fromtimestamp(os.path.getmtime(source_file))
            
            # Check if the source file has been modified since the cutoff time
            if modified_time >= cutoff_time:
                # Check if the destination file exists
                if os.path.exists(destination_file):
                    # Check if the source file is newer than the destination file
                    if modified_time > datetime.datetime.fromtimestamp(os.path.getmtime(destination_file)):
                        # Implement versioning
                        if VERSIONING_ENABLED:
                            # Get the list of existing versions
                            versions = [f for f in os.listdir(destination_root) if f.startswith(file) and VERSION_SUFFIX in f]
                            # Sort the versions based on modification time
                            versions.sort(key=lambda x: os.path.getmtime(os.path.join(destination_root, x)), reverse=True)
                            # Keep only the last VERSION_MAX_COUNT versions
                            versions_to_keep = versions[:VERSION_MAX_COUNT-1]  # Leave one less version for the new one
                            # Remove old versions
                            for old_version in set(versions) - set(versions_to_keep):
                                os.remove(os.path.join(destination_root, old_version))
                            # Determine the version number for the new file
                            latest_version = max([int(f.split(VERSION_SUFFIX)[-1].split('.')[0]) for f in versions_to_keep], default=0)
                            version = latest_version + 1
                            # Construct destination file name with version number
                            if VERSION_AS_PREFIX:
                                destination_file = os.path.join(destination_root, f"{VERSION_PREFIX}{version}_{file}")
                            else:
                                destination_file = os.path.join(destination_root, f"{file}_{VERSION_SUFFIX}{version}")
                            shutil.copy2(source_file, destination_file)  # copy2 preserves metadata
                        else:
                            shutil.copy2(source_file, destination_file)  # copy2 preserves metadata
                else:
                    # Add "_original" suffix for the first backup
                    if INCLUDE_ORIGINAL and not os.path.exists(os.path.join(destination_root, f"{file}_original.{file.split('.')[-1]}")):
                        original_file = os.path.join(destination_root, f"{file}_original.{file.split('.')[-1]}")
                        shutil.copy2(source_file, original_file)  # copy2 preserves metadata
                    else:
                        shutil.copy2(source_file, destination_file)  # copy2 preserves metadata

if __name__ == "__main__":
    # Get the cutoff time from vars.py
    cutoff_time = CUTOFF_TIME
    backup_since_time(cutoff_time)
