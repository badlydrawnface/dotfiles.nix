{
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.hyprlock.enable = lib.mkEnableOption "Enable hyprlock";
  };

  config = lib.mkIf config.hyprland.hyprlock.enable {
    # catppuccin.hyprlock.enable = false;
    programs.hyprlock = {
      enable = true;
      settings = {
        auth = {
          # enable fingerprint unlock
          "fingerprint:enabled" = true;
        };
      };
    };
  };
}
