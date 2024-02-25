import csv
import vars

def read_hosts_from_csv(csv_file):
    """
    Read host IP addresses and ports from a CSV file.
    Assumes CSV format: IP,PORT
    """
    hosts = []
    with open(csv_file, 'r') as file:
        reader = csv.reader(file)
        for row in reader:
            if len(row) == 2:
                ip = row[0]
                port = row[1]
                hosts.append((ip, port))
    return hosts

def generate_hosts_file(hosts, output_file):
    # Generate a hosts file suitable for Ansible.
    with open(output_file, 'w') as file:
        for ip, port in hosts:
            file.write(f"{ip}:{port}\n")

def main():
    # Import variables from vars.py
    from vars import CSV_FILE, OUTPUT_FILE
    # Read hosts from CSV
    hosts = read_hosts_from_csv(CSV_FILE)
    # Generate hosts file
    generate_hosts_file(hosts, OUTPUT_FILE)

if __name__ == "__main__":
    main()
