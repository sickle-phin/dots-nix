{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      gcc
      gnumake
      yarn
      ;
  };
}
