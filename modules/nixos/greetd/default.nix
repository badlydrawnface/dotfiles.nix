{ config, lib, pkgs, ... }: {
  options = {
    greetd.enable = lib.mkEnableOption "Enable greetd and greeter";
  };

  config = lib.mkIf config.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet";
        };
      };
    };
  };
}
