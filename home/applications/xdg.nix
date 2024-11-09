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
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps =
      let
        browser = [ "firefox.desktop" ];
        editor = [
          "nvim.desktop"
          "neovide.desktop"
        ];
        associations = {
          "application/json" = browser;
          "application/pdf" = [ "sioyek.desktop" ];

          "text/html" = browser;
          "text/xml" = browser;
          "text/plain" = editor;
          "application/xml" = browser;
          "application/xhtml+xml" = browser;
          "application/xhtml_xml" = browser;
          "application/rdf+xml" = browser;
          "application/rss+xml" = browser;
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/x-extension-xht" = browser;
          "application/x-extension-xhtml" = browser;
          "application/x-wine-extension-ini" = editor;

          "x-scheme-handler/about" = browser;
          "x-scheme-handler/ftp" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;

          "x-scheme-handler/unknown" = editor;

          "x-scheme-handler/slack" = [ "slack.desktop" ];
          "x-scheme-handler/discord" = [ "vesktop.desktop" ];

          "audio/*" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.desktop" ];
          "image/*" = [ "imv-dir.desktop" ];
          "image/gif" = [ "imv-dir.desktop" ];
          "image/jpeg" = [ "imv-dir.desktop" ];
          "image/png" = [ "imv-dir.desktop" ];
          "image/webp" = browser;
        };
      in
      {
        enable = true;
        associations.added = associations;
        associations.removed = {
          "image/*" = [ "imv.desktop" ];
          "image/gif" = [ "imv.desktop" ];
          "image/jpeg" = [ "imv.desktop" ];
          "image/png" = [ "imv.desktop" ];
        };
        defaultApplications = associations;
      };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
