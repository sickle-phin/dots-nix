{
  config,
  lib,
  osConfig,
  ...
}:
let
  host = osConfig.networking.hostName;
  setXCursor = "XCURSOR_THEME=$(cat ${config.xdg.cacheHome}/hypr/cursor_theme) && XCURSOR_SIZE=$(cat ${config.xdg.cacheHome}/hypr/cursor_size)";
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        output = lib.mkMerge [ (lib.mkIf (host == "irukaha" || host == "labo") "DP-1") ];
        modules-left = [
          "custom/nix"
          "custom/wallpaper"
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right =
          if (osConfig.myOptions.isLaptop == true) then
            [
              "pulseaudio"
              "backlight"
              "battery"
              "bluetooth"
              "network"
              "custom/power"
            ]
          else
            [
              "pulseaudio"
              "power-profiles-daemon"
              "bluetooth"
              "network"
              "custom/power"
            ];
        margin-top = 7;
        "custom/nix" = {
          format = "";
          tooltip = false;
          on-click = "sleep 0.05 && ${setXCursor}; uwsm-app fuzzel";
        };
        "custom/wallpaper" = {
          format = "";
          tooltip = false;
          on-click = "sleep 0.05 && set-wallpaper";
        };
        "hyprland/workspaces" = {
          format = "{name}";
          tooltip = false;
          all-outputs = true;
          format-icons = {
            "active" = "";
            "default" = "";
          };
        };
        clock = {
          format = "<span> </span>{:%H:%M}";
          timezone = "Asia/Tokyo";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y/%m/%d}";
        };
        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          tooltip = false;
          format-icons = {
            headphone = " ";
            default = [
              ""
              ""
              ""
            ];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
        };
        bluetooth = {
          format = " {status}";
          format-connected = " {num_connections}";
          tooltip-format = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}   {device_address}";
          on-click = "blueman-manager";
        };
        network = {
          format-wifi = "   {essid} ({signalStrength}%) ";
          format-ethernet = "   {ipaddr}/{cidr} ";
          tooltip-format = "   {ifname} via {gwaddr} ";
          format-linked = "   {ifname} (No IP) ";
          format-disconnected = "⚠   Disconnected ";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{icon} {time}";
          # format-good = "";
          # format-full = "";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        power-profiles-daemon = {
          format = "{icon}  {profile}";
          tooltip-format = "Power profile: {profile} Driver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        "battery#bat2" = {
          bat = "BAT2";
        };
        "custom/power" = {
          format = "⏻";
          on-click = "sleep 0.05 && wlogout-run";
        };
      };
    };
    style = ''
      @import "${config.xdg.cacheHome}/theme/waybar.css";
      * {
          font-size: 16px;
          font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
          min-height: 0;
      }

      window#waybar {
          background: transparent;
      }

      #custom-nix, #custom-wallpaper, #workspaces, #clock, #pulseaudio, #backlight, #battery, #power-profiles-daemon, #bluetooth, #network, #custom-power{
          border: 3px solid @border;
          border-radius: 30px;
          background: alpha(@bg, 0.9);
          padding-left: 20px;
          padding-right: 20px;
          margin-right: 15px;
      }

      #custom-nix:hover, #custom-wallpaper:hover, #workspaces:hover, #clock:hover, #backlight:hover, #pulseaudio:hover, #bluetooth:hover, #network:hover, #battery:hover, #power-profiles-daemon:hover, #custom-power:hover{
          background: alpha(@hover, 0.9);
      }

      #custom-nix {
          font-size: 20px;
          color: #7EBAE4;
          font-family: "PlemolJP Console NF";
          padding-left: 13px;
          margin-left: 15px;
      }

      #custom-wallpaper {
          color: @wallpaper;
          padding-left: 15px;
          padding-right: 15px;
      }

      #workspaces {
          padding-left: 12px;
          padding-right: 12px;
      }

      #workspaces button {
          color: #585b70;
      }

      #workspaces button.active {
          color: #00bfe5;
      }

      #pulseaudio {
          color: @audio;
          border-right: none;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
          padding-right: 10px;
          margin-right: 0px;
      }

      #backlight {
          color: @light;
          border-right: none;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
          border-left: none;
          border-top-left-radius: 0;
          border-bottom-left-radius: 0;
          padding-left: 10px;
          padding-right: 10px;
          margin-right: 0px;
      }

      #battery {
          color: @bat;
          border-right: none;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
          border-left: none;
          border-top-left-radius: 0;
          border-bottom-left-radius: 0;
          padding-left: 10px;
          padding-right: 10px;
          margin-right: 0px;
      }

      #power-profiles-daemon {
          color: @bat;
          border-right: none;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
          border-left: none;
          border-top-left-radius: 0;
          border-bottom-left-radius: 0;
          padding-left: 10px;
          padding-right: 10px;
          margin-right: 0px;
      }

      #bluetooth {
          color: @blue;
          border-left: none;
          border-top-left-radius: 0;
          border-bottom-left-radius: 0;
          padding-left: 10px;
          margin-left: 0px;
      }

      #clock {
          color: @clock;
          margin-right: 0;
      }

      #network {
          color: @net;
      }

      #custom-power {
          color: @power;
          padding-left: 16px;
          padding-right: 15px;
          margin-right: 15px;
      }
    '';
  };
}
