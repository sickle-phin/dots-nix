{ pkgs, ... }:
{
  environment = {
    shells = [ pkgs.zsh ];
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
  };

  programs = {
    hyprland.enable = true;
    nix-ld.enable = true;
    uwsm = {
      enable = true;
      waylandCompositors.hyprland = {
        binPath = "/run/current-system/sw/bin/Hyprland";
        comment = "Hyprland session managed by uwsm";
        prettyName = "Hyprland";
      };
    };
    zsh.enable = true;
  };
}
