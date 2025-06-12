{ pkgs, lib, config, ... }: {
  options = {
    hyprland.hyprlock.enable = lib.mkEnableOption "Enable hyprlock";
  };

  config = lib.mkIf config.hyprland.hyprlock.enable {
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