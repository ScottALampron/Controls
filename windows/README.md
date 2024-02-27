
# Directory Overview

This repository contains scripts and resources for setting up Wake-on-LAN (WoL) and automating backup/update tasks between a remote device (such as a Raspberry Pi) and a Windows computer. Below is an overview of the directories and their functions:

## `wol/`

- Contains scripts related to Wake-on-LAN (WoL) functionality, and set-up.

## `powershell/`

- Contains PowerShell scripts for performing system management tasks; such as calling backing-up and updating scripts from the python directory automatically.
- Running virus scans automatically; is a possible future update.

## `python/`

- Contains Python scripts for various automation tasks.
  - Such as backing up a windows computer, currently only copies files and subdirectories changed since x  amount of time.
- Currently nfs_backup are not set-up.

## `vars/`

- Contains configuration files and variables that are called into the scripts. This is done as such to make  the scripts easier to edit, and customize.

## Setup

Follow the instructions in the individual directories to configure and use the scripts for your automation needs.

## Usage

1. Customize variables and scripts according to your requirements.
2. Execute the scripts as needed for automated tasks.
  2a. Can setup an external device to send the wol (if using linux,  set-up with crontab -e,) and also can than setup windows task scheduler to automatically  execute the  powershell scripts, to fully automate the  whole  process. After its been initialized.

## Customization

- Modify variables and scripts to adapt them to your specific requirements.
- Extend functionality by adding new scripts or features.

Feel free to explore and customize the provided scripts according to your needs!
