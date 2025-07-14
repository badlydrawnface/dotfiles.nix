{
  lib,
  config,
  ...
}:
{
  options = {
    plymouth.enable = lib.mkEnableOption {
      default = true;
      description = "Enable Plymouth";
    };
  };

  config = lib.mkIf config.plymouth.enable {
    boot.plymouth = {
      enable = true;
    };
  };
}
