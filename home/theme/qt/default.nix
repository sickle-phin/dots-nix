
{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    qt5ct
    breeze-qt5
  ];
  
  xdg.configFile = {
    "qt5ct/qt5ct.conf" = {
      source = ./qt5ct.conf;
      recursive = true;
    };
  };
}
