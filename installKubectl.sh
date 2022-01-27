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
        echo "Please run the script with a path to the file to use for the kubectl config"
        echo "Exmple: sudo bash installKubectl.sh pathToFile"
	echo "----------------------------------------------"
        exit 2
fi

if [ -f $1 ]
then
	echo "----------------------------------------------"
	echo "File found"
	echo "----------------------------------------------"
else
	echo "----------------------------------------------"
	echo "File not found. Are you sure the path to the file is correct?"
	echo "----------------------------------------------"
	exit 3
fi

echo "----------------------------------------------"
echo "Downloading and installing Kubectl"
echo "----------------------------------------------"
apt install -y apt-transport-https ca-certificates curl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install kubectl -y

echo "----------------------------------------------"
echo "Configuring kubectl to access cluster"
echo "----------------------------------------------"
mkdir /home/tom/.kube/
mv $1 /home/tom/.kube/config

echo "----------------------------------------------"
echo "Generating autocompletion script for bash"
echo "----------------------------------------------"
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
echo "----------------------------------------------"
echo "Please reload shell to enable kubectl auto completion"
echo "----------------------------------------------"
