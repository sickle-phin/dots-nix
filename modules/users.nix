{
  pkgs,
  config,
  lib,
  username,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  users = {
    users = {
      "${username}" = {
        isNormalUser = true;
        description = "${username}";
        initialPassword = mkIf config.myOptions.test.enable "test";
        hashedPasswordFile = mkIf (!config.myOptions.test.enable) config.age.secrets.login-password.path;
        extraGroups = [
          "gamemode"
          "libvirtd"
          "tss"
          "wheel"
          "wireshark"
        ];
        shell = pkgs.zsh;
      };
    };

    mutableUsers = false;
  };

  services.userborn.enable = false;
}
