# Homelab Repository
This repository manages the configuration for my homelab, including a Raspberry Pi 5 running NixOS with Hyprland, NeoVim, VNC, and K3s.

## Structure

- `hosts/rpi5/`: NixOS configuration files for the Raspberry Pi 5.
- `k8s/rpi5/`: Kubernetes manifests for workloads on the Raspberry Pi 5.
- `modules/`: Reusable NixOS modules.
- `scripts/`: Automation scripts for deployment and updates.
- `docs/`: Documentation for setup and troubleshooting.

## Usage

1. Clone this repository on your MacBook.
2. Edit the configuration files as needed.
3. Run `./scripts/deploy.sh` to sync and apply changes to the Raspberry Pi 5.
4. Use `kubectl` to manage K3s workloads.

For detailed setup instructions, see `docs/setup.md`.
