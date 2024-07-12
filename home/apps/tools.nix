{ pkgs
, lib
, osConfig
, ...
}: {
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    dust
    fd
    fzf
    just
    lsd
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
          (lib.mkIf (osConfig.networking.hostName == "irukaha") 144)
          (lib.mkIf (osConfig.networking.hostName != "irukaha") 60)
        ];
      };
    };

    yazi = {
      enable = true;
      catppuccin.enable = true;
      shellWrapperName = "y";
      enableZshIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
        };
      };
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
