# https://github.com/nixpak/pkgs/blob/master/pkgs/modules/gui-base.nix
{
  config,
  lib,
  pkgs,
  sloth,
  ...
}:
let
  envSuffix = envKey: suffix: sloth.concat' (sloth.env envKey) suffix;
  gtkTheme = pkgs.catppuccin-gtk.override {
    accents = [ "mauve" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "mocha";
  };
  cursorTheme = pkgs.catppuccin-cursors.mochaDark;
  iconTheme = pkgs.papirus-icon-theme;
in
{
  config = {
    dbus = {
      policies = {
        "${config.flatpak.appId}" = "own";
        "${config.flatpak.appId}.*" = "own";
        "ca.desrt.dconf" = "talk";
        "org.a11y.Bus" = "talk";
        "org.freedesktop.DBus" = "talk";
        "org.freedesktop.DBus.*" = "talk";
        "org.freedesktop.FileManager1" = "talk";
        "org.freedesktop.NetworkManager" = "talk";
        "org.freedesktop.Notifications" = "talk";
        "org.freedesktop.portal.*" = "talk";
        "org.freedesktop.portal.FileChooser" = "talk";
        "org.freedesktop.portal.OpenURI.OpenURI" = "talk";
        "org.freedesktop.portal.Settings" = "talk";
        "org.freedesktop.Screensaver" = "talk";
        "org.gtk.vfs.*" = "talk";
        "org.gtk.vfs" = "talk";
      };
    };
    gpu = {
      enable = lib.mkDefault true;
      provider = "nixos";
      bundlePackage = pkgs.mesa.drivers; # for amd & intel
    };
    fonts.enable = false;
    locale.enable = true;
    bubblewrap = {
      network = lib.mkDefault false;
      bind.rw = [
        [
          (envSuffix "HOME" "/.var/app/${config.flatpak.appId}/cache")
          sloth.xdgCacheHome
        ]
        (sloth.concat' sloth.xdgCacheHome "/fontconfig")
        (sloth.concat' sloth.xdgCacheHome "/mesa_shader_cache")
        (sloth.concat [
          (sloth.env "XDG_RUNTIME_DIR")
          "/"
          (sloth.envOr "WAYLAND_DISPLAY" "no")
        ])

        (envSuffix "XDG_RUNTIME_DIR" "/at-spi/bus")
        (envSuffix "XDG_RUNTIME_DIR" "/dconf")
        (envSuffix "XDG_RUNTIME_DIR" "/doc")
        (envSuffix "XDG_RUNTIME_DIR" "/gvfsd")
        (envSuffix "XDG_RUNTIME_DIR" "/pulse")
        (envSuffix "XDG_RUNTIME_DIR" "/wayland-1")

        "/run/dbus"
      ];
      bind.ro = [
        (sloth.concat' sloth.xdgConfigHome "/dconf")
        (sloth.concat' sloth.xdgConfigHome "/gtk-2.0")
        (sloth.concat' sloth.xdgConfigHome "/gtk-3.0")
        (sloth.concat' sloth.xdgConfigHome "/gtk-4.0")

        "/etc/fonts"
        (sloth.concat' sloth.xdgConfigHome "/fontconfig")
        (sloth.concat' sloth.xdgDataHome "/fonts")
        (sloth.concat' sloth.xdgDataHome "/applications")

        "/etc/machine-id"
        "/etc/localtime"
        "/etc/passwd"
        "/etc/egl"
        "/etc/static/egl"
        "/etc/profiles/per-user/sickle-phin/bin"
        "/etc/profiles/per-user/sickle-phin/share/applications"
      ];
      bind.dev = [
        "/dev/nvidia0"
        "/dev/nvidiactl"
        "/dev/nvidia-modeset"
        "/dev/nvidia-uvm"
        "/dev/nvidia-uvm-tools"
      ];
      env = {
        XDG_DATA_DIRS = lib.mkForce (
          lib.makeSearchPath "share" [
            gtkTheme
            iconTheme
            cursorTheme
            pkgs.shared-mime-info
          ]
        );
        XCURSOR_PATH = lib.mkForce (
          lib.concatStringsSep ":" [
            "${cursorTheme}/share/icons"
            "${cursorTheme}/share/pixmaps"
          ]
        );
      };
    };
  };
}
