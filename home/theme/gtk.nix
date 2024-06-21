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
      name = "breeze-dark";
      package = pkgs.breeze-icons;
    };

    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.breeze-gtk;
    };

    font = {
      name = "Noto Sans";
      size = 11;
    };
  };
}
