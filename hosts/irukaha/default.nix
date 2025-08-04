{
  imports = [
    ../../modules
    "${
      builtins.fetchTarball {
        url = "https://github.com/nix-community/disko/archive/refs/tags/v1.11.0.tar.gz";
        sha256 = "13brimg7z7k9y36n4jc1pssqyw94nd8qvgfjv53z66lv4xkhin92";
      }
    }/module.nix"
    ./disk-config.nix
    ./hardware-configuration.nix
    ./profile.nix
  ];
}
