{
  lib,
  config,
  ...
}:
{

  options = {
    git.enable = lib.mkEnableOption "enable git and configure gitconfig";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "badlydrawnface";
          email = "bdface@proton.me";
        };
        alias = {
          hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
        };
        core = {
          filemode = false;
        };
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
