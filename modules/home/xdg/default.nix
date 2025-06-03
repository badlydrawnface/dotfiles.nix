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
          "inode/directory" = ["org.kde.dolphin.desktop"];
          "text/plain" = ["org.kde.kate.desktop"];
          "video/*" = ["mpv.desktop"];
          "audio/*" = ["mpv.desktop"];
          "image/*" = ["org.kde.gwenview.desktop"];
          "image/jpeg" = ["org.kde.gwenview.desktop"];
          "image/png" = ["org.kde.gwenview.desktop"];
          "image/webp" = ["org.kde.gwenview.desktop"];
          "image/svg" = ["inkscape.desktop"];
          "text/*" = ["org.kde.kate.desktop"];
          "application/pdf" = ["org.kde.okular.desktop"];
          "application/zip" = ["org.kde.ark.desktop"];
          "application/tar" = ["org.kde.ark.desktop"];
          "application/7z"  = ["org.kde.ark.desktop"];
          "application/rar" = ["org.kde.ark.desktop"];

          # browser
          "x-scheme-handler/http" = ["zen-beta.desktop"];
          "x-scheme-handler/https" = ["zen-beta.desktop"];
          "text/html" = ["zen-beta.desktop"];
        };
      };
    };
  };
}
