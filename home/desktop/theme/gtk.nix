{ pkgs
, ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.breeze-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.breeze-gtk;
    };

    font = {
      name = "Noto Sans CJK JP";
      size = 11;
    };
  };
}
