{ pkgs
, ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      prompt = "Apps";
      always_parse_args = true;
      print_command = true;
      show_all=false;
      layer = "top";
      term = "${pkgs.foot}/bin/foot";
      width = "600px";
      height = "400px";
      location = 0;
      orientation = "vertical";
      halign = "fill";
      line_wrap = "off";
      dynamic_lines = false;
      allow_markup = true;
      allow_images = true;
      image_size = 24;
      exec_search = true;
      hide_search = false;
      parse_search = true;
      insensitive = true;
      hide_scroll = true;
      no_actions = true;
      sort_order = "default";
      gtk_dark = false;
      filter_rate = 100;
      key_exit = "Escape";
    };
    style = ''
      @define-color	red  #f38ba8;
      @define-color	pink  #f5c2e7;
      @define-color	mauve  #cba6f7;
      @define-color	mauve-rgba  rgba(203, 166, 247, 0.5);
      @define-color	sapphire  #74c7ec;
      @define-color	base-rgba  rgba(30, 30, 46, 0.8);
      @define-color	surface0-rgba  rgba(49, 50, 68, 0.6);
      @define-color	lavender  #b4befe;
      @define-color	text  #cdd6f4;

      * {
        /* font-family: 'PlemolJP HS'; */
        font-size: 15px;
      }

      window {
        border: 0.16em solid @mauve;
        border-radius: 10px;
        background-color: @base-rgba;
        animation: slideIn 0.2s ease-in-out both;
      }

      @keyframes slideIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      #inner-box {
        border: none;
        animation: fadeIn 0.2s ease-in-out both;
      }

      @keyframes fadeIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      #scroll {
        margin: 5px;
        padding: 15px 20px;
        border: none;
        animation: fadeIn 0.2s ease-in-out both;
      }

      #input {
        margin: 20px 20px 0px 20px;
        padding: 5px;
        border-radius: 5px;
        color: @text;
        background-color: @surface0-rgba;
        animation: fadeIn 0.2s ease-in-out both;
      }

      #input:focus {
        border-radius: 5px;
      }

      #input image {
          border: none;
          color: @red;
      }

      #input * {
        outline: 4px solid @pink;
      }

      #text {
        margin: 3px;
        border: none;
        color: @text;
        animation: fadeIn 0.2s ease-in-out both;
      }

      #entry arrow {
        border: none;
        color: @lavender;
      }

      #entry:selected {
        border-radius: 5px;
        background-color: @mauve-rgba;
      }

      #entry:drop(active) {
        background-color: @mauve-rgba;
      }

      #img {
        padding-right: 8px;
      }
    '';
  };

  xdg.configFile = {
    "wofi/config_wallpaper" = {
      source = ./config_wallpaper;
    };
  };
}
