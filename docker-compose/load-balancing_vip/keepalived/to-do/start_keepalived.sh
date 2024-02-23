#!/bin/bash 
# Path: restart_keepalived.sh
echo "Restarting keepalived system service"
sudo systemctl start keepalived
echo "keepalived system service started"

