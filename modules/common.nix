{ config, pkgs, ... }:
{
  # Enable SSH
  services.openssh.enable = true;

  # Define user
  users.users.ovi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvtG11tyOpycdCzRyb/VDSubKcCnes7VCWQfM6HxbRU ovi@Ovidius-MacBook-Pro.local"
    ];
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "man" ];
      theme = "robbyrussell";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Install NeoVim
  environment.systemPackages = with pkgs; [
    zsh
    neovim
    vim
    neofetch
    git
    wget
    ghostty
  ];

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;
}