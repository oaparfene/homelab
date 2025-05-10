{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hyprland.nix
    ../../modules/vnc.nix
    ../../modules/common.nix
  ];

  networking.hostName = "rpi5";
  services.k3s = {
    enable = true;
    role = "server";
  };
  nixpkgs.hostPlatform = "aarch64-linux";
}