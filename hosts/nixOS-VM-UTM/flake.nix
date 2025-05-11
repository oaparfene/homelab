{
  description = "NixOS configuration for homelab VM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; # Matches your system.stateVersion
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux"; # Change to "aarch64-linux" if your VM is ARM-based
      modules = [
        ./configuration.nix
      ];
    };
  };
}