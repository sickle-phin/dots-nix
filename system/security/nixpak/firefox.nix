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
        package = pkgs.firefox;
        binPath = "bin/firefox";
      };
      flatpak.appId = "org.mozilla.firefox";

      imports = [
        ./modules/gui-base.nix
        ./modules/network.nix
      ];

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
        ];
        sockets = {
          x11 = false;
          wayland = true;
          pipewire = true;
        };
        bind.dev = [
          "/dev/shm"
          "/dev/video0"
        ];
        tmpfs = [
          "/tmp"
        ];
      };
    };
}
