{ osConfig
, ...
}: {
  imports = [
    ./apps
    ./desktop
    ./develop
  ];

  home = {
    username = "sickle-phin";
    homeDirectory = "/home/sickle-phin";
    stateVersion = osConfig.system.stateVersion;
  };

  programs.home-manager.enable = true;
}
