{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      # bitwarden-desktop
      libreoffice
      neovide
      pavucontrol
      slack
      teams-for-linux
      thunderbird
      vesktop
      ;
  };

  programs = {
    imv = {
      enable = true;
      catppuccin.enable = true;
    };

    mpv = {
      enable = true;
      catppuccin.enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = builtins.attrValues {
        inherit (pkgs.mpvScripts)
          uosc
          thumbfast
          mpv-playlistmanager
          mpris
          ;
      };
      config = {
        gpu-api="opengl";
        hwdec = "auto";
        vo = "gpu";
        loop-playlist = "inf";
      };
    };

    sioyek = {
      enable = true;
    };
  };
}
