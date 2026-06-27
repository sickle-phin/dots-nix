{ config, pkgs, ... }:
{
  xdg = {
    enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      config = {
        common.default = [ "gtk" ];
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };
      extraPortals = [
        config.wayland.windowManager.hyprland.portalPackage
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    mimeApps =
      let
        browser = "firefox.desktop";
        editor = "nvim.desktop";
        associations = {
          "application/json" = [ editor ];
          "application/pdf" = [ browser ];
          "application/vnd.comicbook+zip" = [ browser ];
          "application/vnd.comicbook-rar" = [ browser ];
          "application/x-bzpdf" = [ browser ];
          "application/x-ext-pdf" = [ browser ];
          "application/x-gzpdf" = [ browser ];
          "application/x-zerosize" = [ editor ];
          "application/xhtml+xml" = [ browser ];
          "audio/aac" = [ "mpv.desktop" ];
          "audio/mpeg" = [ "mpv.desktop" ];
          "audio/ogg" = [ "mpv.desktop" ];
          "audio/wav" = [ "mpv.desktop" ];
          "audio/webm" = [ "mpv.desktop" ];
          "audio/x-flac" = [ "mpv.desktop" ];
          "image/avif" = [ "imv-dir.desktop" ];
          "image/bmp" = [ "imv-dir.desktop" ];
          "image/gif" = [ "imv-dir.desktop" ];
          "image/jpeg" = [ "imv-dir.desktop" ];
          "image/png" = [ "imv-dir.desktop" ];
          "image/svg+xml" = [ "imv-dir.desktop" ];
          "image/webp" = [ "imv-dir.desktop" ];
          "inode/directory" = [ "yazi.desktop" ];
          "text/html" = [ browser ];
          "text/plain" = [ editor ];
          "text/x-c++src" = [ editor ];
          "text/x-csrc" = [ editor ];
          "text/x-python" = [ editor ];
          "text/x-shellscript" = [ editor ];
          "video/avi" = [ "mpv.desktop" ];
          "video/mp4" = [ "mpv.desktop" ];
          "video/mpeg" = [ "mpv.desktop" ];
          "video/quicktime" = [ "mpv.desktop" ];
          "video/webm" = [ "mpv.desktop" ];
          "video/x-matroska" = [ "mpv.desktop" ];
          "video/x-msvideo" = [ "mpv.desktop" ];
          "x-scheme-handler/calendar" = [ "com.danklinux.dankcalendar.desktop" ];
          "x-scheme-handler/file" = [ "yazi.desktop" ];
          "x-scheme-handler/http" = [ browser ];
          "x-scheme-handler/https" = [ browser ];
          "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
          "x-scheme-handler/slack" = [ "slack.desktop" ];
          "x-scheme-handler/discord" = [ "vesktop.desktop" ];
        };
      in
      {
        enable = true;
        associations = {
          added = associations;
          removed = {
            "image/bmp" = [ "imv.desktop" ];
            "image/gif" = [ "imv.desktop" ];
            "image/jpeg" = [ "imv.desktop" ];
            "image/png" = [ "imv.desktop" ];
            "image/svg+xml" = [ "imv.desktop" ];
            "image/webp" = [ "imv.desktop" ];
          };
        };
        defaultApplications = associations;
      };

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;
    };
  };
}
