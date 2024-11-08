{ pkgs, lib, config, ... }: {
  
  options = {
    gh.enable = lib.mkEnableOption "Enable github cli";
  };

  config = lib.mkIf config.gh.enable {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}