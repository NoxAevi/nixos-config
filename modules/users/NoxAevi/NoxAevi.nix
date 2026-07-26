{ pkgs, ... } : {
    users.users.NoxAevi = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        home = "/home/NoxAevi";
        shell = pkgs.zsh;
        initialPassword = "user";
    };

    programs.zsh.enable = true;

    home-manager.users.NoxAevi = import ./home.nix;
}
