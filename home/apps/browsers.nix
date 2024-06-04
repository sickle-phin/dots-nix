{ pkgs
, config
, ...
}: {
  programs = {
    google-chrome = {
      enable = true;
      commandLineArgs = [
        "--enable-wayland-ime"
        "--gtk-version=4"
      ];
    };

    vivaldi = {
      enable = true;
      commandLineArgs = [
        "--enable-wayland-ime"
        "--gtk-version=4"
      ];
    };

    firefox = {
      enable = true;
      # profiles.sickle-phin = {};
    };
  };
}
