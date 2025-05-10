{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/sd-card/sd-image-aarch64.nix") ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
  };

  nixpkgs.hostPlatform = "aarch64-linux";
}