{
  imports = [
    ./env.nix
    ./fuzzel.nix
    ./hypridle.nix
    ./hyprland
    ./hyprlock.nix
    ./ime
    ./services.nix
    ./scripts
    ./theme
  ];

  xdg.configFile."quickshell".source = ./quickshell;
}
