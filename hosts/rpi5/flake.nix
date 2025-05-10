{
  description = "NixOS configuration for Raspberry Pi 5 with Hyprland and K3s";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
    nix-rpi5.url = "gitlab:vriska/nix-rpi5";
  };

  outputs = { self, nixpkgs, raspberry-pi-nix, nix-rpi5 }: 
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          raspberry-pi-nix.overlays.core
          raspberry-pi-nix.overlays.libcamera
          (final: prev: {
            linuxPackages_rpi5 = nix-rpi5.legacyPackages.${system}.linuxPackages_rpi5;
          })
        ];
      };
      edk2 = pkgs.fetchzip {
        url = "https://github.com/pftf/RPi5_UEFI/releases/download/v1.1/RPi5_UEFI_Release_v1.1.zip";
        sha256 = "sha256-ABnfxLMtY8E5KqJkrtIlPB4ML7CSFvjizCabv7i7SbU="; # is the actual hash
      };
    in
    {
      nixosConfigurations.rpi5 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs; };  # Pass the overlaid pkgs
        modules = [
          raspberry-pi-nix.nixosModules.raspberry-pi
        #   raspberry-pi-nix.nixosModules.sd-image
          ./configuration.nix
        ];
      };
      packages.${system}.sdImage = self.nixosConfigurations.rpi5.config.system.build.sdImage;
    };
}