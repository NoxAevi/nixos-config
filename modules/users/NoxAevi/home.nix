{ config, pkgs, ... }:

{
    home.username = "NoxAevi";
    home.homeDirectory = "/home/NoxAevi";
    
    programs.zsh = {
        enable = true;
    };

    programs.git = {
        enable = true;

        userName = "NoxAevi";
        userEmail = "example@example.com";
        extraConfig.init.defaultBranch = "main";
        extraConfig.safe.directory = "/etc/nixos";
    };

    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
}
