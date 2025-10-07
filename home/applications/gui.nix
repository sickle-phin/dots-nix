{
  osConfig,
  pkgs,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      # libreoffice
      pavucontrol
      slack
      teams-for-linux
      thunderbird
      vesktop
      ;
  };

  programs = {
    imv.enable = true;
    mpv = {
      enable = true;
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
  };

  specialisation = {
    dark.configuration.programs = {
      imv.settings.options = {
        background = "1e1e2e";
        overlay_text_color = "cdd6f4";
        overlay_background_color = "11111b";
      };
      mpv.config.include = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/mpv/refs/heads/main/themes/mocha/pink.conf";
        sha256 = "sha256-UOoTa8KsRweQuPnjqum+mvJOc93u7bMleMdveQTI+Rg=";
      }}";
    };
    light.configuration.programs = {
      imv.settings.options = {
        background = "eff1f5";
        overlay_text_color = "4c4f69";
        overlay_background_color = "dce0e8";
      };
      mpv.config.include = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/mpv/refs/heads/main/themes/latte/pink.conf";
        sha256 = "sha256-785OOD3/K2lTuno6jMYGKueeg4Q45pcg4eims5yMnqc=";
      }}";
    };
  };
}
