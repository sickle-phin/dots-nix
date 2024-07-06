{ pkgs
, config
, ...
}:{
  users = {
    users = {
      sickle-phin = {
        isNormalUser = true;
        description = "sickle-phin";
        hashedPasswordFile = config.age.secrets.login-password.path;
        extraGroups = [ "networkmanager" "wheel" "gamemode" "tss" ];
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
