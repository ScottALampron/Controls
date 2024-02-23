#!/bin/bash

## From terminal in  codeserver  to send to client
## scp -r server/ sammy@192.168.1.2:/tmp/

apt-get update
apt-get upgrade -y

USERNAME=k3s

RSA_FILE_NAME="id_rsa"
ED25519_FILE_NAME="id_ed25519"

#############
### Logic ###
#############

useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
chage --lastday 90 "${USERNAME}" ## Change user passwd in 90 days

## Create SSH directory for new sudo user
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"

echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${RSA_FILE_NAME}" -t rsa -C "$HOSTNAME"@chaos

echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${ED25519_FILE_NAME}" -t ed25519 -C "$HOSTNAME"@chaos

mkdir -p /home/"${USERNAME}"/.ssh/
cp -r ssh/* /home/"${USERNAME}"/.ssh/
cp -r ssh/* /root/.ssh/

cp -r /root/.ssh/* /home/"${USERNAME}"/.ssh/

cp -r "${home_directory}"/.ssh/* /root/.ssh/

cp -r etc/ssh/* /etc/ssh/
mkdir -p /tmp/"$HOSTNAME"/
ip a >/tmp/"$HOSTNAME"/"$HOSTNAME"_ip.txt
cp -r "${home_directory}/.ssh/" /tmp/"$HOSTNAME"/

chmod -R go= "${home_directory}"/.ssh
chown -R "${USERNAME}":"${USERNAME}" "${home_directory}"/.ssh

systemctl restart ssh
systemctl restart sshd

scp -r /tmp/"$HOSTNAME"/ anna:/tmp/
