{ config, ... }:
{
  xdg.configFile."fuzzel/Nord.ini".text = ''
    [main]
    include=${config.xdg.configHome}/fuzzel/fuzzel.ini
    icon-theme=Nordic-green
    [colors]
    background=3b4252dd
    text=d8dee9ff
    match=8fbcbbff
    selection=434c5eff
    selection-text=d8dee9ff
    selection-match=8fbcbbff
    border=8fbcbbff
  '';
}
