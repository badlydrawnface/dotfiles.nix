{
  lib,
  config,
  ...
}:
{
  options = {
    term.kitty.enable = lib.mkEnableOption "enables kitty terminal";
  };

  config = lib.mkIf config.term.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "IosevkaNF";
        size = 13;
      };
      settings = {
        background_opacity = 0.8;
        background-blur = 1;
        window_padding_width = 4;
      };
    };
  };
}
