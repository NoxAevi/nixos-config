# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan and modules.
            ./hardware-configuration.nix
            ./modules/bootloader/grub.nix
            ./modules/time/time.nix
            ./modules/networking/networking.nix
            ./modules/users/NoxAevi/NoxAevi.nix
            ./modules/impermanence/impermanence.nix
            ./modules/home-manager/home-manager.nix
        ];
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
   ] ++ [ inputs.zen-browser.packages."${system}".default ];

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

