# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

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

  #Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  programs.hyprland.enable = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

   environment.systemPackages = with pkgs; [
     vim
     wget
     git
   ];
  users.users.root.initialPassword = "root";
  system.stateVersion = "26.05"; # Did you read the comment?

}

