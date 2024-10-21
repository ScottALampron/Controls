#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Define the path to the .env file
ENV_FILE="$SCRIPT_DIR/.env"

# Check if the .env file exists
if [[ ! -f "$ENV_FILE" ]]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

# Load external variables from the .env file
source "$ENV_FILE"

# Set defaults if paths are not provided
BASE_DIR="${BASE_DIR:-consolidation}"  # Fallback to 'consolidation' if not set
backup_path="${backup_path:-$BASE_DIR/backups}"  # Default backup path
compose_path="${compose_path:-$BASE_DIR/compose}"  # Default compose path
config_path="${config_path:-$BASE_DIR/config}"  # Default config path
media_path="${media_path:-$BASE_DIR/media}"  # Default media path
db_path="${db_path:-$BASE_DIR/db}"  # Default db path
log_path="${log_path:-$BASE_DIR/logs}"  # Default log path
scripts_path="${scripts_path:-$BASE_DIR/scripts}"  # Default scripts path
vip_path="${vip_path:-$BASE_DIR/keepalived}"  # Default VIP path
DC_F="${DC_F:-docker-compose.yml}"  # Fallback for Docker Compose file name

# Set default for verbose logging
VERBOSE="${VERBOSE:-false}"

# Define log file in the same directory as this script
if [[ "$VERBOSE" = true ]]; then
    LOG_FILE="$SCRIPT_DIR/script.log"
    touch "$LOG_FILE"  # Create the log file in the script's directory
fi

# Logging function for verbose output
log_message() {
    local message="$1"
    if [[ "$VERBOSE" = true ]]; then
        echo "$message"  # Print to console
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"  # Log to file with timestamp
    fi
}

# Function to create directories and log each one
create_directory() {
    local dir="$1"
    mkdir -p "$dir"
    log_message "Directory created: $dir"
}

# Function to create files and log each one
create_file() {
    local file="$1"
    touch "$file"
    log_message "File created: $file"
}

# Function to create service directories and Docker Compose files
create_service_dirs() {
    log_message "Creating service directories and Docker Compose files..."
    for service in "${services[@]}"; do
        service_dir="$compose_path/$service"
        create_directory "$service_dir"
        create_file "$service_dir/$DC_F"
    done
}

# Create logs directory and service log files
create_logs() {
    if [ "$ENABLE_LOGS" = true ]; then
        log_message "Creating logs directory and log files..."
        for service in "${services[@]}"; do
            create_directory "$log_path/$service"
            create_file "$log_path/$service/$service.log"
        done
    fi
}

# Create DB directories and corresponding .db files
create_db_dirs() {
    if [ "$ENABLE_DB" = true ]; then
        log_message "Creating database directories and .db files..."
        for service in "${db_services[@]}"; do
            create_directory "$db_path/$service"
            create_file "$db_path/$service/$service.db"
        done
    fi
}

# Create scripts and env files
create_scripts_and_env() {
    if [ "$ENABLE_SCRIPTS" = true ]; then
        log_message "Creating scripts and environment files..."
        create_directory "$scripts_path"
        create_directory "$BASE_DIR/env"
        for script in "${scripts[@]}"; do
            create_file "$scripts_path/$script"
        done
        for env_file in "${env_files[@]}"; do
            create_file "$BASE_DIR/env/$env_file.env"
        done
    fi
}

# Create media directories
create_media_dirs() {
    if [ "$ENABLE_MEDIA" = true ]; then
        log_message "Creating media directories..."
        create_directory "$media_path"
        for subdir in "${media_subdirs[@]}"; do
            create_directory "$media_path/$subdir"
        done
    fi
}

# Create config files
create_config_files() {
    log_message "Creating config files..."
    for service in "${services[@]}"; do
        config_dir="$config_path/$service"
        create_directory "$config_dir"
        config_file="$config_dir/$service.config"
        create_file "$config_file"
    done
}

# Dynamic directory creation
create_dynamic_dirs() {
    log_message "Creating dynamic directories..."
    local directories=(
        "$compose_path"
        "$config_path"
        "$media_path"
        "$backup_path"
        "$db_path"
        "$log_path"
        "$vip_path"
    )

    for dir in "${directories[@]}"; do
        create_directory "$dir"
    done
}

# Main execution
log_message "Starting directory structure creation..."
create_dynamic_dirs
create_service_dirs
create_logs    # Create logs if enabled
create_db_dirs # Create DB if enabled
create_media_dirs # Create media directories if enabled
create_scripts_and_env # Create scripts and env files if enabled
create_config_files

log_message "Directory structure created successfully!"
