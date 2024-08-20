{ osConfig, ... }:
{
  programs = {
    foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          font =
            let
              fontsize =
                if osConfig.networking.hostName == "irukaha" then
                  "19"
                else if osConfig.networking.hostName == "pink" then
                  "13.5"
                else
                  "19";
            in
            "PlemolJP Console NF:size=${fontsize}, Symbols Nerd Font Mono:size=${fontsize}:style=Regular, Apple Color Emoji:size=${fontsize}";
          dpi-aware = "yes";
          pad = "10x10";
          underline-offset = 2;
          underline-thickness = 1;
        };
        scrollback.lines = 100000;
        cursor = {
          color = "000000 f4b7d6";
        };
        colors = {
          alpha = 0.7;
          foreground = "cdd6f4";
          background = "0e0e1e";

          regular0 = "45475a";
          regular1 = "f38ba8";
          regular2 = "a6e3a1";
          regular3 = "f9e2af";
          regular4 = "89b4fa";
          regular5 = "f5c2e7";
          regular6 = "94e2d5";
          regular7 = "bac2de";

          bright0 = "585b70";
          bright1 = "f38ba8";
          bright2 = "a6e3a1";
          bright3 = "f9e2af";
          bright4 = "89b4fa";
          bright5 = "f5c2e7";
          bright6 = "94e2d5";
          bright7 = "a6adc8";

          selection-foreground = "cdd6f4";
          selection-background = "414356";

          search-box-no-match = "11111b f38ba8";
          search-box-match = "cdd6f4 313244";

          jump-labels = "11111b fab387";
          urls = "89b4fa";
        };
      };
    };
  };
}
