# Homelab Control Scripts

Welcome to my homelab control scripts repository!

## Overview

This repository contains a collection of scripts designed to automate various tasks in my homelab environment. Currently, the main functionalities include:

- **Wake-on-LAN (WoL) Script**: Sends Wake-on-LAN (WoL) packets to wake up a remote Windows computer.
- **Backup and Update Scripts**: Automates backup and software update tasks on a Windows computer.

These scripts provide a foundation for managing and maintaining my homelab infrastructure, with plans to add more scripts and functionalities in the future.

## Contents

- `wol.py`: Python script for sending Wake-on-LAN (WoL) packets to wake up a remote Windows computer.
- `backup_and_update.ps1`: PowerShell script to automate backup and software update tasks on a Windows computer.

## Setup

To use these scripts in your own homelab environment, follow these steps:

1. Clone this repository to your local machine.
2. Customize the variables in the `vars.py` and `vars_wol.py` files according to your specific requirements.
3. Install any necessary dependencies (specified in each script's documentation).
4. Schedule the scripts to run at appropriate intervals using cronjobs, Task Scheduler, or other scheduling tools.

The `vars.py` and `vars_wol.py` files contain all the variables that need to be customized to adapt the scripts to your specific network and requirements.

## Contributing

If you have suggestions for improvements or new scripts to add, feel free to open an issue or submit a pull request. Contributions are welcome and appreciated!

Stay tuned for more updates and functionalities to come!

Happy automating!
