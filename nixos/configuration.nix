# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan and modules.
            ./hardware-configuration.nix
        ];


	environment.persistence."/nix/persist" = {
		enable = true;
		hideMounts = true;

		files = [
			"/etc/machine-id" #check if needed
		];

		directories = [
			"/etc/nixos"
			"/var/log"
			"/var/lib/bluetooth"
			"/var/lib/nixos"
			"/var/lib/systemd/coredump"
			"/var/lib/systemd/timers"
			"/etc/NetworkManager/system-connections"
		];
	};

	systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/.config/hypr"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/hypr";

	boot.loader = {
		grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
		};
		efi.canTouchEfiVariables = true;
	};


	time.timeZone = "America/New_York";


	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};


	programs.zsh = {
		enable = true;
		shellAliases = {
			nrs = "sudo nixos-rebuild switch --flake /home/NoxAevi/.dotfiles/nixos";
			vim = "nvim";
		};
	};
	
	users.users.NoxAevi = {
		extraGroups = [ "wheel" ];
		home = "/home/NoxAevi";
		shell = pkgs.zsh;
		initialPassword = "user";

		isNormalUser = true;
	};
	
	environment.persistence."/nix/persist".users.NoxAevi = {
		directories = [
			{ directory = ".ssh"; mode = "0700"; }
			{ directory = ".dotfiles"; mode = "0700"; }
			{ directory = ".config/zen"; mode = "0700"; }
			{ directory = ".cache/zen"; mode = "0700"; } #check the zen dir if needed for persist
		];
		files = [];
	};

	programs.git = {
		enable = true;
		config.init.defaultBranch = "main";
	};

  services.flatpak.enable = true;
  programs.hyprland.enable = true;
  programs.ssh.startAgent = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

   environment.systemPackages = with pkgs; [
     neovim
     wget
     git
     kitty
     rofi
     awww
     starship
   ] ++ [ inputs.zen-browser.packages."${system}".default ];

   systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/.config/starship.toml"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/starship/starship.toml";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.noto
  ];  

  programs.yazi.enable = true;
  programs.waybar.enable = true;
  
  users.users.root.initialPassword = "root";
  system.stateVersion = "26.05"; # Did you read the comment?

}

