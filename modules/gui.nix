{ pkgs
, ...
}: {
  services = {
    xserver = {
      excludePackages = [ pkgs.xterm ];
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositor = "kwin";
        enableHidpi = true;
        theme = "chili";
        settings.Theme = {
          FacesDir = "/etc/var/lib/sddm/icons";
          CursorTheme = "breeze_cursors";
        };
      };
    };
  };

  environment.etc = {
    "var/lib/sddm/icons/sickle-phin.face.icon".source = ./sickle-phin.face.icon;
  };
}
