# Remote Wake-on-LAN (WoL) and Backup/Update Automation

This guide explains how to set up Wake-on-LAN (WoL) and automate backup/update tasks between a remote device (such as a Raspberry Pi) and a Windows computer.

## Overview

This setup allows you to remotely wake up a Windows computer using WoL packets sent from a Raspberry Pi, perform backup and update tasks on the Windows computer, and optionally prompt for shutdown to prevent accidental shutdown if the computer is in use.

## Files

- [wol.py](wol/wol.py): Python script to send Wake-on-LAN (WoL) packets and manage device wake-up.
- [vars_wol.py](wol/vars_wol.py): Python script containing variables used by the Wake-on-LAN (WoL) script.
- [backup_and_update.ps1](powershell/backup_and_update.ps1): PowerShell script to perform backup and update tasks on the Windows computer.
- [backup.py](python/backup.py): Python script for backing up modified files and directories since a specified time.
- [update-check.ps1](powershell/update-check.ps1): PowerShell script that checks for updates and handles system shutdown based on user input.
- [vars.py](vars/vars.py): Python script containing variables used by the backup and update scripts.

## Setup

### 1. Configure WoL on Windows Computer

- Ensure that Wake-on-LAN (WoL) is enabled in the BIOS settings of the Windows computer.
- Make note of the MAC address of the Windows computer.

### 2. Configure Scripts

- Modify the variables in `vars_wol.py` and `vars.py` according to your network configuration and requirements.
- Customize the backup and update tasks in `backup_and_update.ps1`, `backup.py`, and `update-check.ps1` as needed.

### 3. Schedule Tasks

#### Raspberry Pi (Remote Device)

- Use `crontab -e` to schedule the execution of `wol.py` at the desired time. For example:
  - 25 23 * * * python3 /path/to/wol.p

#### Windows Computer

- Use Windows Task Scheduler to schedule the execution of `backup_and_update.ps1` at the desired times.

## Usage

1. At the scheduled time, `wol.py` will run on the Raspberry Pi, sending a WoL packet to the Windows computer.
2. Upon waking up, the Windows computer will execute `backup_and_update.ps1` at the set time.
3. When the aforementioned .ps1 script executes, it will start the `backup.py` script. After that has finished, it will execute the `update-check.ps1` script.
  3a. `backup.py` will perform a backup of modified files and directories since a specified time, from a specified directory to another directory using variables.
  3b. `backup_and_update.ps1` will check if `chocolatey` is installed, prompt to install if not present, and proceed to update programs on the Windows device. After which it will prompt to shutdown, if unanswered within 5 minutes (variable), it will auto shutdown.

## Customization

- Modify variables in `vars_wol.py` and `vars.py` to adapt the scripts to your specific network and requirements.
- Customize backup and update tasks in `wol.py`, `backup_and_update.ps1`, and `backup.py` as needed.

Feel free to explore and customize the provided scripts according to your needs!

Thinking of incorporating such into an `ansible` playbook.
