# /etc/nixos/flake.nix
{
  description = "NixOS home-ops";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Secret management
    sops-nix.url = "github:Mic92/sops-nix";

    # MicroVM
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs@{ self, nixpkgs, unstable, sops-nix, microvm, home-manager
    , nixvim, ... }: {

      # NixOS configuration for B660-i5-13600 (host)
      nixosConfigurations.b660-i5-13600 = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          pkgs-unstable = import unstable {
            config.allowUnfree = true;
            inherit system;
          };
        };

        modules = [
          sops-nix.nixosModules.sops
          microvm.nixosModules.host
          ./hosts/b660-i5-13600
          ./profiles
          ./modules
          ./modules/virtual/k3s-home/default.nix
        ];
      };

      # Laptop (dev machine)
      nixosConfigurations.dell-i5-7300U = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops
          ./hosts/dell-i5-7300U
          ./profiles/workstation.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              sharedModules = [ nixvim.homeManagerModules.nixvim ];
              users = { sebastiaan = import ./home/modules/default.nix; };
            };
          }
        ];
      };
    };
}
