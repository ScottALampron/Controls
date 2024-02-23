

import os                                                               
import crypt

import importlib
import time
import auto_passwd_gen                              ## In same dir



#######################################################################################################################
######################## Generates 7 custom passwords 12-14 characters from auto_passwd_gen.py ########################
#######################################################################################################################

password0 = auto_passwd_gen.var                                                 ## import password0
importlib.reload(auto_passwd_gen)
password1 = auto_passwd_gen.var                                                 ## import password1
importlib.reload(auto_passwd_gen)
password2 = auto_passwd_gen.var                                                 ## import password2
importlib.reload(auto_passwd_gen)
password3 = auto_passwd_gen.var                                                 ## import password3
importlib.reload(auto_passwd_gen)
password4 = auto_passwd_gen.var                                                 ## import password4
importlib.reload(auto_passwd_gen)
password5 = auto_passwd_gen.var                                                 ## import password5
importlib.reload(auto_passwd_gen)
password6 = auto_passwd_gen.var                                                 ## import password6
del auto_passwd_gen



space = (" ") # is only here for testing perposes to show in "user_info"

#### Name of new sudo user (also recieves sudo permissions) From User input
user_name = input("What User name would you like us to create?\n")  ### USER NAME 

print("Hello " + user_name + ", Welcome!!!\n")           #### user in-put
passwd_prompt = input("Do you have a password you would like us to assign to you? Please enter Yes or No.\n\n\n")
if passwd_prompt == "Yes" or passwd_prompt == "yes" or passwd_prompt == "YES" or passwd_prompt == "yEs" or passwd_prompt == "yeS": 
    print("Great!")
    custom_passwd = input("What password do you have in mind?\n")
    confirm1 = input(custom_passwd + " is this correct? 'Yes' to confirm, 'No' to recieve an automated password.\n\n")
    if confirm1 == "Yes" or confirm1 == "yes" or confirm1 == "YES" or confirm1 == "yEs" or confirm1 == "yeS":
        print("Awesome, your new password is " + custom_passwd + " Give me a moment to mark that down for you!\n\n")
        custom_passwd = (custom_passwd)
    else:
        print("I will generate a new one for you now!1\n")                              ## no after entering psswd
        custom_passwd = (password0) 
else:
    print("I will generate a new one for you now!2\n")                                  ## no right away
    custom_passwd = (password0)

    
user_info = (user_name + space + custom_passwd)                              ### for testing reasons
print(user_info)                                                            ### for testing reasons
print(space)
time.sleep(2)

######################################################
################### Make new user ####################
######################################################

encPass = crypt.crypt(custom_passwd,"22")
os.system("useradd -p "+ encPass + user_name)


print("Thank you for the support.\n")



  
    
    
    
     
    
    
    

                #######################################
                ##### Creating SSH-KEYS Variables #####
                #######################################

        ## Passwds generated from passwd.py

    ## Create RSA SSH-KEYs (2048,4096 bits)
