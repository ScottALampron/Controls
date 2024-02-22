import subprocess

# Update the unix system
print("Full update to the system, right meow")
subprocess.run(["sudo", "apt-get", "update"])
subprocess.run(["sudo", "apt-get", "upgrade", "-y"])
subprocess.run(["sudo", "apt-get", "dist-upgrade", "-y"])
subprocess.run(["sudo", "apt-get", "autoremove", "-y"])
subprocess.run(["sudo", "apt-get", "autoclean", "-y"])
subprocess.run(["sudo", "apt-get", "clean", "-y"])
subprocess.run(["sudo", "apt-get", "install", "-f", "-y"])
subprocess.run(["sudo", "apt-get", "install", "-y", "build-essential"])
