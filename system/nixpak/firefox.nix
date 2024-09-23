{
  pkgs,
  mkNixPak,
  ...
}:
mkNixPak {
  config =
    {
      config,
      sloth,
      ...
    }:
    {
      app = {
        package = pkgs.firefox-wayland;
        binPath = "bin/firefox";
      };
      flatpak.appId = "org.mozilla.firefox";

      imports = [
        ./modules/gui-base.nix
        ./modules/network.nix
      ];

      # list all dbus services:
      #   ls -al /run/current-system/sw/share/dbus-1/services/
      #   ls -al /etc/profiles/per-user/ryan/share/dbus-1/services/
      dbus.policies = {
        "org.mozilla.firefox.*" = "own";
        "org.mozilla.firefox_beta.*" = "own";
        "org.mpris.MediaPlayer2.firefox.*" = "own";
      };

      bubblewrap = {
        bind.rw = [
          (sloth.concat' sloth.homeDir "/.mozilla")
          (sloth.concat' sloth.homeDir "/Downloads")
        ];
        bind.ro = [
          "/sys/bus/pci"
          [
            "${config.app.package}/lib/firefox"
            "/app/etc/firefox"
          ]
          (sloth.concat' sloth.xdgConfigHome "/dconf")
        ];
        sockets = {
          x11 = false;
          wayland = true;
          pipewire = true;
        };
        bind.dev = [
          "/dev/shm" # Shared Memory

          "/dev/video0"

          "/dev/nvidia0"
          "/dev/nvidia-uvm"
          "/dev/nvidia-modeset"
        ];
        tmpfs = [
          "/tmp"
        ];
      };
    };
}
