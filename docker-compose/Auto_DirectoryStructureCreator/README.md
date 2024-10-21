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

consolidation/
├── backups/
├── compose/
│   ├── <service1>/
│   │   └── docker-compose.yml
│   ├── <service2>/
│   │   └── docker-compose.yml
├── config/
│   ├── <service1>/
│   │   └── <service1>.config
│   ├── <service2>/
│   │   └── <service2>.config
├── db/
│   ├── <db_service1>/
│   │   └── <db_service1>.db
│   ├── <db_service2>/
│   │   └── <db_service2>.db
├── logs/
│   ├── <service1>/
│   │   └── <service1>.log
│   ├── <service2>/
│   │   └── <service2>.log
├── media/
│   ├── videos/
│   ├── musics/
│   ├── photos/
│   ├── tv/
│   └── rr_feed/
├── scripts/
│   ├── setup.sh
│   ├── backup.sh
│   ├── sync.sh
│   └── cronjobs.sh
└── keepalived/
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
