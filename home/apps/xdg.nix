{ config, pkgs, ... }:
{
  xdg = {
    enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [ "gtk" ];
        hyprland.default = [
          "hyprland"
          "gtk"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications =
        let
          browser = [ "firefox.desktop" ];
          editor = [
            "nvim.desktop"
            "neovide.desktop"
          ];
        in
        {
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
          "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop " ];

          "audio/*" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.desktop" ];
          "image/*" = [ "imv-dir.desktop" ];
          "image/gif" = [ "imv-dir.desktop" ];
          "image/jpeg" = [ "imv-dir.desktop" ];
          "image/png" = [ "imv-dir.desktop" ];
          "image/webp" = [ "imv-dir.desktop" ];
        };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
