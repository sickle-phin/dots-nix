{
  config,
  inputs,
  osConfig,
  username,
  ...
}:
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
    file = {
      "Pictures/Wallpapers" = {
        source = "${inputs.wallpaper}/wallpapers";
        recursive = true;
      };
      "Pictures/Wallpapers/wall0.png".source =
        "${config.wayland.windowManager.hyprland.package}/share/hypr/wall0.png";
      "Pictures/Wallpapers/wall1.png".source =
        "${config.wayland.windowManager.hyprland.package}/share/hypr/wall1.png";
      "Pictures/Wallpapers/wall2.png".source =
        "${config.wayland.windowManager.hyprland.package}/share/hypr/wall2.png";
    };
  };

  programs.home-manager.enable = true;

  imports = [
    ./applications
    ./desktop
  ];
}
