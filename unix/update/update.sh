#!/bin/bash
# Update the 
echo  "Full update to the system, right meow"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo apt-get install -f -y
sudo apt-get install -y build-essential