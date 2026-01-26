{
  imports = [
    ../../modules
    "${
      builtins.fetchTarball {
        url = "https://github.com/nix-community/disko/archive/refs/tags/latest.tar.gz";
        sha256 = "03jz60kw0khm1lp72q65z8gq69bfrqqbj08kw0hbiav1qh3g7p08";
      }
    }/module.nix"
    ./disk-config.nix
    ./hardware-configuration.nix
    ./profile.nix
  ];
}
