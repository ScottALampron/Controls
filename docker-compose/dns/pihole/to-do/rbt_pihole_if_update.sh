cat <<\EOF | sudo tee /usr/local/sbin/rbt_pihole_if_update.sh
#!/bin/bash 
PIHOLE_UPDATE="$(pihole -up --check-only)"
if ! grep -q 'Everything is up to date' <<< "${PIHOLE_UPDATE}" ; then
  pihole -up
  if [[ $? -eq 0 ]] ; then
    echo "$(date "+%h %d %T") update: success" >> /var/log/pihole.log
    reboot
  fi
else
    echo "$(date "+%h %d %T") update: nothing to do" >> /var/log/pihole.log
fi
EOF