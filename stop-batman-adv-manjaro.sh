#!/bin/bash
# batman-adv interface to use
echo "Restarting Network Managers"
echo "Stopping BATMAN ..."
sudo systemctl restart NetworkManager.service
sudo systemctl restart wpa_supplicant.service 
sudo systemctl restart dhcpcd.service
sudo ifconfig wlo1 up
echo "BATMAN-adv: Goodbye!"
