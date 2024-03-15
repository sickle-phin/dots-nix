{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    dust
    fd
    fzf
    lsd
    ripgrep
    libnotify
  ];
  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-mocha";
      };
      themes = {
        catppuccin-mocha = {
          src = inputs.catppuccin-bat;
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
    
    btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-storm";
        theme_background = false;
      };
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    
    zoxide = {
      enable = true;
    };
  };
}
