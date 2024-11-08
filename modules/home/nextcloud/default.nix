{ pkgs, lib, config, ... }: {
  
  options = {
    nextcloud.enable = lib.mkEnableOption "Enable nextcloud desktop client";
  };

  config = lib.mkIf config.nextcloud.enable {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}