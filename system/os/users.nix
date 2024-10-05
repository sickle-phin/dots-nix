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
          "networkmanager"
          "tss"
          "wheel"
          "wireshark"
        ];
        shell = pkgs.zsh;
      };
      root = {
        hashedPasswordFile = config.age.secrets.login-password.path;
      };
    };

    mutableUsers = false;
  };
}
