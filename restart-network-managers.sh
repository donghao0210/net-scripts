#!/bin/bash
# batman-adv interface to use
echo "Restarting Network Managers"
sudo systemctl restart NetworkManager.service
sudo systemctl restart wpa_supplicant.service 
sudo systemctl restart dhcpcd.service
sleep 4s
echo "Done!"
