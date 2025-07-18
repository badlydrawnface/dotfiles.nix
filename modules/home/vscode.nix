{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    vscode.enable = lib.mkEnableOption {
      default = true;
      description = "Enable Visual Studio Code";
    };
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      profiles.default = {
        userSettings = {
          "[nix]"."editor.tabSize" = 2;
          "editor.fontFamily" = "Iosevka NF";
          "editor.fontSize" = 16;
          "editor.semanticHighlighting.enabled" = true;
          "terminal.integrated.fontSize" = 16;
          "workbench.iconTheme" = "catppuccin-${config.catppuccin.flavor}";
          "window.titleBarStyle" = "custom";
          "explorer.confirmDelete" = false;

          # hide update notifications
          "update.mode" = "none";
        };
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          # kinda defeats the purpose of vscode with all the copilot icons
          # github.copilot
          # github.copilot-chat
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          gruntfuggly.todo-tree
          rust-lang.rust-analyzer
          ms-vsliveshare.vsliveshare
          ms-python.python
          dart-code.flutter
        ];
      };
    };
  };
}
