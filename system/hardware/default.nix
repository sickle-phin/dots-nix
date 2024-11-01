{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./gpu.nix
    ./powermanagement.nix
    ./xremap.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
