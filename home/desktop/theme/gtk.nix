{ pkgs
, ...
}: {
  gtk = {
    enable = true;
    catppuccin.enable = true;

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
