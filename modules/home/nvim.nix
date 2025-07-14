{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    nvim.enable = lib.mkEnableOption {
      default = true;
      description = "Enable neovim";
    };
  };

  config = lib.mkIf config.nvim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];
    };
  };
}
