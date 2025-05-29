{ config, lib, pkgs, ... }: {
  options = {
    polkitGnomeKeyring.enable = lib.mkEnableOption "Enable GNOME Keyring and Polkit defaults";
  };

  config = lib.mkIf config.polkitGnomeKeyring.enable {
      services.gnome.gnome-keyring.enable = true;
      security.pam.services.greetd.enableGnomeKeyring = true;
      security.pam.services.login.enableGnomeKeyring = true;
      security.polkit.enable = true;
  };
}