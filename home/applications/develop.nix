{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      gcc
      gnumake
      python3
      yarn
      ;
  };
}
