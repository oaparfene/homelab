{ config, pkgs, ... }:
{
  # Enable Wayland
  programs.wayland.enable = true;

  # Install Hyprland
  environment.systemPackages = with pkgs; [
    hyprland
  ];
}