{ lib, config, ... }:

{

	options.dotlink = {
		source = lib.mkOption { type = lib.types.path; };
		destination = lib.mkOption { type = lib.types.path; };
	};

	config = {
		systemd.tmpfiles.settings."dotlinks"."${config.dotlink.destination}"."L".argument = config.dotlink.source;
	};

}
