Homelab Setup Guide

Flash NixOS: Download the NixOS ARM image for Raspberry Pi 5, flash it to an SD card, and boot the Pi.
Generate Hardware Config: Run nixos-generate-config and move the generated hardware-configuration.nix to hosts/rpi5/.
Clone Repo: On your MacBook, clone this repo and edit files as needed.
Deploy: Run ./scripts/deploy.sh to sync and apply the configuration.
K3s Workloads: Use kubectl to apply manifests in k8s/rpi5/.

