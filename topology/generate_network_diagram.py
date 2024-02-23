# generate_diagram.py

import nmap
import networkx as nx
import matplotlib.pyplot as plt
import subprocess
from vars import *

def scan_network(target_network, nmap_results_file_path):
    nm = nmap.PortScanner()
    nm.scan(hosts=target_network, arguments='-sP -oG {}'.format(nmap_results_file_path))

def generate_network_diagram(nmap_results_file_path, diagram_file_path):
    G = nx.Graph()

    with open(nmap_results_file_path, 'r') as file:
        for line in file:
            if 'Host:' in line:
                parts = line.strip().split()
                ip_address = parts[1]
                G.add_node(ip_address)

    pos = nx.spring_layout(G)
    nx.draw(G, pos, with_labels=True, node_size=2000, node_color='skyblue', font_size=10, font_weight='bold')

    plt.savefig(diagram_file_path)
    plt.close()

def check_install_requirements():
    if enable_requirements_installation:
        try:
            with open('requirements.txt', 'r') as f:
                requirements = f.readlines()
                requirements = [req.strip() for req in requirements]

            print("Checking and installing required libraries...")
            for req in requirements:
                __import__(req)
                print(f"{req} is already installed.")
        except ImportError:
            print(f"Installing {req}...")
            subprocess.check_call(["pip", "install", req])
    else:
        print("Requirements installation is disabled.")

def main():
    check_install_requirements()

    # Scan network using Nmap
    scan_network(target_network, nmap_results_file_path)

    # Generate network diagram
    generate_network_diagram(nmap_results_file_path, diagram_file_path)

if __name__ == '__main__':
    main()
