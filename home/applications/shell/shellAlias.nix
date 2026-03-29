{ pkgs, ... }:
{
  home.shellAliases = {
    bat = "bat --pager 'less -FR'";
    cat = "bat --pager 'less -FR'";
    cp = "cp -iv";
    du = "dust";
    ls = "lsd -Fg --group-directories-first --date \"+%F %T\"";
    ll = "lsd -Fgl --group-directories-first --date \"+%F %T\"";
    la = "lsd -AFg --group-directories-first --date \"+%F %T\"";
    lt = "lsd -Fg --group-directories-first --tree --date \"+%F %T\"";
    lla = "lsd -AFgl --group-directories-first --date \"+%F %T\"";
    llt = "lsd -Fgl --group-directories-first --tree --date \"+%F %T\"";
    mkdir = "mkdir -pv";
    mv = "mv -iv";
    neofetch = "fastfetch";
    mozc_tool = "${pkgs.mozc}/lib/mozc/mozc_tool";
    grep = "rg";
    g = "git";
    sudo = "sudo ";
    rebuild-nixos = "sudo ls /dev/null > /dev/null 2>&1 && gamemoderun rebuild-nixos";
    v = "nvim";
    rm = "rm -iv";
    open = "xdg-open";
  };
}
