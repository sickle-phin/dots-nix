{
  pkgs,
  config,
  username,
  ...
}:
{
  users = {
    users = {
      "${username}" = {
        isNormalUser = true;
        description = "${username}";
        hashedPasswordFile = config.age.secrets.login-password.path;
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

  services.userborn.enable = true;
}
