{ pkgs, ... } : {
    users.users.NoxAevi = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        home = "/home/NoxAevi";
        shell = pkgs.zsh;
        initialPassword = "user";
    };

    programs.zsh.enable = true;

    environment.persistence."/nix/persist".users.NoxAevi = {

        directories = [
		{ directory = ".ssh"; mode = "0700"; }
		{ directory = ".dotfiles"; mode = "0700"; }
		{ directory = ".config/zen"; mode = "0700"; }
		{ directory = ".cache/zen"; mode = "0700"; }
	];
	files = [];
	
    };

    home-manager.users.NoxAevi = import ./home.nix;
}
