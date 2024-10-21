---

---

# 🌟 **Directory Structure Creator**🌟

---

## 🚀 Overview

The **Directory Structure Creator** is a powerful Bash script designed to automate the creation of a customizable directory structure for your projects. This script simplifies the process of setting up various services, databases, and logs, allowing you to focus on what really matters—your work!

---

## ✨ Features

- **Automated Directory and File Creation**: Quickly generate a predefined structure of directories and files for multiple services.
- **Configurable via `.env` File**: Easily customize paths and options using an external `.env` file.
- **Verbose Logging**: Track the creation process with detailed logs, making it easy to troubleshoot and verify your setup.
- **Dynamic Structure**: Supports a variety of services, including backup, media, monitoring, and more.

---

## 🛠️ Getting Started


### 📋 Prerequisites

- **Bash**: Ensure you have a Bash environment available (Linux, macOS, or Windows Subsystem for Linux).
- **.env File**: Create a `.env` file in the same directory as the script to define your configurations.

### ⚙️ Installation

1. **Clone the Repository**:

   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Create a `.env` File**:
   Below is an example of how to structure your `.env` file. Customize the paths and service configurations as needed.

   ```bash
   # .env file example

   # Directories
   BASE_DIR="consolidation"
   backup_path=""
   compose_path=""
   config_path=""
   media_path=""
   db_path=""
   log_path=""
   scripts_path=""
   vip_path=""

   # Enable/Disable sections
   ENABLE_BACKUP=true
   ENABLE_MEDIA=true
   ENABLE_NETWORK=true
   ENABLE_DB=true
   ENABLE_MONITORING=true
   ENABLE_VIP=true
   ENABLE_WEB=true
   ENABLE_SCRIPTS=true
   ENABLE_LOGS=true
   VERBOSE=true  # Enable verbose output and logging to file
   ```

### 🏃‍♂️ Running the Script

1. **Make the Script Executable**:

   ```bash
   chmod +x create_structure.sh
   ```

2. **Execute the Script**:

   ```bash
   ./create_structure.sh
   ```

3. **Check the Logs**:
   If verbose logging is enabled, you can find detailed logs in `script.log`.

---

## 📂 Directory Structure

After running the script, your project will be organized as follows:

```bash

├────────────────────
|
├── backups
├── compose
│   ├── authentik
│   │   └── docker-compose.yml
│   ├── code-server
│   │   └── docker-compose.yml
│   ├── ddns
│   │   └── docker-compose.yml
│   ├── duplicati
│   │   └── docker-compose.yml
│   ├── grafana
│   │   └── docker-compose.yml
│   ├── homepage
│   │   └── docker-compose.yml
│   ├── jekyll
│   │   └── docker-compose.yml
│   ├── jellyfin
│   │   └── docker-compose.yml
│   ├── keepalived
│   │   └── docker-compose.yml
│   ├── ldap
│   │   └── docker-compose.yml
│   ├── lidarr
│   │   └── docker-compose.yml
│   ├── netdata
│   │   └── docker-compose.yml
│   ├── plex
│   │   └── docker-compose.yml
│   ├── prometheus
│   │   └── docker-compose.yml
│   ├── qbittorrent
│   │   └── docker-compose.yml
│   ├── radarr
│   │   └── docker-compose.yml
│   ├── rsync
│   │   └── docker-compose.yml
│   ├── sonarr
│   │   └── docker-compose.yml
│   ├── traefik
│   │   └── docker-compose.yml
│   └── transmission
│       └── docker-compose.yml
├── config
│   ├── authentik
│   │   └── authentik.config
│   ├── code-server
│   │   └── code-server.config
│   ├── ddns
│   │   └── ddns.config
│   ├── duplicati
│   │   └── duplicati.config
│   ├── grafana
│   │   └── grafana.config
│   ├── homepage
│   │   └── homepage.config
│   ├── jekyll
│   │   └── jekyll.config
│   ├── jellyfin
│   │   └── jellyfin.config
│   ├── keepalived
│   │   └── keepalived.config
│   ├── ldap
│   │   └── ldap.config
│   ├── lidarr
│   │   └── lidarr.config
│   ├── netdata
│   │   └── netdata.config
│   ├── plex
│   │   └── plex.config
│   ├── prometheus
│   │   └── prometheus.config
│   ├── qbittorrent
│   │   └── qbittorrent.config
│   ├── radarr
│   │   └── radarr.config
│   ├── rsync
│   │   └── rsync.config
│   ├── sonarr
│   │   └── sonarr.config
│   ├── traefik
│   │   └── traefik.config
│   └── transmission
│       └── transmission.config
├── db
├── env
│   ├── authentik.env
│   ├── code-server.env
│   ├── ddns.env
│   ├── duplicati.env
│   ├── grafana.env
│   ├── homepage.env
│   ├── jekyll.env
│   ├── jellyfin.env
│   ├── keepalived.env
│   ├── ldap.env
│   ├── lidarr.env
│   ├── netdata.env
│   ├── plex.env
│   ├── prometheus.env
│   ├── qbittorrent.env
│   ├── radarr.env
│   ├── rsync.env
│   ├── sonarr.env
│   ├── traefik.env
│   └── transmission.env
├── keepalived
├── logs
│   ├── authentik
│   │   └── authentik.log
│   ├── code-server
│   │   └── code-server.log
│   ├── ddns
│   │   └── ddns.log
│   ├── duplicati
│   │   └── duplicati.log
│   ├── grafana
│   │   └── grafana.log
│   ├── homepage
│   │   └── homepage.log
│   ├── jekyll
│   │   └── jekyll.log
│   ├── jellyfin
│   │   └── jellyfin.log
│   ├── keepalived
│   │   └── keepalived.log
│   ├── ldap
│   │   └── ldap.log
│   ├── lidarr
│   │   └── lidarr.log
│   ├── netdata
│   │   └── netdata.log
│   ├── plex
│   │   └── plex.log
│   ├── prometheus
│   │   └── prometheus.log
│   ├── qbittorrent
│   │   └── qbittorrent.log
│   ├── radarr
│   │   └── radarr.log
│   ├── rsync
│   │   └── rsync.log
│   ├── sonarr
│   │   └── sonarr.log
│   ├── traefik
│   │   └── traefik.log
│   └── transmission
│       └── transmission.log
├── media
│   ├── musics
│   ├── photos
│   ├── rr_feed
│   ├── tv
│   └── videos
└── scripts
    ├── backup.sh
    ├── cronjobs.sh
    ├── setup.sh
    └── sync.sh

74 directories, 84 files

```

---

## 🔧 Customization

You can modify the following sections in the `.env` file:

- **Service Groups**: Enable or disable various services by setting the corresponding variables to `true` or `false`.
- **Paths**: Customize the base directory and paths for backups, configurations, media, databases, logs, and scripts.

---

## 🤝 Contributing

We welcome contributions! If you have suggestions for improvements or new features, feel free to fork the repository and submit a pull request.

---

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## 📧 Contact

For any questions or feedback, please reach out via [your email or GitHub profile link].
