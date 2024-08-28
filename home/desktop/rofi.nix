{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";
    font = "PlemolJP HS 13";
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

          height = mkLiteral "34%";
          width = mkLiteral "30%";
          background-color = mkLiteral "@bg-col";
        };

        "element-text, element-icon , mode-switcher" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
        };

        "window" = {
          border = mkLiteral "2px";
          border-color = mkLiteral "@border-col";
          border-radius = mkLiteral "10px";
        };

        "inputbar" = {
          children = mkLiteral "[prompt,entry]";
          background-color = mkLiteral "transparent";
          border-radius = mkLiteral "5px";
          padding = mkLiteral "2px";
        };

        "prompt" = {
          background-color = mkLiteral "@blue";
          padding = mkLiteral "6px";
          text-color = mkLiteral "@bg-col-light";
          border-radius = mkLiteral "3px";
          margin = mkLiteral "20px 20px 0px 20px";
        };

        "textbox-prompt-colon" = {
          expand = mkLiteral "false";
          str = mkLiteral "\":\"";
        };

        "entry" = {
          padding = mkLiteral "6px";
          margin = mkLiteral "20px 20px 0px 10px";
          text-color = mkLiteral "@fg-col";
          background-color = mkLiteral "@grey";
          border-radius = mkLiteral "5px";
          placeholder = mkLiteral "\" Search       \"";
          placeholder-color = mkLiteral "grey";
        };

        "listview" = {
          border = mkLiteral "0px 0px 0px";
          padding = mkLiteral "6px 0px 0px";
          margin = mkLiteral "10px 20px 10px 20px";
          columns = mkLiteral "1";
          lines = mkLiteral "5";
          background-color = mkLiteral "transparent";
        };

        "element" = {
          padding = mkLiteral "5px 20px";
          text-color = mkLiteral "@fg-col";
          background-color = mkLiteral "transparent";
        };

        "element-text" = {
          vertical-align = mkLiteral "0.5";
        };

        element-icon = {
          size = mkLiteral "25px";
        };

        "element selected" = {
          background-color = mkLiteral "@selected-col";
          text-color = mkLiteral "@fg-col2";
          border-radius = mkLiteral "30px";
        };

        "mode-switcher" = {
          spacing = mkLiteral "0";
        };

        "button" = {
          padding = mkLiteral "10px";
          background-color = mkLiteral "@bg-col-light";
          text-color = mkLiteral "@grey";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };

        "button selected" = {
          text-color = mkLiteral "@blue";
        };

        "message" = {
          margin = mkLiteral "2px";
          padding = mkLiteral "2px";
          border-radius = mkLiteral "5px";
        };

        "textbox" = {
          padding = mkLiteral "6px";
          margin = mkLiteral "20px 20px 20px 20px";
          text-color = mkLiteral "@blue";
          background-color = mkLiteral "transparent";
        };
      };
  };

  xdg = {
    configFile = {
      "rofi/config_wallpaper.rasi".text = ''
        configuration {
          font: "PlemolJP HS 13";
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
          padding: 5px;
        }
        element-icon {
          size: 95px;
        }
        element-text {
          vertical-align: 0;
          horizontal-align: 0.5;
        }
      '';
    };
  };
}
