#!/bin/bash 
# Path: sht_dwn_keepalived.sh
echo "Starting to shut down keepalived system service"
sudo systemctl stop keepalived
echo "keepalived system service stopped"

