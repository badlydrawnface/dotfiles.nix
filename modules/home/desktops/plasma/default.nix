{ config, lib, pkgs, ... }: {
  options = {
    plasma.enable = lib.mkEnableOption {
      default = false;
      description = "enable extra programs for KDE Plasma";
    };
  };

  config = lib.mkIf config.plasma.enable {
    #TODO maybe more things idk
    home.packages = with pkgs; [
      #FIXME dependancy has a CVE
      #kdePackages.neochat
      kdePackages.krohnkite
      libsForQt5.kwin-dynamic-workspaces
      darkly
      breezy
    ];
  };
}
