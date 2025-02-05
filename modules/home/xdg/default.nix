{ pkgs, lib, config, ... }: {

  options = {
    myXdg.enable = lib.mkEnableOption "Configure xdg defaults";
  };

  config = lib.mkIf config.myXdg.enable {
    xdg = {
      enable = true;
      # add user folders (Desktop, Documents, etc.)
      userDirs = {
        enable = true;
        createDirectories = true;
      };
      mimeApps = {
        enable = true;
        defaultApplications = {
          # file manager
          "inode/directory" = ["nemo.desktop"];
          "video/*" = ["mpv.desktop"];
          "audio/*" = ["mpv.desktop"];
          "image/*" = ["xviewer.desktop"];
          "image/jpeg" = ["xviewer.desktop"];
          "image/png" = ["xviewer.desktop"];
          "image/svg" = ["inkscape.desktop"];
          "text/*" = ["nvim.desktop"];
          "application/pdf" = ["xreader.desktop"];
          
          # browser
          "x-scheme-handler/http" = ["brave.desktop"];
          "x-scheme-handler/https" = ["brave.desktop"];
          "text/html" = ["brave.desktop"];
        };
      };
    };
  };
}
