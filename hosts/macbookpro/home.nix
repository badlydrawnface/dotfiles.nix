{ config, darwin, pkgs, inputs, outputs, ... }: {

  home.stateVersion = "24.11";

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;
    userEmail = "bdface@proton.me";
    userName = "badlydrawnface";
    aliases = {
      hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
    };
  };

  # programs.firefox = {
  #   enable = true;
  #   profiles.mine = {
  #     isDefault = true;
  #     extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
  #       ublock-origin
  #       bitwarden
  #       sponsorblock
  #       return-youtube-dislikes
  #       enhancer-for-youtube
  #     ];
  #   };
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

}
