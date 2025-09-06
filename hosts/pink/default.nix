{
  imports = [
    ../../modules
    "${
      builtins.fetchTarball {
        url = "https://github.com/nix-community/disko/archive/refs/tags/v1.12.0.tar.gz";
        sha256 = "0wbx518d2x54yn4xh98cgm65wvj0gpy6nia6ra7ns4j63hx14fkq";
      }
    }/module.nix"
    ./disk-config.nix
    ./hardware-configuration.nix
    ./profile.nix
  ];
}
