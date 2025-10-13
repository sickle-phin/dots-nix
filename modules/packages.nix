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
        strace
        sysstat
        usbutils
        vlock
        wget
        ;
    };
    sessionVariables = {
      UWSM_SILENT_START = 1;
    };

    enableAllTerminfo = true;
    shells = [ pkgs.zsh ];
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    localsend = {
      enable = true;
      openFirewall = true;
    };
    nix-ld.enable = true;
    niri.enable = true;
    zoom-us.enable = false;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
