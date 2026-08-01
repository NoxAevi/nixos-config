{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    impermanence = {
	url = "github:nix-community/impermanence";
	inputs.nixpkgs.follows = "";
	inputs.home-manager.follows = "";
    };
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
	url = "github:0xc000022070/zen-browser-flake";
	inputs.nixpkgs.follows = "nixpkgs";
	inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... }@inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};

        system = "x86_64-linux";
        modules = [
            ./configuration.nix
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
        ];
    };
  };
}
