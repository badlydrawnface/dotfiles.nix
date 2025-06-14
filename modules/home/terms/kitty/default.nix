{ lib, config, ... }: {
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
    };
  };
}