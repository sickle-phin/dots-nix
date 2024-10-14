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
          "networkmanager"
          "tss"
          "wheel"
          "wireshark"
        ];
        shell = pkgs.zsh;
      };
    };

    mutableUsers = false;
  };
}
