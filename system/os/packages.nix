{ pkgs, ... }:
{
  environment = {
    defaultPackages = [ ];
    systemPackages = builtins.attrValues {
      inherit (pkgs)
        cpufrequtils
        curl
        dmidecode
        expect
        lm_sensors
        lshw
        psmisc
        rsync
        sbctl
        sysstat
        usbutils
        vlock
        wget
        ;
    };
    sessionVariables = {
      EDITOR = "nvim";
    };

    enableAllTerminfo = true;
    shells = [ pkgs.zsh ];
  };

  programs = {
    command-not-found.enable = false;
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    less = {
      enable = true;
      lessopen = null;
    };
    localsend = {
      enable = true;
      openFirewall = true;
    };
    nix-ld.enable = true;
    zsh.enable = true;
  };
}
