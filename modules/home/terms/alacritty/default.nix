{ config, lib, pkgs, ... }: 

{
  options = {
    alacritty.enable = lib.mkEnableOption "enables alacritty terminal";
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = 13;
          normal = {
            family = "IosevkaNF";
            style = "Regular";
          };
          bold = {
            family = "IosevkaNF";
            style = "Bold";
          };
          italic = {
            family = "IosevkaNF";
            style = "Italic";
          };
          bold_italic = {
            family = "IosevkaNF";
            style = "Bold Italic";
          };
        };
        window = {
          dynamic_padding = true;
          decorations = "full";
          title = "Alacritty";
          opacity = 0.8;
        };

        colors = {
          draw_bold_text_with_bright_colors = true;
        };
        selection = {
          semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
          save_to_clipboard = true;
        };
        cursor = {
          style = "Underline";
          vi_mode_style = "None";
          unfocused_hollow = true;
          thickness = 0.15;
        };
        mouse = {
          hide_when_typing = true;
          bindings = [
            {
              mouse = "Middle";
              action = "PasteSelection";
            }
          ];
        };
        keyboard = {
          bindings = [
            {
              key = "Paste";
              action = "Paste";
            }
            {
              key = "Copy";
              action = "Copy";
            }
            {
              key = "L";
              mods = "Control";
              action = "ClearLogNotice";
            }
            {
              key = "L";
              mods = "Control";
              mode = "~Vi";
              chars = "\f";
            }
          ];
        };
      };
    };
  };
}
