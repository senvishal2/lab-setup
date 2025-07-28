#!/bin/bash
set -e

echo "[+] Installing dependencies on worker..."
sudo apt-get update
sudo apt-get install -y docker.io apt-transport-https curl
sudo systemctl enable docker && sudo systemctl start docker

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list 

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
sudo apt-get install -y kubelet kubeadm kubectl

echo "[+] Waiting for join.sh..."
while [ ! -f join.sh ]; do sleep 5; done

echo "[+] Joining cluster..."
sudo bash join.sh
