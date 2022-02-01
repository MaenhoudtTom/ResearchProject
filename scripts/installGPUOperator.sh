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
        echo "Please run the script with a path to the file to use for the kubectl config, downloadable from Rancher"
        echo "Exmple: sudo bash installGPUOperator.sh gpu-cluster.yaml"
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
echo "Downloading and installing Nvidia GPU-operator"
echo "----------------------------------------------"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh
helm repo add nvidia https://nvidia.github.io/gpu-operator && helm repo update
helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator --kubeconfig $1

if [ $? -eq 0 ]
then
	echo "----------------------------------------------"
	echo "Installed Nvidia GPU-operator"
	echo "----------------------------------------------"
fi
