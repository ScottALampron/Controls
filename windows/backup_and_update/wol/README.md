# Wake-on-LAN (WoL) Script

This repository contains scripts to automate Wake-on-LAN (WoL) and device management tasks.

## Overview

The Wake-on-LAN (WoL) script allows you to wake up a device remotely using Wake-on-LAN packets. It includes functionality to ping the device before sending WoL packets and handles different scenarios based on the device's response.

## Files

- [wol.py](wol.py): Python script to send Wake-on-LAN (WoL) packets and manage device wake-up.
- [vars_wol.py](vars_wol.py): Python script containing variables used by the Wake-on-LAN (WoL) script.
- [scrape/scraper.ps1](scraper.ps1): PowerShell script to gather device information from Windows.
- [scrape/vars.ps1](vars.ps1): PowerShell enviromental variables file to customize the scraper as needed.

## Usage

1. Modify the variables in `vars_wol.py` according to your network configuration and requirements.
2. Run the `wol.py` script using Python: `python wol.py`

## Features

- **Wake-on-LAN (WoL)**: Wake up a device remotely using WoL packets.
- **Pulse check**: Ping the device before sending WoL packets to verify its status.
- **Customizable Configuration**: Customize variables in `vars_wol.py` to adapt the script to your specific setup.
- **Status Messages**: Display informative messages during script execution to indicate the device's status and actions taken.

Feel free to explore the provided scripts and customize them according to your needs.

For gathering device information from Windows, you can use the `scraper.ps1` PowerShell script.
