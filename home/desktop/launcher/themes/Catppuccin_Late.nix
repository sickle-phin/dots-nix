# https://github.com/catppuccin/fuzzel/blob/main/themes/catppuccin-latte/pink.ini
{ config, ... }:
{
  xdg.configFile."fuzzel/Catppuccin Latte.ini".text = ''
    [main]
    include=${config.xdg.configHome}/fuzzel/fuzzel.ini
    icon-theme=Papirus-Light
    [colors]
    background=eff1f5dd
    text=4c4f69ff
    prompt=5c5f77ff
    placeholder=8c8fa1ff
    input=4c4f69ff
    match=ea76cbff
    selection=acb0beff
    selection-text=4c4f69ff
    selection-match=ea76cbff
    counter=8c8fa1ff
    border=ea76cbff
  '';
}
