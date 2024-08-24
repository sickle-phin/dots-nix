{
  pkgs,
  lib,
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
        rocmSupport = true;
        cudaSupport = true;
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
