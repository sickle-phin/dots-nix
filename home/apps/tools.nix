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
    just
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

    cava = {
      enable = true;
      catppuccin = {
        enable = true;
        transparent = true;
      };
      settings = {
        general.framerate = lib.mkMerge [
          (lib.mkIf (osConfig.networking.hostName == "irukaha") 180)
          (lib.mkIf (osConfig.networking.hostName != "irukaha") 60)
        ];
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
