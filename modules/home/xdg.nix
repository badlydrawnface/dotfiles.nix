{
  lib,
  config,
  ...
}:
{

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
          "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
          "video/*" = [ "mpv.desktop" ];
          "audio/*" = [ "mpv.desktop" ];
          "image/*" = [ "org.gnome.Loupe.desktop" ];
          "image/png" = [ "org.gnome.Loupe.desktop" ];
          "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
          "image/webp" = [ "org.gnome.Loupe.desktop" ];
          "image/svg" = [ "inkscape.desktop" ];
          "text/*" = [ "nvim.desktop" ];
	  "text/txt" = [ "nvim.desktop" ];
          "application/pdf" = [ "org.gnome.Evince.desktop" ];
          "application/exe" = [ "protontricks-launch.desktop" ];
          "application/zip" = [ "org.gnome.FileRoller.desktop" ];
          "application/tar" = [ "org.gnome.FileRoller.desktop" ];
          "application/7z" = [ "org.gnome.FileRoller.desktop" ];
          "application/rar" = [ "org.gnome.FileRoller.desktop" ];

          # browser
          "x-scheme-handler/http" = [ "zen-beta.desktop" ];
          "x-scheme-handler/https" = [ "zen-beta.desktop" ];
          "text/html" = [ "zen-beta.desktop" ];
        };
      };
    };
  };
}
