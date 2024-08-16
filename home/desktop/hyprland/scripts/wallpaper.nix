{ pkgs, ... }:
let
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    WALL_DIR=${../wallpapers}
    WALL_DIR_DEFAULT="${pkgs.hyprland}/share/hypr"

    PICS=($(ls "''${WALL_DIR}"))
    PICS_DEFAULT=($(ls "''${WALL_DIR_DEFAULT}"))
    MONITOR_INFO=$(hyprctl monitors)
    MONITORS=($(echo "$MONITOR_INFO" | grep "Monitor" | awk '{print $2}'))
    IS_DEFAULT=0

    wall_menu() {
      for i in "''${!PICS[@]}"; do
        printf "''${PICS[$i]}\0icon\x1f''${WALL_DIR}/''${PICS[$i]}\n"
      done
      for i in "''${!PICS_DEFAULT[@]}"; do
        if [[ "''${PICS_DEFAULT[$i]}" != "hyprland.conf" ]]; then
          printf "''${PICS_DEFAULT[$i]}\0icon\x1f''${WALL_DIR_DEFAULT}/''${PICS_DEFAULT[$i]}\n"
        fi
      done
    }

    monitor_menu() {
      for i in "''${!MONITORS[@]}"; do
        echo "''${MONITORS[$i]}"
      done
    }

    main() {
      pick=$(wall_menu | rofi -dmenu -p "  Wallpapers " -config ~/.config/rofi/config_wallpaper.rasi)
      if [[ -z $pick ]]; then
        exit 0
      fi

      if [[ -z $pick ]]; then
        exit 0
      fi
      image_path="''${WALL_DIR}/''${pick}"

      monitor=$(monitor_menu | rofi -dmenu -p "  Displays ")

      if [[ -z $monitor ]]; then
        exit 0
      fi

      if ! $(swww img --outputs "''${monitor}" "''${image_path}" 2>/dev/null); then
        image_path="''${WALL_DIR_DEFAULT}/''${pick}"
        swww img --outputs "''${monitor}" "''${image_path}"
      fi
    }

    swww query || swww-daemon
    main
  '';
in
{
  home.packages = [ set-wallpaper ];
}
