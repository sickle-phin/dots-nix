{ osConfig, pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      grimblast
      hyprpicker
      networkmanagerapplet
      quickshell
      swappy
      swww
      tesseract
      wayland-bongocat
      wl-clipboard
      wl-clip-persist
      wl-screenrec
      ;
  };
  xdg.configFile = {
    "swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/Screenshot
    '';
    "bongocat.conf".text = ''
      cat_height=47
      cat_x_offset=-855
      cat_y_offset=8
      overlay_opacity=0
      overlay_position=top
      fps=60
      keypress_duration=100
      test_animation_interval=0
      keyboard_device=/dev/input/event0
      enable_debug=0
    '';
  };
  services = {
    cliphist.enable = true;
    hyprpolkitagent.enable = true;
    hyprsunset.enable = osConfig.myOptions.isLaptop;
    swww.enable = true;
    udiskie.enable = true;
  };
}
