{ osConfig
, username
, ...
}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = osConfig.system.stateVersion;
  };

  programs.home-manager.enable = true;

  imports = [
    ./apps
    ./desktop
    ./develop
  ];
}
