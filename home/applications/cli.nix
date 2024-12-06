{
  pkgs,
  osConfig,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      dust
      fd
      libnotify
      playerctl
      procs
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
      catppuccin.enable = true;
      config = {
        pager = "less -FR";
      };
    };

    btop = {
      enable = true;
      package = pkgs.btop.override {
        rocmSupport = if osConfig.myOptions.gpu == "amd" then true else false;
        cudaSupport = if osConfig.myOptions.gpu == "nvidia" then true else false;
      };
      catppuccin.enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    cava = {
      enable = true;
      catppuccin = {
        enable = true;
        transparent = true;
      };
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
        marker = "#f5e0dc";
        "fg+" = "#cdd6f4";
        prompt = "#cba6f7";
        "hl+" = "#f38ba8";
      };
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d";
    };

    jq.enable = true;

    lsd.enable = true;

    yazi = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        manager = {
          linemode = "size_and_mtime";
          show_symlink = true;
        };
      };
      initLua = ''
        function Linemode:size_and_mtime()
          local time = math.floor(self._file.cha.modified or 0)
          if time == 0 then
            time = ""
          elseif os.date("%Y", time) == os.date("%Y") then
            time = os.date("%b %d %H:%M", time)
          else
            time = os.date("%b %d  %Y", time)
          end

          local size = self._file:size()
          return ui.Line(string.format("%s  %s", size and ya.readable_size(size) or "", time))
        end
      '';
    };

    zoxide = {
      enable = true;
    };
  };
}
