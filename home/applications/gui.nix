{
  osConfig,
  pkgs,
  ...
}:
{
  home = {
    packages = builtins.attrValues {
      inherit (pkgs)
        libreoffice
        pavucontrol
        slack
        teams-for-linux
        thunderbird
        ;
    };
    sessionVariables = {
      SDL_VIDEODRIVER = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
      NIXOS_OZONE_WL = 1;
    };
  };

  programs = {
    imv.enable = true;
    mpv = {
      enable = true;
      defaultProfiles = [ "high-quality" ];
      config = {
        gpu-api = "opengl";
        gpu-context = "wayland";
        hwdec = "auto";
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
    vesktop = {
      enable = true;
      settings = {
        hardwareVideoAcceleration = true;
        enableMenu = true;
        splashPixelated = true;
      };
      vencord = {
        useSystem = true;
        settings = {
          enabledThemes = [ "dank-discord.css" ];
          autoUpdate = false;
          autoUpdateNotification = false;
          transparent = true;
          plugins = {
            AlwaysAnimate.enabled = true;
            MessageLogger = {
              enabled = true;
              ignoreSelf = true;
            };
            FakeNitro.enabled = true;
          };
        };
        themes."catppuccin.theme" = ''
          @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}.theme.css")
          (prefers-color-scheme: dark);
          @import url("https://catppuccin.github.io/discord/dist/catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}.theme.css")
          (prefers-color-scheme: light);
        '';
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
      vesktop.settings = {
        splashColor = "rgb(205, 214, 244)";
        splashBackground = "rgb(30, 30, 46)";
      };
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
      vesktop.settings = {
        splashColor = "rgb(76, 79, 105)";
        splashBackground = "rgb(239, 241, 245)";
      };
    };
  };
}
