{
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.hyprsunset.enable = lib.mkEnableOption "Enable hyprsunset";
  };

  config = lib.mkIf config.hyprland.hyprsunset.enable {
    services.hyprsunset = {
      enable = true;
      transitions = {
        sunrise = {
          calendar = "*-*-* 06:00:00";
          requests = [
            [
              "temperature"
              "6500"
            ]
            [ "gamma 100" ]
          ];
        };
        sunset = {
          calendar = "*-*-* 20:00:00";
          requests = [
            [
              "temperature"
              "3500"
            ]
          ];
        };
      };
    };
  };
}
