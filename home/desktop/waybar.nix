{ lib, osConfig, ... }:
{
  programs.waybar = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        output = lib.mkMerge [ (lib.mkIf (osConfig.networking.hostName == "irukaha") "DP-1") ];
        modules-left = [
          "custom/nix"
          "custom/wallpaper"
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = lib.mkMerge [
          (lib.mkIf (osConfig.networking.hostName != "pink") [
            "pulseaudio"
            "bluetooth"
            "network"
            "custom/power"
          ])
          (lib.mkIf (osConfig.networking.hostName == "pink") [
            "pulseaudio"
            "backlight"
            "battery"
            "bluetooth"
            "network"
            "custom/power"
          ])
        ];
        margin-top = 7;
        "custom/nix" = {
          format = "";
          tooltip = false;
          on-click = "sleep 0.05 && rofi -show drun";
        };
        "custom/wallpaper" = {
          format = "";
          tooltip = false;
          on-click = "sleep 0.05 && ${./hyprland/scripts/wallpaper.sh} ${./hyprland/wallpapers}";
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
        "battery#bat2" = {
          bat = "BAT2";
        };
        "custom/power" = {
          format = "⏻";
          on-click = "sleep 0.05 && pidof wlogout || wlogout -b 6 -T 400 -B 400";
        };
      };
    };
    style = ''
      * {
          font-size: 16px;
          font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
          min-height: 0;
      }

      window#waybar {
          background: transparent;
      }

      #custom-nix, #custom-wallpaper, #workspaces, #clock, #pulseaudio, #backlight, #battery, #bluetooth, #network, #custom-power{
          border: 2px solid @mauve;
          border-radius: 30px;
          background: alpha(@base, 0.8);
          padding-left: 20px;
          padding-right: 20px;
          margin-right: 15px;
      }

      #custom-nix:hover, #custom-wallpaper:hover, #workspaces:hover, #clock:hover, #backlight:hover, #pulseaudio:hover, #bluetooth:hover, #network:hover, #battery:hover, #custom-power:hover{
          background: alpha(@surface0, 0.8);
      }

      #custom-nix {
          font-size: 20px;
          color: #7EBAE4;
          font-family: "PlemolJP Console NF";
          padding-left: 13px;
          margin-left: 15px;
      }

      #custom-wallpaper {
          color: @pink;
          padding-left: 15px;
          padding-right: 15px;
      }

      #workspaces {
          padding-left: 12px;
          padding-right: 12px;
      }

      #workspaces button {
          color: @surface2;
      }

      #workspaces button.active {
          color: #00bfe5;
      }

      #pulseaudio {
          color: @maroon;
          border-right: none;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
          padding-right: 10px;
          margin-right: 0px;
      }

      #backlight {
          color: @yellow;
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
          color: @peach;
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
          color: @teal;
          margin-right: 0;
      }

      #network {
          color: @green;
      }

      #custom-power {
          color: @red;
          padding-left: 16px;
          padding-right: 15px;
          margin-right: 15px;
      }
    '';
  };
}
