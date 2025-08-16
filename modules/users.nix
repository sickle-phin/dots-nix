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
        useDefaultShell = true;
        initialPassword = mkIf config.myOptions.test.enable "test";
        hashedPasswordFile = mkIf (!config.myOptions.test.enable) config.age.secrets.login-password.path;
        extraGroups = [
          "gamemode"
          "input"
          "libvirtd"
          "wheel"
          "wireshark"
        ];
      };
    };
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
  };

  services.userborn = {
    enable = true;
    passwordFilesLocation = mkIf config.preservation.enable "/persistent/etc";
  };
}
