{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./gpu.nix
    ./performance.nix
    ./xremap.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
