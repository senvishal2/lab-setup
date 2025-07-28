#!/bin/bash
echo "[+] Deleting all Kubernetes VMs..."
multipass delete --purge k8s-master k8s-worker1 k8s-worker2
echo "[+] All VMs destroyed."
