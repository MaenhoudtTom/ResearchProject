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

echo "----------------------------------------------"
echo "Downloading and installing kubectl, kubeadm, kubelet"
echo "----------------------------------------------"

apt update
apt install -y apt-transport-https ca-certificates curl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

echo "----------------------------------------------"
echo "Generating autocompletion scripts for bash"
echo "----------------------------------------------"
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
kubeadm completion bash | sudo tee /etc/bash_completion.d/kubeadm > /dev/null
echo "----------------------------------------------"
echo "Please reload shell to enable kubectl and kubeadm auto completion"
echo "----------------------------------------------"
