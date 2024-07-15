{
  imports = [
    ./apps
    ./desktop
    ./develop
  ];

  home = {
    username = "sickle-phin";
    homeDirectory = "/home/sickle-phin";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
