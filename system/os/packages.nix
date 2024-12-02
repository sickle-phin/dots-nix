{ pkgs, ... }:
{
  environment = {
    systemPackages = builtins.attrValues {
      inherit (pkgs)
        cpufrequtils
        curl
        dmidecode
        expect
        lm_sensors
        lshw
        psmisc
        sbctl
        sysstat
        usbutils
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
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    localsend = {
      enable = true;
      openFirewall = true;
    };
    nix-ld.enable = true;
    zsh.enable = true;
  };
}
