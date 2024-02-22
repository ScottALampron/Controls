# vars_wol.py

# How to reach device
# MAC address of the device to wake up (format: "XX:XX:XX:XX:XX:XX")
MAC_ADDRESS = "XX:XX:XX:XX:XX:XX"
# Boolean variable to indicate whether to use the IP address or not
USE_IP_ADDRESS = True
# IP address of the device to wake up
DEVICE_IP = "xxx.xxx.xxx.xxx" # Example IP Adress 192.168.1.1
# Port number for sending Wake-on-LAN packets
WOL_PORT = 9


# Device pulse check
# Port number to use for ping tests
PING_PORT = 80
# Number of ping attempts before sending the first Wake-on-LAN packet
PING_ATTEMPTS = 3
# Time interval (in seconds) between ping attempts
PING_INTERVAL = 5
# Time to wait (in seconds) before sending the second Wake-on-LAN packet
WAIT_TIME = 60


# Status Messages
DEVICE_AWAKE_MSG = "Device is awake!"
DEVICE_ASLEEP_MSG = "Device is asleep!"
WOL_PACKET_SENT_MSG = "Wake-on-LAN packet sent successfully!"
PING_FAILURE_MSG = "Both instances of pings failed. Device may be offline."
