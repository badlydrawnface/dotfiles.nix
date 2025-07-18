{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    zed.enable = lib.mkEnableOption "Enable Zed, configure settings and extensions";
  };

  config = lib.mkIf config.zed.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "catppuccin"
        "html"
        "nix"
        "toml"
        "pylsp"
        "csharp"
        "lua"
      ];
      userSettings = {
        "ui_font_size" = 16;
        "ui_font_family" = "Adwaita Sans";
        "buffer_font_size" = 16;
        "buffer_font_family" = "Iosevka Nerd Font";

        "gutters" = {
          "folds" = false;
        };

        "languages" = {
          "Nix" = {
            "tab_size" = 2;
          };
          "Css" = {
            "tab_size" = 4;
          };
        };
      };
      installRemoteServer = true;
      extraPackages = with pkgs; [
        nixd
        nil
        jq
        lua-language-server
        package-version-server
      ];
    };
  };
}
