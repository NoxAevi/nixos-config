# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# TODO: Have some simpler way to do symlinks (so much writing aa)
# Separate pkgs into a nix module

{ inputs, config, lib, pkgs, ... }:

#let
	#dotlink = d: s: {systemd.tmpfiles.settings.dotlinks.${s}.L.argument = d;};
#in

{
    imports =
        [ # Include the results of the hardware scan and modules.
            ./hardware-configuration.nix
	    inputs.spicetify-nix.nixosModules.default
        ];

	nixpkgs.config.allowUnfree = true;


	environment.persistence."/nix/persist" = {
		enable = true;
		hideMounts = true;

		files = [
			"/etc/machine-id" #check if needed
			"/var/lib/swapfile"
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

	swapDevices = [{
		device = "/var/lib/swapfile";
		size = 32*1024;
	}];

	systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/.config/hypr"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/hypr";

	boot.loader = {
		grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
		};
		efi.canTouchEfiVariables = true;
	};

	services.logind.settings.Login = {
		HandlePowerKey = "hibernate";
		HandlePowerKeyLongPress = "poweroff";
	};

	time.timeZone = "America/New_York";


	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

	hardware.bluetooth = {
  		enable = true;
  		powerOnBoot = true;
  		settings = {
    			General = {
     				# Shows battery charge of connected devices on supported
      				# Bluetooth adapters. Defaults to 'false'.
      				Experimental = true;
      				# When enabled other devices can connect faster to us, however
      				# the tradeoff is increased power consumption. Defaults to
      				# 'false'.
      				FastConnectable = true;
    			};
    			Policy = {
      				# Enable all controllers when they are found. This includes
      				# adapters present on start as well as adapters that are plugged
      				# in later on. Defaults to 'true'.
      				AutoEnable = true;
    			};
  		};
	};


	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};
	hardware.amdgpu = {
		overdrive.enable = true;
		opencl.enable = true;
		initrd.enable = true;
	};
	services.lact.enable = true;
	
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	programs.zsh = {
		enable = true;
	};
	systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/.zshrc"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/zsh/zshrc";
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
			{ directory = ".config/vesktop"; mode = "0700"; }
			{ directory = ".local/share/Anki2"; mode = "0700"; }
			{ directory = ".config/obsidian"; mode = "0700"; }
			{ directory = ".config/easyeffects"; mode = "0700"; }
			{ directory = "temp"; mode = "0700"; }
			"Documents"
			"Downloads"
			"Projects"
			"Books"
			"Desktop"
			"Games"
			".config/spotify"
			".cache/awww"
			".local/share/osu"
			".local/share/Steam"
			".local/share/zoxide"
			".steam"
		];
		files = [];
	};

	programs.git = {
		enable = true;
		config.init.defaultBranch = "main";
	};

  #services.flatpak.enable = true;
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
     vesktop
     obsidian
     anki
     easyeffects
     fastfetch
     waybar
     btop
     unrar
     hypridle
     hyprlock
     brightnessctl
     sdrpp
     osu-lazer-bin
     zoxide
   ] ++ [ inputs.zen-browser.packages."${system}".default ];

   services.tlp.enable = true;

   programs.spicetify = let
   	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
   in
   {
   	enable = true;

	theme = spicePkgs.themes.comfy;
	enabledExtensions = with spicePkgs.extensions; [
		adblock
		romajiConvert
	];
	enabledCustomApps = with spicePkgs.apps; [
		lyricsPlus
		marketplace
	];
   };

   hardware.rtl-sdr.enable = true;


   systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/wallpapers"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/wallpapers";
   systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/.gitconfig"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/.gitconfig";

   #dotlink "/home/NoxAevi/.config/starship.toml" "/home/NoxAevi/.dotfiles/dotfiles/starship/starship.toml";
   systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/.config/starship.toml"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/starship/starship.toml";
	systemd.tmpfiles.settings."dotlinks"."/home/NoxAevi/.config/kitty"."L".argument = "/home/NoxAevi/.dotfiles/dotfiles/kitty";
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.noto
  ];  

  programs.yazi.enable = true;
  #programs.waybar.enable = true;
  programs.steam.enable = true;
  
  users.users.root.initialPassword = "root";
  system.stateVersion = "26.05"; # Did you read the comment?

}

