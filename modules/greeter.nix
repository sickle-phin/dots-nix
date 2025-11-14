{
  inputs,
  pkgs,
  username,
  ...
}:
{
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configFiles = [
      "/home/${username}/.config/DankMaterialShell/settings.json"
      "/home/${username}/.local/state/DankMaterialShell/session.json"
      "/home/${username}/.local/cache/DankMaterialShell/dms-colors.json"
    ];
  };

  environment.systemPackages = [ pkgs.catppuccin-cursors.mochaDark ];
}
