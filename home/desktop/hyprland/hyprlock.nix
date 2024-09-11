{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "screenshot";
        blur_passes = 1;
        blur_size = 6;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      general = {
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      input-field = {
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.5)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
        hide_input = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          text = "cmd[update:1000] echo \"<b>$(date +\"%-H:%M\")</b>\"";
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 120;
          font_family = "PlemolJP HS";
          position = "0, -300";
          halign = "center";
          valign = "top";
        }
        {
          text = "cmd[update:1000] echo \"$(date +\"%a, %B %-d\")\"";
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 25;
          font_family = "PlemolJP HS";
          position = "0, -470";
          halign = "center";
          valign = "top";
        }
        {
          text = "<i>Hi there, $USER</i>";
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 25;
          font_family = "PlemolJP HS";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
