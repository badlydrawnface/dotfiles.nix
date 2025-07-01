{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    polkitGnomeKeyring.enable = lib.mkEnableOption "Enable GNOME Keyring and Polkit defaults";
  };

  # TODO refactor this module
  config = lib.mkIf config.polkitGnomeKeyring.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    security.polkit.enable = true;

    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory
  };
}
