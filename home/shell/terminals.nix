{ pkgs
, lib
, inputs
, ... }: {
  programs = {
    foot = {
      enable = true;
      catppuccin.enable = true;
      server.enable = false;
      settings = {
        main = {
          term = "xterm-256color";
          notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
          font = "PlemolJP Console NF:size=19.5, Symbols Nerd Font Mono:size=19.5:style=Regular";
          dpi-aware = "no";
          pad = "10x10";
        };
        scrollback.lines = 100000;
        cursor = {
          color = "000000 f4b7d6";
        };
        colors = {
          alpha = 0.6;
          background = lib.mkForce "000000";
        };
      };
    };
    wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;
    };
  };

  xdg.configFile = {
    "wezterm/wezterm.lua" = {
      source = ./wezterm.lua;
    };
  };
}
