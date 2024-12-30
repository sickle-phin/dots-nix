{
  config,
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    settings = {
      "modify_font cell_width" = "100%";
      "modify_font baseline" = 1;
      undercurl_style = "thick-dense";
      cursor_trail = 1;
      enable_audio_bell = false;
      window_padding_width = 5;
      background_opacity = "0.85";
      include = "current-theme.conf";
    };
    font = {
      name = "PlemolJP Console HS";
      package = pkgs.plemoljp-nf;
      size = 18;
    };
    shellIntegration.enableZshIntegration = true;
  };

  home.packages = [
    pkgs.ghostty
  ];

  xdg.configFile."ghostty/config".text = ''
    font-family = Moralerspace Neon HW
    font-family = Apple Color Emoji
    font-size = 19
    adjust-underline-position = 3
    adjust-underline-thickness= 1
    adjust-cursor-thickness = 1
    theme = catppuccin-mocha
    mouse-hide-while-typing = true
    background-opacity = 0.85
    window-padding-x = 10
    window-padding-y = 10
    window-decoration = false
    window-height = 50
    window-width = 80
    resize-overlay = never
    clipboard-paste-protection = true
    config-file = ${config.xdg.cacheHome}/theme/ghostty_theme
  '';
}
