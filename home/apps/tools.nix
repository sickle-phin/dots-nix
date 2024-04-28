{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    cava
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

    yazi = {
      enable = true;
      catppuccin.enable = true;
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
    };
}
