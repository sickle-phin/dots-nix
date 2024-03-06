{ pkgs
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
    z-lua
    warp-terminal
  ];
  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        # theme = "catppuccin-mocha";
      };
      # themes = {
      #   catppuccin-mocha = {
      #     src = catppuccin-bat;
      #     file = "Catppuccin-mocha.tmTheme";
      #   };
      # };
    };
  };
}
