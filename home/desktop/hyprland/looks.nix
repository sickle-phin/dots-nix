{
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        gaps_in = 4;
        gaps_out = {
          top = 9;
          right = 8;
          bottom = 9;
          left = 8;
        };
        border_size = 0;

        resize_on_border = true;
        extend_border_grab_area = 30;

        layout = "scrolling";

        allow_tearing = false;

        snap.enabled = true;
      };

      decoration = {
        rounding = 10;
        rounding_power = 3;

        blur = {
          enabled = true;
          size = 6;
          passes = 1;
          popups = true;
          input_methods = true;
        };

        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
      };

      animations.enabled = true;
    };

    curve = [
      {
        _args = [
          "rubber"
          {
            type = "spring";
            mass = 1;
            stiffness = 50;
            dampening = 12;
          }
        ];
      }
      {
        _args = [
          "smooth"
          {
            type = "spring";
            mass = 1;
            stiffness = 100;
            dampening = 20;
          }
        ];
      }
    ];

    animation = [
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 4;
        spring = "rubber";
        style = "slide";
      }
      {
        leaf = "windowsOut";
        enabled = true;
        speed = 4;
        spring = "rubber";
        style = "slide";
      }
      {
        leaf = "windowsMove";
        enabled = true;
        speed = 4;
        spring = "rubber";
      }
      {
        leaf = "workspaces";
        enabled = true;
        speed = 4;
        spring = "smooth";
      }
    ];
  };
}
