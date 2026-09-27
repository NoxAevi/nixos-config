{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    impermanence = {
	url = "github:nix-community/impermanence";
	inputs.nixpkgs.follows = "";
	inputs.home-manager.follows = "";
    };
    zen-browser = {
	url = "github:0xc000022070/zen-browser-flake";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, impermanence, ... }@inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};

        system = "x86_64-linux";
        modules = [
            ./configuration.nix
            impermanence.nixosModules.impermanence
        ];
    };
  };
}
