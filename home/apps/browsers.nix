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

    # firefox = {
    #   enable = true;
    #   profiles.sickle-phin = {};
    # };
  };
}
