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
          "networkmanager"
          "wheel"
          "gamemode"
          "tss"
        ];
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
      };
      root = {
        hashedPasswordFile = config.age.secrets.login-password.path;
      };
    };

    mutableUsers = false;
  };
}
