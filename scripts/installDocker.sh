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
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
usermod -aG docker $1
echo "----------------------------------------------"
echo "Finished installing Docker"
echo "Reload shell to gain access to Docker commands"
echo "----------------------------------------------"
