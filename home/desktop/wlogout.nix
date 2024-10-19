{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        text = "Lock";
        action = "sleep 0.1 && pidof hyprlock || hyprlock &";
        keybind = "l";
      }
      {
        label = "suspend";
        text = "Suspend";
        action = "systemctl suspend";
        keybind = "u";
      }
      {
        label = "logout";
        text = "Logout";
        action = "loginctl kill-session $XDG_SESSION_ID";
        keybind = "e";
      }
      {
        label = "reboot";
        text = "Reboot";
        action = "systemctl reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        text = "Shutdown";
        action = "systemctl poweroff";
        keybind = "s";
      }
    ];

    # reference: https://github.com/JaKooLit/Hyprland-Dots/blob/main/config/wlogout/style.css
    style = ''
      window {
        /* font-family: 'Fira Sans Condensed', sans-serif; */
        font-size: 16pt;
        color: #cdd6f4;
        background-color: rgba(30, 30, 46, 0.6);
      }

      /** ********** Buttons ********** **/
      button {
        background-repeat: no-repeat;
        background-position: center;
        background-size: 20%;
        background-color: rgba(200, 220, 255, 0);
        animation: gradient_f 20s ease-in infinite;
        border-radius: 80px;
      }

      button:focus {
          background-size: 25%;
      	border: 0px;
      }

      button:active,

      button:hover {
        background-color: rgba(203, 166, 247, 0.8);
        color: #1e1e2e;
        background-size: 50%;
        margin: 30px;
        border-radius: 80px;
        transition: all 0.3s cubic-bezier(.55, 0.0, .28, 1.682), box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
        box-shadow: 0 0 20px #89b4fa;
      }

      button span {
          font-size: 1.2em;
      }

      /** ********** Icons ********** **/
      #lock {
          background-image: image(url("${./icons/lock.png}"));
      }
      #lock:hover {
          background-image: image(url("${./icons/lock-hover.png}"));
      }

      #logout {
          background-image: image(url("${./icons/logout.png}"));
      }
      #logout:hover {
          background-image: image(url("${./icons/logout-hover.png}"));
      }

      #suspend {
          background-image: image(url("${./icons/sleep.png}"));
      }
      #suspend:hover {
          background-image: image(url("${./icons/sleep-hover.png}"));
      }

      #shutdown {
          background-image: image(url("${./icons/power.png}"));
      }
      #shutdown:hover {
          background-image: image(url("${./icons/power-hover.png}"));
      }

      #reboot {
          background-image: image(url("${./icons/restart.png}"));
      }
      #reboot:hover {
          background-image: image(url("${./icons/restart-hover.png}"));
      }
    '';
  };
}
