{ config, ... }:
{
  xdg.configFile."fuzzel/Adwaita Light.ini".text = ''
    [main]
    include=${config.xdg.configHome}/fuzzel/fuzzel.ini
    icon-theme=Papirus-Light
    [colors]
    background=ffffffdd
    text=2f2f2fff
    match=3584e4ff
    selection=f1f1f1ff
    selection-text=2f2f2fff
    selection-match=3584e4ff
    border=3584e4ff
  '';
}
