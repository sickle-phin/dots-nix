{
  imports = [ ./mozc.nix ];

  xdg.dataFile = {
    "applications/brave-browser.desktop" = {
      source = ./brave-browser.desktop;
    };
    "applications/firefox.desktop" = {
      source = ./firefox.desktop;
    };
    "applications/slack.desktop" = {
      source = ./slack.desktop;
    };
    "applications/teams-for-linux.desktop" = {
      source = ./teams-for-linux.desktop;
    };
    "applications/org.wireshark.Wireshark.desktop" = {
      source = ./org.wireshark.Wireshark.desktop;
    };
  };
}
