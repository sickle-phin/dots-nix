{
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.meta) getExe;
in
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      dust
      fd
      imagemagick
      libnotify
      playerctl
      procs
      ripdrag
      ripgrep
      silicon
      speedtest-cli

      zip
      unzip
      p7zip
      unar
      ;
  };

  programs = {
    bat = {
      enable = true;
      themes = {
        "Catppuccin Latte".src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/6810349b28055dce54076712fc05fc68da4b8ec0/themes/Catppuccin%20Latte.tmTheme";
          sha256 = "sha256-8fm+zCL5HJykuknBh36MxFCCwji2kTNGjwAtZ3Usd94=";
        };
        "Catppuccin Mocha".src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/6810349b28055dce54076712fc05fc68da4b8ec0/themes/Catppuccin%20Mocha.tmTheme";
          sha256 = "sha256-Rj7bB/PCaC/r0y+Nh62yI+Jg1O0WDm88E+DrsaDZj6o=";
        };
      };
    };

    btop = {
      enable = true;
      package = pkgs.btop.override {
        rocmSupport = osConfig.myOptions.gpu.vendor == "amd";
        cudaSupport = osConfig.myOptions.gpu.vendor == "nvidia";
      };
      themes = {
        catppuccin_latte = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/btop/f437574b600f1c6d932627050b15ff5153b58fa3/themes/catppuccin_latte.theme";
          sha256 = "sha256-kOlj6tXuCDoTWdy2lNl4TBv+QewuDUhtOwTw2b25Fzs=";
        };
        catppuccin_mocha = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/btop/f437574b600f1c6d932627050b15ff5153b58fa3/themes/catppuccin_mocha.theme";
          sha256 = "sha256-THRpq5vaKCwf9gaso3ycC4TNDLZtBB5Ofh/tOXkfRkQ=";
        };
      };
    };

    cava = {
      enable = true;
      settings = {
        general.framerate = osConfig.myOptions.maxFramerate;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      colors = {
        "bg+" = "#313244";
        spinner = "#f5e0dc";
        hl = "#f38ba8";
        fg = "#cdd6f4";
        header = "#f38ba8";
        info = "#cba6f7";
        pointer = "#f5e0dc";
        marker = "#B4BEFE";
        "fg+" = "#cdd6f4";
        prompt = "#cba6f7";
        "hl+" = "#f38ba8";
        selected-bg = "#45475A";
        border = "#6C7086";
        label = "#CDD6F4";
      };
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d";
    };

    jq.enable = true;

    lsd.enable = true;

    yazi = {
      enable = true;
      keymap.mgr.prepend_keymap = [
        {
          on = [ "<C-n>" ];
          run = ''shell '${getExe pkgs.ripdrag} "$@" -x 2>/dev/null &' --confirm'';
        }
        {
          on = [ "y" ];
          run = [
            ''shell -- for path in "$@"; do echo "$path"; done | wl-copy''
            "yank"
          ];
        }
      ];
      settings = {
        mgr = {
          linemode = "size_and_mtime";
          show_symlink = true;
        };
        preview = {
          image_delay = 0;
        };
      };
      theme = {
        flavor = {
          dark = "catppuccin-mocha";
          light = "catppuccin-latte";
        };
      };
      initLua = ''
        function Linemode:size_and_mtime()
          local time = math.floor(self._file.cha.mtime or 0)
          if time == 0 then
            time = ""
          elseif os.date("%Y", time) == os.date("%Y") then
            time = os.date("%b %d %H:%M", time)
          else
            time = os.date("%b %d  %Y", time)
          end

          local size = self._file:size()
          return string.format("%s %s", size and ya.readable_size(size) or "", time)
        end
      '';
      flavors = {
        catppuccin-latte = "${inputs.yazi-flavors}/catppuccin-latte.yazi";
        catppuccin-mocha = "${inputs.yazi-flavors}/catppuccin-mocha.yazi";
      };
    };

    zoxide = {
      enable = true;
    };
  };
}
