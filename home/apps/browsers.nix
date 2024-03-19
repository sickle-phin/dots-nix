{ pkgs
, config
, ...
}: {
  programs = {
    google-chrome = {
      enable = true;
      commandLineArgs = [
        "--enable-wayland-ime"
      ];
    };

    firefox = {
      enable = false;
      # profiles.sickle-phin = {};
    };
  };
}
