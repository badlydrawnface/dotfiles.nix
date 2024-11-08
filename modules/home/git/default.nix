{ pkgs, lib, config, ... }: {

  options = {
    git.enable = lib.mkEnableOption "enable git and configure gitconfig";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userEmail = "bdface@proton.me";
      userName = "badlydrawnface";
      aliases = {
        hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      };
    };
  };
}