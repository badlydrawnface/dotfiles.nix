{ config, lib, pkgs, ... }: {
  options = {
    flathub.enable = lib.mkEnableOption "Enable Flatpak and add Flathub repo";
  };

  config = lib.mkIf config.flathub.enable {
    # flatpak
    services.flatpak.enable = true;

    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
} 
