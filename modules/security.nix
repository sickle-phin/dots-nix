{ pkgs
, ...
}:{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.extraConfig = "Defaults lecture=never";
    pam.services.hyprlock = {};
  };
  programs.ssh.startAgent = true;
}
