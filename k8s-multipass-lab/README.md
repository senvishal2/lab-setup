# Kubernetes Cluster Automation with Multipass

## Requirements
- macOS with Homebrew
- Multipass: `brew install --cask multipass`

## Usage

To create the cluster:
```
./create.sh
```

To destroy the cluster:
```
./destroy.sh
```

Customize `setup-master.sh` or `setup-worker.sh` to suit your tools.
