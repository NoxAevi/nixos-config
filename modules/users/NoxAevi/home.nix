{ config, pkgs, ... }:

{
    home.username = "NoxAevi";
    home.homeDirectory = "/home/NoxAevi";
    
    programs.zsh = {
        enable = true;
	shellAliases = {
	    "nrs" = "sudo nixos-rebuild switch --flake /home/NoxAevi/.dotfiles/nixos";
        };
    };

    programs.git = {
        enable = true;

        userName = "NoxAevi";
        userEmail = "example@example.com";
        extraConfig.init.defaultBranch = "main";
        extraConfig.safe.directory = "/etc/nixos";
    };
    
    home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink ../../../dotfiles/hypr;

    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
}
