{ pkgs, ... } : {
    users.users.NoxAevi = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        home = "/home/NoxAevi";
        
        initialPassword = "user";
    };

    home-manager.users.NoxAevi = import ./home.nix;
}
