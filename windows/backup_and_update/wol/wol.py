# wol.py
import socket
import time
import subprocess
from vars_wol import *

def send_magic_packet():
    mac_bytes = bytes.fromhex(MAC_ADDRESS.replace(':', ''))
    packet = b'\xFF' * 6 + mac_bytes * 16
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.sendto(packet, (DEVICE_IP if USE_IP_ADDRESS else BROADCAST_ADDRESS, WOL_PORT))

def ping_host(host, port):
    try:
        subprocess.check_call(['ping', '-c', '1', '-W', '1', host])
        return True
    except subprocess.CalledProcessError:
        return False

def main():
    # Ping the slave before sending the first WoL packet
    if USE_IP_ADDRESS:
        for _ in range(PING_ATTEMPTS):
            if ping_host(DEVICE_IP, PING_PORT):
                print(DEVICE_AWAKE_MSG)
                return
            time.sleep(PING_INTERVAL)
    else:
        for _ in range(PING_ATTEMPTS):
            if ping_host(BROADCAST_ADDRESS, PING_PORT):
                print(DEVICE_AWAKE_MSG)
                return
            time.sleep(PING_INTERVAL)
    
    # Send the first WoL packet
    send_magic_packet()
    print(WOL_PACKET_SENT_MSG)
    
    # Wait before sending the second WoL packet
    time.sleep(WAIT_TIME)

    # Ping the slave again after waiting
    if USE_IP_ADDRESS:
        for _ in range(PING_ATTEMPTS):
            if ping_host(DEVICE_IP, PING_PORT):
                print(DEVICE_AWAKE_MSG)
                return
            time.sleep(PING_INTERVAL)
    else:
        for _ in range(PING_ATTEMPTS):
            if ping_host(BROADCAST_ADDRESS, PING_PORT):
                print(DEVICE_AWAKE_MSG)
                return
            time.sleep(PING_INTERVAL)

    # Send the second WoL packet
    send_magic_packet()
    print(WOL_PACKET_SENT_MSG)
    print(DEVICE_ASLEEP_MSG)

if __name__ == "__main__":
    main()
