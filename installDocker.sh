#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]
then
        # Stopping the script
	echo "----------------------------------------------"
        echo "This script must be run as root"
	echo "----------------------------------------------"
        exit 1
fi
# Check for parameter
if [ -z "$1" ]
then
        # Stopping the script
        echo "----------------------------------------------"
        echo "Please run the script with the name of the user that will be used to run docker commands"
        echo "Exmple: sudo bash installDocker.sh tom"
        echo "----------------------------------------------"
        exit 2
fi

echo "----------------------------------------------"
echo "Downloading and installing Docker"
echo "----------------------------------------------"
apt install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io -y
systemctl enable docker.service
systemctl enable containerd.service
usermod -aG docker tom
echo "----------------------------------------------"
echo "Finished installing Docker"
echo "Reload shell to gain access to Docker commands"
echo "----------------------------------------------"
