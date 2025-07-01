{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    wmCommon.wlsunset.enable = lib.mkEnableOption "Enable wlsunset for night light gamma control";
  };

  config = lib.mkIf config.wmCommon.wlsunset.enable {
    services.wlsunset = {
      enable = true;
      package = pkgs.wlsunset;
      # Allentown, PA
      latitude = 40.6;
      longitude = -75.4;
      temperature.night = 3500;
    };

    systemd.user.services = lib.mkForce {
      wlsunset = {
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };

        Unit = {
          Description = "Day/night gamma adjustments for Wayland";
          Documentation = [ "man:wlsunset(1)" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          Type = "exec";
          ExecStart = "${pkgs.wlsunset}/bin/wlsunset -t 2500 -l 40.6 -L -75.4";
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
          Restart = "on-failure";
          Slice = "background-graphical.slice";
        };
      };
    };

    home.packages = with pkgs; [
      wlsunset
    ];
  };
}
