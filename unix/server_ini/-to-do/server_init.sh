#!/bin/bash

set -Euoa pipefail #-v shows everything


VERSIONID=1.2                       ## update version number here

                                                                                                            ### For Testing, 2.sh deletes all progress made from this script
                                                                                                            ### Work on CAT all .pub keys to authorized_keys // inside /tmp/notes/
                                                                                                            ### Scp of ipfile, and authorized_keys
                                                                                                            ### Add ssh-agent feature
                                                                                                            ### Add automatic config files UNIX /\ NT 
                                                                                                            ### Add custom user/email associations for SSH-KEYS
                                                                                                            ### Add ability to pull all settings from .txt file

    ### enable extglob                  
shopt -s extglob        ### (needed for creation of authorized_keys for NT users)

    # modified in the ~/.bashrc file





            ###################
            #### Variables ####
            ###################



   
USERNAME=slamp                                                                      ## Name of new sudo user (also recieves sudo permissions)

                #######################################
                ##### Creating SSH-KEYS Variables #####
                #######################################

        ## Passwds generated from passwd.py

    ## Create RSA SSH-KEYs (2048,4096 bits)
RSA_SSH_KEY_CREATION=true
        # Which encryption bit to use (leave as is for default;4096)
RSA_BIT_KEY_CREATION=4096
            # Enable custom SSH-KEY passwd
CUSTOM_RSA_PASSWD=true
                # Name the custom SSH-KEY passwd  #### ///Minimum five characters\\\
RSA_PASSWD="6*H*&!@#0gVjE066m9x"
                    #Name of SSH-KEY; Leave as is for default name
RSA_FILE_NAME="id_rsa"
    ####### Needs to be worked out to add a name/email to SSH keys //// is not functional 
#RSA_USE_DEFINED_KEY_NAME=false
#RSA_DEFINED_KEY_NAME=bob@gmail.com


    ## Create DSA SSH-KEYs (not recommended; disabled by default)
DSA_SSH_KEY_CREATION=false    
        # Enable custom SSH-KEY passwd
CUSTOM_DSA_PASSWD=true
            # Name the custom SSH-KEY passwd
DSA_PASSWD="6*H*&!@#0gVjE066m9x"
                #Name of SSH-KEY; Leave as is for default name
DSA_FILE_NAME="id_dsa"
    ####### Needs to be worked out to add a name/email to SSH keys //// is not functional 
#DSA_USE_DEFINED_KEY_NAME=false
#DSA_DEFINED_KEY_NAME=bob@gmail.com


    ## Create ECDSA SSH-KEYs (256,384,521 bits)
ECDSA_SSH_KEY_CREATION=true
        # Which encryption bit to use (leave as is for default)
ECDSA_BIT_KEY_CREATION=256
            # Enable custom SSH-KEY passwd
CUSTOM_ECDSA_PASSWD=true
                # Name the custom SSH-KEY passwd
ECDSA_PASSWD="6*H*&!@#0gVjE066m9x"
                    #Name of SSH-KEY; Leave as is for default name
ECDSA_FILE_NAME="id_ecdsa"
    ####### Needs to be worked out to add a name/email to SSH keys //// is not functional 
#ECDSA_USE_DEFINED_KEY_NAME=false
#ECDSA_DEFINED_KEY_NAME=bob@gmail.com


    ## Create ED25519 SSH-KEYs (newer and not advaible on all platforms)
ED25519_SSH_KEY_CREATION=true
        # Enable custom SSH-KEY passwd
CUSTOM_ED25519_PASSWD=true
            # Name the custom SSH-KEY passwd
ED25519_PASSWD="6*H*&!@#0gVjE066m9x"
                #Name of SSH-KEY; Leave as is for default name
ED25519_FILE_NAME="id_ed25519"
    ####### Needs to be worked out to add a name/email to SSH keys //// is not functional 
#ED25519_USE_DEFINED_KEY_NAME=false
#ED25519_DEFINED_KEY_NAME=bob@gmail.com

                ########################################
                ######## END SSH-KEYS Variables ########
                ########################################



    ## Fetch this systems IP info, make a directory, and make a file with IP info
                    ### This needs to be enabled to send keys to NT clients
WHERE_AM_I=true
SET_DHCP_STATIC_IP=false
    ## Send the IP file to 192.168.1.1 IP address, and make a directory on remote client
SEND_IP_FILE=false
FILE_CLIENT_LOGIN=sammy
FILE_CLIENT_IP=192.168.1.1

    ## Copy root users SSH keys to new sudo user $home dir
COPY_AUTHORIZED_KEYS_FROM_ROOT=true

    ## Copy new keys; root >> USERNAME; USERMAN >> root
COPY_KEYS_FROM_ROOT=true
COPY_KEYS_TO_ROOT=true

    ## Send public keys to UNIX clients (authorized_keys file,) also theIR IP address
SEND_PUBLIC_KEYS_UNIX=false
UNIX_CLIENT_LOGIN=sammy
UNIX_CLIENT_IP=192.168.1.1

    ## Send public keys to NT clients, And their IP address (WINDOWS)
SEND_PUBLIC_KEYS_NT=false
NT_CLIENT_LOGIN=sammy
NT_CLIENT_IP=192.168.1.1



    ## Update all UNIX processes
UPDATE_UPGRADE=true










            #############
            ### Logic ###
            #############

    ## Add new user and grant sudo privleges
useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
                ### Disabled
    ## Check if the root account has a real passwd set
#encrypted_root_pw="$(grep root /etc/shadow | cut --delimiter=: --fields=2)"

#if [ "${encrypted_root_pw}" != "*" ]; then
    # Transfer auto-generated root password to user if present
    # and lock the root account to password-based access
#    echo "${USERNAME}:${encrypted_root_pw}" | chpasswd --encrypted
#    passwd --lock root
#else
    # Delete invalid password for user if using keys so that a new password
    # can be set without providing a previous value
#    passwd --delete "${USERNAME}"
#fi

    ## Expires the sudo user's password immediately to force a change
            ### Functionable
chage --lastday 0 "${USERNAME}"

    ## Create SSH directory for new sudo user
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"

if [ "${SET_DHCP_STATIC_IP}" = true ]; then   
    cat dhcp_settings.txt > etc/net/plan/01-netcfg.yaml

else echo no dhcp for you

fi

                    ####################################
                    ######### SSH-KEY Creation #########
                    ####################################


    ## Create new RSA Keys if requested (2048,4096 bits)
if [ "${RSA_SSH_KEY_CREATION}" = true ]; then
    cd "${home_directory}/.ssh/" || return
        if [ "${RSA_BIT_KEY_CREATION}" = 4096 ]; then
                ## Using custom passwd
            if [[ "${CUSTOM_RSA_PASSWD}" = true ]]; then
                ssh-keygen -f "${home_directory}"/.ssh/"${RSA_FILE_NAME}" -t rsa -b 4096 -N "${RSA_PASSWD}"
                echo "rsa pass = '${RSA_PASSWD}'"
            fi
                ## Using blank passwd
            if [[ "${CUSTOM_RSA_PASSWD}" = false ]]; then
                echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${RSA_FILE_NAME}" -t rsa -b 4096
                echo 'rsa completed no pass'
            fi   
        fi
        if [ "${RSA_BIT_KEY_CREATION}" != 4096 ]; then
                ## Using custom passwd
            if [[ "${CUSTOM_RSA_PASSWD}" = true ]]; then
                ssh-keygen -f "${home_directory}"/.ssh/"${RSA_FILE_NAME}" -t rsa -N "${RSA_PASSWD}"
                echo "rsa pass = '${RSA_PASSWD}'"
            fi
                ## Using blank passwd
            if [[ "${CUSTOM_RSA_PASSWD}" = false ]]; then
                echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${RSA_FILE_NAME}" -t rsa
                echo 'rsa completed no pass'
            fi
        fi   
fi

    ## Create new DSA Keys if requested
if [ "${DSA_SSH_KEY_CREATION}" = true ]; then
    cd "${home_directory}/.ssh/"  || return

        ## Using custom passwd
    if [[ "${CUSTOM_DSA_PASSWD}" = true ]]; then
        ssh-keygen -f "${home_directory}"/.ssh/"${DSA_FILE_NAME}" -t dsa -N "${DSA_PASSWD}"
        echo "dsa completed pass = '${DSA_PASSWD}'"   
    fi

        ## Using blank passwd
    if [[ "${CUSTOM_DSA_PASSWD}" = false ]]; then
        echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${DSA_FILE_NAME}" -t dsa
        echo 'dsa completed no pass'
    fi   
fi

    ## Create new ECDSA Keys if requested (256,384,521 bit)
if [ "${ECDSA_SSH_KEY_CREATION}" = true ]; then
    cd "${home_directory}/.ssh/" || return
            ## 256 bit encryption  
        if [ "${ECDSA_BIT_KEY_CREATION}" = 256 ]; then
                ## Using custom passwd
            if [[ "${CUSTOM_ECDSA_PASSWD}" = true ]]; then
                ssh-keygen -f "${home_directory}"/.ssh/"${ECDSA_FILE_NAME}" -t ecdsa -b 256 -N "${ECDSA_PASSWD}"
                echo "ecdsa pass = '${ECDSA_PASSWD}'"
            fi
                ## Using blank passwd
            if [[ "${CUSTOM_ECDSA_PASSWD}" = false ]]; then
                echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${ECDSA_FILE_NAME}" -t ecdsa -b 256
                echo 'ecdsa completed no pass'
            fi   
        fi
            ## 384 bit encryption
        if [ "${ECDSA_BIT_KEY_CREATION}" = 384 ]; then
                ## Using custom passwd
            if [[ "${CUSTOM_ECDSA_PASSWD}" = true ]]; then
                ssh-keygen -f "${home_directory}"/.ssh/"${ECDSA_FILE_NAME}" -t ecdsa -b 384 -N "${ECDSA_PASSWD}"
                echo "ecdsa pass = '${ECDSA_PASSWD}'"
            fi
                ## Using blank passwd
            if [[ "${CUSTOM_ECDSA_PASSWD}" = false ]]; then
                echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${ECDSA_FILE_NAME}" -t ecdsa -b 384
                echo 'ecdsa completed no pass'
            fi   
        fi
            ## 521 bit encryption
        if [ "${ECDSA_BIT_KEY_CREATION}" = 521 ]; then
                ## Using custom passwd
            if [[ "${CUSTOM_ECDSA_PASSWD}" = true ]]; then
                ssh-keygen -f "${home_directory}"/.ssh/"${ECDSA_FILE_NAME}" -t ecdsa -b 521 -N "${ECDSA_PASSWD}"
                echo "ecdsa pass = '${ECDSA_PASSWD}'"
            fi
                ## Using blank passwd
            if [[ "${CUSTOM_ECDSA_PASSWD}" = false ]]; then
                echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${ECDSA_FILE_NAME}" -t ecdsa -b 521
                echo 'ecdsa completed no pass'
            fi
        fi   
fi
    
    ## Create new ED25519 Keys if requested
if [ "${ED25519_SSH_KEY_CREATION}" = true ]; then
    cd "${home_directory}/.ssh/"  || return

        ## Using custom passwd
    if [[ "${CUSTOM_ED25519_PASSWD}" = true ]]; then
        ssh-keygen -f "${home_directory}"/.ssh/"${ED25519_FILE_NAME}" -t ed25519 -N "${ED25519_PASSWD}"
        echo "script completed pass = '${ED25519_PASSWD}'"   
    fi

        ## Using blank passwd
    if [[ "${CUSTOM_ED25519_PASSWD}" = false ]]; then
        echo -e "\n\n\n\n" | ssh-keygen -f ~/.ssh/"${ED25519_FILE_NAME}" -t ed25519
        echo 'script completed no pass'
    fi
        
        
        ## Make /config file
            ## Nano > USER_CONFIG_FILE    ////\\\\    postnotes !1
    touch "${home_directory}"/.ssh/config
        ## Change permissions && Ownership for USER.ssh directory and all files inside
    chmod -R go= "${home_directory}"/.ssh
    chown -R "${USERNAME}":"${USERNAME}" "${home_directory}"/.ssh

fi



  ##### Fetch this systems IP info, make a directory, and make a /tmp/notes/notes.txt with that info
    ### This needs to be enabled to send keys to NT clients, and need to be ran first
if [ "${WHERE_AM_I}" = true ]; then
    mkdir -p /tmp/notes/
        ip a > /tmp/notes/notes.txt
fi

                    ###################################
                    ######### Copying of keys #########
                    ###################################

    ## Copy `authorized_keys` file from root if requested

if [ "${COPY_AUTHORIZED_KEYS_FROM_ROOT}" = true ]; then

    cp -r /root/.ssh/authorized_keys "${home_directory}/.ssh"    

fi
         ## Copy all SSH-KEY files to root // from USERNAME; if requested, and has files

if [ "${COPY_KEYS_TO_ROOT}" = true ]; then
    cd "${home_directory}"/.ssh/ || return
        for f in "${home_directory}"/.ssh/id*; do
                ## Check if the glob gets expanded to existing files.
                ## If not, f here will be exactly the pattern above
                ## and the exists test will evaluate to false.
             [ -e "$f" ] && cp -fr "${home_directory}".ssh/id* /root/.ssh/
            break
        done
fi
        ## Copy all SSH-KEY files from root > USERNAME if requested, and has files

if [ "${COPY_KEYS_FROM_ROOT}" = true ]; then
    cd /root/.ssh/ || return
        for f in /root/.ssh/id*; do
                ## Check if the glob gets expanded to existing files.
                ## If not, f here will be exactly the pattern above
                ## and the exists test will evaluate to false.
             [ -e "$f" ] && cp -fr /root/.ssh/id* "${home_directory}"/.ssh/
            break    
        done
fi





            ## WORKING??
    ##  Send public keys to UNIX clients (authorized_keys file,) also their IP address and client name
if [ "${SEND_PUBLIC_KEYS_UNIX}" = true ]; then
    cd /root/.ssh || return
        for f in /root/.ssh/id*; do
            ssh-copy-id "${UNIX_CLIENT_LOGIN}"@"${UNIX_CLIENT_IP}"
        break
        done      
fi

    ##  Send public keys to NT clients (authorized_keys file,) also their IP address and client name
if [ "${SEND_PUBLIC_KEYS_NT}" = true ]; then
    cd /root/.ssh || return

        for f in /root/.ssh/id*; do
            cp /root/.ssh/id* /tmp/notes/
                cd /tmp/notes/ || return
                    cat id* !. > authorized_keys


                    ## makedir on client machine                                                                                     what to do with this/not functional      
                ssh  "${NT_CLIENT_LOGIN}"@"${NT_CLIENT_IP}" "mkdir -p /tmp/123/"
                    ## copy newly cerated authorized_keys  to remote location                                                        what to do with this/not functional
                    scp /tmp/notes/authorized_key "${NT_CLIENT_LOGIN}"@"${NT_CLIENT_IP}"
    break
    done      
fi


    ## Send the IP file to 192.168.1.1 IP address, and make a directory on remote client
        ##  Send IP file to remote clients (file made from ifconfig)
            ## possibly works for both UNIX and NT clients
if [ "${SEND_IP_FILE}" = true ]; then
    cd /tmp/notes/ || return
                    ## makedir on client machine                                                                                     what to do with this/not functional      
        ssh  "${FILE_CLIENT_LOGIN}"@"${FILE_CLIENT_IP}" "mkdir -p /tmp/123/"
                        ## copy newly cerated authorized_keys  to remote location                                                        what to do with this/not functional
            scp /tmp/notes/notes.txt "${FILE_CLIENT_LOGIN}"@"${FILE_CLIENT_IP}"
fi

    ## Basic Update/upgrade installation 
if [ "${UPDATE_UPGRADE}" = true ]; then
    apt-get update | apt-get upgrade -y                   
fi


            ########################
            ###### Post Notes ######
            ########################

                        ## !1: Line ; creates config file
                        ## Example of USER_CONFIG_FILE (SSH)
                           ## Host is the login_name used in ssh (customizable/short hand)
                           ## Host "*" applies to all profiles 
#Host fedora25
#        HostName 192.168.56.15
#        Port 22
#        ForwardX11 no
#
#Host centos7
#        HostName 192.168.56.10
#        Port 22
#        ForwardX11 no
#
#Host ubuntu
#        HostName 192.168.56.5
#        Port 2222
#        ForwardX11 yes

#Host *
#        User tecmint
#        IdentityFile ~/.ssh/id_rsa
#        Protocol 2
#        Compression yes
#        ServerAliveInterval 60
#        ServerAliveCountMax 20
#        LogLevel INFO

#>>>>>>>>>>>>    Same as above, only generic     <<<<<<<<<<<<<<<<<<

#Host    host1
#	ssh_option1=value1
#	ssh_option2=value1 value2
#	ssh_option3=value1 
#
#Host    host2
#	ssh_option1=value1
#	ssh_option2=value1 value2

#Host  *
#	ssh_option1=value1
#	ssh_option2=value1 value2  








#############################################
############## Outside Scripts ##############
#############################################








##################################
############## Help ##############
##################################
Help()
{
   # Display Help
   echo
   echo "Add description of the script functions here."
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo 
}

#####################################
############## Version ##############
#####################################
Version()
{
   # Display Version 
   echo
   echo "Version $VERSIONID"
   echo
   echo "Syntax: [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo
}

#####################################
############## Verbose ##############
#####################################
Verbose()
{
   # Display Verbose 
   echo
   echo "Verbose Display"
   echo
   echo "Syntax: [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo
}

#####################################
################ GPL ################
#####################################
Gpl()
{
   # Display GPL license notification 
   echo
   echo "GPL license notification"
   echo
   echo "Syntax: [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo
}


############################################################
############################################################
#####################  Main program   ######################                      
############################################################
############################################################
############################################################
##### Process the input options. Add options as needed. ####
############################################################

# Get the options
while getopts ":hVvg" option; do
   case $option in
        h) # display Help
            Help
            exit;;
        V) # display Version
            Version
            exit;;
        v) # display Verbose mode
            Verbose
            exit;;
        g) # display GPL license notification
            GPL
            exit;;

        \?) # Invalid option
             echo "Error: Invalid option"
            exit;;
   esac
   # Get the options
done
