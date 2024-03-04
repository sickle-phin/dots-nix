{ pkgs
, ...
}: {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.breeze-gtk;
    name = "breeze_cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
    };

    iconTheme = {
      name = "breeze-dark";
    };

    cursorTheme = {
      name = "breeze_cursors";
    };
    font = {
      name = "Noto Sans";
      size = 11;
    };
  };
}
