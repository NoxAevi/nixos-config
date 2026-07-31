{

    environment.persistence."/nix/persist" = {
        enable = true;
        hideMounts = true;

        files = [
            "/etc/machine-id"
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

        users.NoxAevi = {
            files = [];
            directories = [ 
		{ directory = ".ssh"; mode = "0700"; }
                { directory = ".dotfiles"; mode = "0700"; }
	    ];
        };
    };

}
