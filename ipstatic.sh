#!/bin/bash

# Get the network interface name
interface=$(ip -o -4 route show to default | awk '{print $5}')

# Debugging: Print the detected interface
echo "Detected network interface: $interface"

# Define the static IP address and gateway
ip_address="192.168.0.235/24"
gateway="192.168.0.1"

# Define the DNS servers
dns_servers="192.168.0.1,8.8.8.8"

# Backup the current netplan configuration
sudo cp /etc/netplan/*.yaml /etc/netplan/backup-$(date +%F-%T)/

# Write the new netplan configuration
cat <<EOT | sudo tee /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    $interface:
      addresses:
        - $ip_address
      gateway4: $gateway
      nameservers:
        addresses: [$dns_servers]
EOT

# Apply the netplan configuration
sudo netplan apply

# Debugging: Verify the new configuration
ip addr show $interface

echo "Static IP configuration applied successfully to interface $interface."
