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
          "inode/directory" = ["yazi.desktop"];
          "video/*" = ["mpv.desktop"];
          "audio/*" = ["mpv.desktop"];
          "image/*" = ["swappy.desktop"];
          "image/png" = ["swappy.desktop"];
          "image/jpeg" = ["swappy.desktop"];
          "image/webp" = ["swappy.desktop"];
          "image/svg" = ["inkscape.desktop"];
          "text/*" = ["nvim.desktop"];
          "application/pdf" = ["org.gnome.Evince.desktop"];
          "application/exe" = ["protontricks-launch.desktop"];
          "application/zip" = ["org.gnome.FileRoller.desktop"];
          "application/tar" = ["org.gnome.FileRoller.desktop"];
          "application/7z"  = ["org.gnome.FileRoller.desktop"];
          "application/rar" = ["org.gnome.FileRoller.desktop"];

          # browser
          "x-scheme-handler/http" = ["zen-beta.desktop"];
          "x-scheme-handler/https" = ["zen-beta.desktop"];
          "text/html" = ["zen-beta.desktop"];
        };
      };
    };
  };
}
