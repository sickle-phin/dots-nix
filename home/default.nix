{ osConfig, username, ... }:
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = osConfig.system.stateVersion;
    activation."specialisationSetup" = ''
      if [[ -e $newGenPath/specialisation ]]; then
        test -h .config/specialisation && unlink .config/specialisation
        ln -s $newGenPath/specialisation .config/specialisation
      fi
    '';
  };

  programs.home-manager.enable = true;

  imports = [
    ./applications
    ./desktop
  ];
}
