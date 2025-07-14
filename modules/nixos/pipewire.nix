{
  config,
  lib,
  ...
}:
{
  options = {
    pipewire.enable = lib.mkEnableOption "Enable Pipewire with Pulse, ALSA, and Jack support";
  };

  config = lib.mkIf config.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
