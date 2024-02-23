#!/bin/bash

#################
### Variables ###
#################

USERNAME=XYZ        ## sets ~ username
home_directory="$(eval echo ~${USERNAME})"      ## sets ~ location (~ is user home)
ALIVE=$(grep -c "${USERNAME}": /etc/passwd)

#############
### Logic ###
#############

if [ "${ALIVE}" = 1 ]; then
    cd "${home_directory}" || return        #### this is just to keep the variable happy
        cd /tmp/ || return              ## change dir for no conflicts when deleteing user
    userdel -f ${USERNAME}         ## delete user
fi
cd /root/.ssh/ || return           ## changedir to root/.ssh
        rm -r /home/XYZ/                ## delete users home director
            rm -r ./id*                      ## delete all "id" ssh keys in root/.ssh dir
                rm -r ./*ed25519                ## delete ed25519 ssh keys
                    rm -r ./*ed25519.*              ## delete ed25519 public ssh keys
                        rm -r /tmp/notes/*              ## delete script created files inside notes dir
                            rm -r /tmp/notes                ## delete script created director notes

                            