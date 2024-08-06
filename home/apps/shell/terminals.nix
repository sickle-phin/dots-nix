{ pkgs
, lib
, osConfig
, ... }: {
  programs = {
    foot = {
      enable = true;
      package = pkgs.foot.overrideAttrs rec {
        version = "1.18.0";
        src = pkgs.fetchFromGitea {
          domain = "codeberg.org";
          owner = "dnkl";
          repo = "foot";
          rev = "${version}";
          sha256 = "sha256-C+KzQvySWJY2FRYYvsaL9BXrQzRGbqpG3qDWOImZzv4=";
        };
      };
      catppuccin.enable = true;
      server.enable = false;
      settings = {
        main = {
          term = "foot";
          # notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
          font = let
            fontsize = if osConfig.networking.hostName == "irukaha" then
               "19.0"
             else if osConfig.networking.hostName == "pink" then
               "13.5"
             else
               "19.0";
          in
            "PlemolJP Console NF:size=${fontsize}, Symbols Nerd Font Mono:size=${fontsize}:style=Regular, Apple Color Emoji:size=${fontsize}";
          dpi-aware = "yes";
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
  };
}
