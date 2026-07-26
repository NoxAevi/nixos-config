{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            ./configuration.nix
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
        ];
    };
  };
}
