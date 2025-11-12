{ inputs, username, ... }:
{
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/${username}";
  };
}
