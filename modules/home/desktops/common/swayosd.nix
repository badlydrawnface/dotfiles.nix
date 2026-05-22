{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    wmCommon.swayosd.enable = lib.mkEnableOption {
      default = true;
      description = "Enable swayosd";
    };
  };

  config = lib.mkIf config.wmCommon.swayosd.enable {
    services.swayosd = {};
  };
}
