{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";
    font = "PlemolJP HS 16";
    extraConfig = {
      prompt = "Apps";
      icon-theme = "Papirus-Dark";
      show-icons = true;
      markup = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "  Apps ";
      display-run = "  Run ";
      display-window = " 󰕰 Window ";
      display-ssh = " 󰤨 ssh ";
      cache-dir = "${config.xdg.cacheHome}/rofi";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          bg-col = mkLiteral "#1e1e2eb0";
          bg-col-light = mkLiteral "#1e1e2e";
          border-col = mkLiteral "#cba6f7";
          selected-col = mkLiteral "#cba6f7a0";
          blue = mkLiteral "#89b4fa";
          fg-col = mkLiteral "#cdd6f4";
          fg-col2 = mkLiteral "#94e2d5";
          grey = mkLiteral "#6c7086b0";

          height = mkLiteral "35%";
          width = mkLiteral "28%";
          background-color = mkLiteral "@bg-col";
        };

        "element-text, element-icon , mode-switcher" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
        };

        "window" = {
          border = mkLiteral "0.15em";
          border-color = mkLiteral "@border-col";
          border-radius = mkLiteral "0.8em";
        };

        "inputbar" = {
          children = mkLiteral "[prompt,entry]";
          background-color = mkLiteral "transparent";
          border-radius = mkLiteral "0.4em";
          padding = mkLiteral "0.15em";
        };

        "prompt" = {
          background-color = mkLiteral "@blue";
          padding = mkLiteral "0.5em";
          text-color = mkLiteral "@bg-col-light";
          border-radius = mkLiteral "0.2em";
          margin = mkLiteral "1.5% 1.5% 0 1.5%";
        };

        "textbox-prompt-colon" = {
          expand = mkLiteral "false";
          str = mkLiteral "\":\"";
        };

        "entry" = {
          padding = mkLiteral "0.5em";
          margin = mkLiteral "1.5% 1.5% 0 0.8%";
          text-color = mkLiteral "@fg-col";
          background-color = mkLiteral "@grey";
          border-radius = mkLiteral "0.4em";
          placeholder = mkLiteral "\" Search       \"";
          placeholder-color = mkLiteral "grey";
        };

        "listview" = {
          border = mkLiteral "0";
          padding = mkLiteral "0.5em 0 0";
          margin = mkLiteral "0.8% 0.8% 0.8% 0.8%";
          columns = mkLiteral "1";
          lines = mkLiteral "5";
          background-color = mkLiteral "transparent";
        };

        "element" = {
          padding = mkLiteral "0.4em 1.5%";
          text-color = mkLiteral "@fg-col";
          background-color = mkLiteral "transparent";
        };

        "element-text" = {
          vertical-align = mkLiteral "0.5";
        };

        element-icon = {
          size = mkLiteral "1.0em";
        };

        "element selected" = {
          background-color = mkLiteral "@selected-col";
          text-color = mkLiteral "@fg-col2";
          border-radius = mkLiteral "2.5em";
        };

        "mode-switcher" = {
          spacing = mkLiteral "0";
        };

        "button" = {
          padding = mkLiteral "0.8em";
          background-color = mkLiteral "@bg-col-light";
          text-color = mkLiteral "@grey";
          vertical-align = mkLiteral "0.4em";
          horizontal-align = mkLiteral "0.4em";
        };

        "button selected" = {
          text-color = mkLiteral "@blue";
        };

        "message" = {
          margin = mkLiteral "0.15em";
          padding = mkLiteral "0.15em";
          border-radius = mkLiteral "0.4em";
        };

        "textbox" = {
          padding = mkLiteral "0.5em";
          margin = mkLiteral "1.5% 1.5% 1.5% 1.5%";
          text-color = mkLiteral "@blue";
          background-color = mkLiteral "transparent";
        };
      };
  };

  xdg = {
    configFile = {
      "rofi/config_wallpaper.rasi".text = ''
        configuration {
          font: "PlemolJP HS 12";
          disable-history: false;
          display-drun: "  Apps ";
          drun-display-format: "{icon} {name}";
          hide-scrollbar: true;
          icon-theme: "papirus";
          location: 0;
          markup: true;
          prompt: "Apps";
          show-icons: true;
          terminal: "${pkgs.foot}/bin/foot";
          xoffset: 0;
          yoffset: 0;
        }
        @theme "wallpaper"
      '';
    };

    dataFile = {
      "rofi/themes/wallpaper.rasi".text = ''
        @theme "custom"
        listview {
          columns: 3;
        }
        element {
          orientation: vertical;
          padding: 0.5em;
        }
        element-icon {
          size: 6.5em;
        }
        element selected {
          border-radius: 1.0em;
        }
        element-text {
          vertical-align: 0;
          horizontal-align: 0.5;
        }
      '';
    };
  };
}
