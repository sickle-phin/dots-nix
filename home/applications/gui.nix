{ osConfig, pkgs, ... }:
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
      defaultProfiles = [ "high-quality" ];
      config = {
        gpu-api = "opengl";
        gpu-context = "wayland";
        hwdec = if (osConfig.myOptions.gpu == "nvidia") then "nvdec" else "vaapi";
        vo = "gpu";
        loop-playlist = "inf";
        scale = "ewa_lanczossharp";
        dscale = "mitchell";
        cscale = "ewa_lanczossoft";
      };
      scripts = builtins.attrValues {
        inherit (pkgs.mpvScripts)
          uosc
          thumbfast
          mpv-playlistmanager
          mpris
          ;
      };
    };

    sioyek = {
      enable = true;
    };
  };
}
