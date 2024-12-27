{
  inputs,
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 18;
      "modify_font cell_width" = "105%";
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
    };
    shellIntegration.enableZshIntegration = true;
  };

  home.packages = [
    inputs.ghostty.packages.x86_64-linux.default
  ];

  xdg.configFile."ghostty/config".text = ''
    font-family = PlemolJP Console NF
    font-family = Symbols Nerd Font Mono
    font-family = Apple Color Emoji
    font-size = 18
    adjust-underline-position = 3
    adjust-underline-thickness= 1
    adjust-cursor-thickness = 1
    theme = light:catppuccin-latte,dark:catppuccin-mocha
    cursor-opacity = 0.9
    mouse-hide-while-typing = true
    background-opacity = 0.8
    window-padding-x = 10
    window-padding-y = 10
    window-decoration = false
    window-height = 50
    window-width = 80
    resize-overlay = never
    clipboard-paste-protection = true
  '';
}
