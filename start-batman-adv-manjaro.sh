#!/bin/bash
# batman-adv interface to use
echo "Stopping Network Managers"
sudo systemctl stop NetworkManager.service
sudo systemctl stop wpa_supplicant.service 
sudo systemctl stop dhcpcd.service
sudo ifconfig wlo1 down

sudo batctl if add wlo1
sudo ifconfig bat0 mtu 1468

sudo iwconfig wlo1 mode ad-hoc
sudo iwconfig wlo1 essid MeshPi
sudo iwconfig wlo1 channel 1

# Tell batman-adv this is an internet gateway
sudo batctl gw_mode server

# Enable port forwarding
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o eno0 -j MASQUERADE
sudo iptables -A FORWARD -i eno1 -o bat0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i bat0 -o eno0 -j ACCEPT

# Activates batman-adv interfaces
sudo ifconfig wlo1 up
sudo ifconfig bat0 up
sudo ifconfig bat0 192.168.199.21/24

# Copy the host files to /etc/bat-hosts
echo "Copying the lastest host files to /etc/bat-hosts"
sudo cp bat-hosts /etc/
wait
echo "Starting BATMAN..."
sleep 5s
echo "Welcome to BATMAN!"
echo "Your Interface(s):"
sudo batctl if
echo "Nodes:"
sudo batctl n