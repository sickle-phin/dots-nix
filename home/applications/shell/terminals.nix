{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = [
        "Moralerspace Neon HW"
        "Apple Color Emoji"
      ];
      font-feature = "calt,liga,ss01,ss02,ss03,ss04,ss05,ss06,ss07,ss08,ss09";
      font-size = 18;
      adjust-underline-position = "15%";
      adjust-underline-thickness = 2;
      theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
      cursor-style = "block";
      cursor-style-blink = false;
      background-opacity = "0.85";
      window-padding-x = 10;
      window-padding-y = 10;
      window-inherit-working-directory = false;
      window-title-font-family = "Mona Sans";
      window-theme = "ghostty";
      resize-overlay = "never";
      quit-after-last-window-closed = false;
      shell-integration-features = "no-cursor";
    };
  };
}
