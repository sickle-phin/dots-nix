
{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    breeze-qt5
  ];
}
