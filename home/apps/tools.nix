{
  pkgs,
  osConfig,
  ...
}:
{
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    dust
    fd
    ripgrep
    libnotify
  ];

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
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
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

    lsd.enable = true;

    yazi = {
      enable = true;
      catppuccin.enable = true;
    };

    zoxide = {
      enable = true;
    };
  };

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        udisks_version = 2;
      };
    };
    tray = "always";
  };
}
