{ config, pkgs, inputs, ... }:
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
    uboot.enable = false;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi5;  # Provided by raspberry-pi-nix overlay
    loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/firmware";
      };
      grub = {
        enable = lib.mkForce true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
  };

  sdImage.populateFirmwareCommands = ''
    cp -r ${pkgs.fetchzip {
      url = "https://github.com/pftf/RPi5_UEFI/releases/download/v1.1/RPi5_UEFI_Release_v1.1.zip";
      sha256 = "sha256-ABnfxLMtY8E5KqJkrtIlPB4ML7CSFvjizCabv7i7SbU="; 
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

}