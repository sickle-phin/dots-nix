{ pkgs
, ...
}:{
  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager.setupCommands = "xrandr --output DP-1 --auto --primary xrandr --output HDMI-A-1 --left-of DP-1 --noprimary";
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = false;
        wayland.compositor = "kwin";
        enableHidpi = true;
        theme = "chili";
        settings.Theme = {
          FacesDir = "/var/lib/AccountsService/icons";
          CursorTheme = "breeze_cursors";
        };
      };
    };
  };

  system.activationScripts.script.text = ''
    mkdir -p /var/lib/AccountsService/icons
    cp /home/sickle-phin/dots-nix/modules/sickle-phin.face.icon /var/lib/AccountsService/icons
  '';
}
