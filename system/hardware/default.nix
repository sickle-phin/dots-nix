{
  imports = [
    ./bluetooth.nix
    ./gpu.nix
    ./performance.nix
    ./sound.nix
    ./xremap.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
