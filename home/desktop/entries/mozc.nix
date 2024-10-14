{ pkgs, ... }:
{
  xdg.desktopEntries = {
    "mozc config dialog" = {
      name = "mozc config dialog";
      genericName = "mozc config dialog";
      icon = "mozc";
      exec = "${pkgs.fcitx5-mozc}/lib/mozc/mozc_tool --mode=config_dialog";
      type = "Application";
      categories = [ "Settings" ];
    };
    "mozc dictionary tool" = {
      name = "mozc dictionary tool";
      genericName = "mozc user dictionary tool";
      icon = "mozc";
      exec = "${pkgs.fcitx5-mozc}/lib/mozc/mozc_tool --mode=dictionary_tool";
      type = "Application";
      categories = [ "Settings" ];
    };
  };
}
