# https://github.com/dracula/fuzzel/blob/main/fuzzel.ini
{ config, ... }:
{
  xdg.configFile."fuzzel/Dracula.ini".text = ''
    [main]
    include=${config.xdg.configHome}/fuzzel/fuzzel.ini
    icon-theme=Dracula
    [colors]
    background=282a36dd
    text=f8f8f2ff
    match=8be9fdff
    selection-match=8be9fdff
    selection=44475add
    selection-text=f8f8f2ff
    border=bd93f9ff
  '';
}
