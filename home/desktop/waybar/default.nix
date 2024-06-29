{ lib
, osConfig
, ...
}:{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        output = lib.mkMerge [
          (lib.mkIf (osConfig.networking.hostName == "irukaha")
            "DP-1"
          )
        ];
        modules-left = [ "custom/hyprland" "custom/wallpaper" "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = lib.mkMerge [
          (lib.mkIf (osConfig.networking.hostName != "pink")
            [ "bluetooth" "pulseaudio" "network" "custom/power" ]
          )
          (lib.mkIf (osConfig.networking.hostName == "pink")
            [ "backlight" "battery" "pulseaudio" "network" "custom/power" ]
          )
        ];
        margin-top = 7;
        "custom/hyprland" = {
          format = "  ";
          tooltip = false;
          on-click = "sleep 0.05 && pidof wofi || wofi --show drun";
        };
        "custom/wallpaper" = {
          format = "";
          tooltip = false;
          on-click = "sleep 0.05 && pidof wofi || bash ~/.config/hypr/scripts/wallpaper.sh";
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
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          tooltip = false;
          format-icons = {
          headphone = " ";
          default = [ "" "" "󰕾" "󰕾" "󰕾" "  " "  " "  " ];
        };
          scroll-step = 1;
          on-click = "pavucontrol";
        };
        bluetooth = {
          format = " {status}";
          format-disabled = "";
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
          format = "{icon}   {capacity}% ";
          format-charging = "   {capacity}% ";
          format-plugged = "   {capacity}% ";
          format-alt = "{icon}   {time} ";
          # format-good = "";
          # format-full = "";
          format-icons = [ "" "" "" "" "" ];
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
  };
  xdg.configFile = {
    "waybar/style.css" = {
      source = ./style.css;
    };
  };
}
