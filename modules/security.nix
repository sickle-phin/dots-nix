{ pkgs
, ...
}:{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.extraConfig = "Defaults lecture=never";
    pam.services.hyprlock = {};
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
