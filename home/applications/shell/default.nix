{ config, ... }:
let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in
{
  imports = [
    ./starship.nix
    ./terminals.nix
    ./zsh.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";

    # set default applications
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";

    SYSTEMD_PAGERSECURE = "true";
    PAGER = "less -FR";
    DELTA_PAGER = "less -R";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
