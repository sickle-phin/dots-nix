# https://github.com/catppuccin/fuzzel/blob/main/themes/catppuccin-mocha/pink.ini
{ config, ... }:
{
  xdg.configFile."fuzzel/Catppuccin Mocha.ini".text = ''
    [main]
    include=${config.xdg.configHome}/fuzzel/fuzzel.ini
    icon-theme=Papirus-Dark
    [colors]
    background=1e1e2edd
    text=cdd6f4ff
    prompt=bac2deff
    placeholder=7f849cff
    input=cdd6f4ff
    match=f5c2e7ff
    selection=585b70ff
    selection-text=cdd6f4ff
    selection-match=f5c2e7ff
    counter=7f849cff
    border=f5c2e7ff
  '';
}
