{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    fingerprint.enable = lib.mkEnableOption {
      default = false;
      description = "Enable fingerprint support";
    };
  };

  config = lib.mkIf config.fingerprint.enable {
    services.fprintd.enable = true;
    # disable fingerprint on login
    security.pam.services.login.fprintAuth = false;
    security.pam.services.hyprpolkitagent.fprintAuth = true;
    security.pam.services.greetd.fprintAuth = false;
  };
}
