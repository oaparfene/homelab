{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hyprland.nix
    ../../modules/vnc.nix
    ../../modules/common.nix
  ];

  raspberry-pi-nix = {
    board = "bcm2712";
    kernel-version = "v6_12_17";
    uboot.enable = true;
  };

  boot = {
    # kernelPackages = pkgs.linuxPackages_rpi5;  # Provided by raspberry-pi-nix overlay
    loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/firmware";
      };
      grub = {
        enable = false;
        # device = "nodev";
        # efiSupport = true;
        # efiInstallAsRemovable = true;
      };
      
      # Disable conflicting bootloaders
        generic-extlinux-compatible.enable = lib.mkForce true;  # Disable extlinux
        initScript.enable = lib.mkForce false;                   # Disable init script bootloader
    };
  };

  sdImage.populateFirmwareCommands = ''
    cp -r ${pkgs.fetchzip {
      url = "https://github.com/worproject/rpi5-uefi/releases/download/v0.3/RPi5_UEFI_Release_v0.3.zip";
      sha256 = "sha256-bjEvq7KlEFANnFVL0LyexXEeoXj7rHGnwQpq09PhIb0="; 
      stripRoot = false;
    }}/* firmware/
    cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2712-rpi-5-b.dtb firmware/
    cp ${config.hardware.raspberry-pi.config-output} firmware/config.txt
  '';

  networking.hostName = "rpi5";
  services.k3s = {
    enable = true;
    role = "server";
  };
  nixpkgs.hostPlatform = "aarch64-linux";

  system.stateVersion = "24.11";
}