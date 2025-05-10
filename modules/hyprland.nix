{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprland
  ];
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}