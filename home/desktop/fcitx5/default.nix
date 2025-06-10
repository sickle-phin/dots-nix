{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      fcitx5-with-addons = pkgs.kdePackages.fcitx5-with-addons;
      addons = [ pkgs.fcitx5-mozc-ut ]; # crash mozc_tool
      waylandFrontend = true;
    };
  };

  xdg = {
    configFile = {
      "fcitx5/profile" = {
        source = ./profile;
        force = true;
      };
      "fcitx5/config" = {
        source = ./config;
        force = true;
      };
      "fcitx5/conf/classicui.conf" = {
        text = "Theme=catppuccin-mocha-pink";
      };
    };
    dataFile = {
      "fcitx5/themes/catppuccin-mocha-pink" = {
        source = ./catppuccin-mocha-pink;
      };
    };
    desktopEntries = {
      "org.fcitx.Fcitx5" = {
        name = "Fcitx 5";
        noDisplay = true;
      };
      "org.fcitx.fcitx5-migrator" = {
        name = "Fcitx 5 Migration Wizard";
        noDisplay = true;
      };
      "mozc config dialog" = {
        name = "mozc config dialog";
        genericName = "mozc config dialog";
        icon = "mozc";
        exec = "${pkgs.mozc}/lib/mozc/mozc_tool --mode=config_dialog";
        type = "Application";
        categories = [ "Settings" ];
      };
      "mozc dictionary tool" = {
        name = "mozc dictionary tool";
        genericName = "mozc user dictionary tool";
        icon = "mozc";
        exec = "${pkgs.mozc}/lib/mozc/mozc_tool --mode=dictionary_tool";
        type = "Application";
        categories = [ "Settings" ];
      };
    };
  };
}
