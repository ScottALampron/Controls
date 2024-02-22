# System Update Automation

This repository contains scripts for automating system updates on Debian-based Linux systems.

## Overview

The provided scripts automate the process of updating and upgrading a Debian-based Linux system. The Bash script (`update.sh`) and the Python script (`update.py`) perform the same tasks, ensuring the system is up-to-date by updating package repositories, upgrading installed packages, and performing cleanup operations.

## Scripts

- **update.sh**: Bash script to update and upgrade the system using `apt-get` commands.
- **update.py**: Python script to achieve the same functionality as `update.sh`, using the `subprocess` module to execute system commands.

## Usage

### Bash Script (`update.sh`)

To use the Bash script, simply execute it from the terminal:

```bash
./update.sh
```

### Python Script (`update.py`)

To use the Python script, run it using the Python interpreter:

```bash
python update.py
```

## Automation

It's a good practice to automate system updates to ensure that your system remains secure and up-to-date. You can schedule these scripts to run automatically at regular intervals using tools like `cron`. For example, you can add a cron job using `crontab -e` to execute the script every week:

```bash
0 0 * * 0 /path/to/update.sh
```

This cron job will run the `update.sh` script every Sunday at midnight.

## Note

Make sure to review the output of the script after automation to ensure that updates were applied successfully and no errors occurred during the process.

Feel free to customize the scripts or incorporate them into your automation workflows according to your needs!
