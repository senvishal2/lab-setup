#!/bin/bash
set -e

echo "[+] Creating master node..."
multipass launch --name k8s-master --cpus 2 --memory 2G --disk 10G 22.04
multipass transfer setup-master.sh k8s-master:
multipass exec k8s-master -- bash setup-master.sh

echo "[+] Fetching join script from master..."
multipass transfer k8s-master:join.sh .

echo "[+] Creating worker nodes..."
for i in 1 2; do
  multipass launch --name k8s-worker$i --cpus 2 --memory 2G --disk 10G 22.04
  multipass transfer setup-worker.sh k8s-worker$i:
  multipass transfer join.sh k8s-worker$i:
  multipass exec k8s-worker$i -- bash setup-worker.sh
done

echo "[+] Kubernetes cluster is ready."

multipass exec k8s-master -- sudo cat /etc/kubernetes/admin.conf > ./admin.conf

CONFIG_PATH="$(pwd)/admin.conf"
grep -q '^export KUBECONFIG=' ~/.zshrc && \
  sed -i '' "s|^export KUBECONFIG=.*|export KUBECONFIG=$CONFIG_PATH|" ~/.zshrc || \
  echo "export KUBECONFIG=$CONFIG_PATH" >> ~/.zshrc
source ~/.zshrc