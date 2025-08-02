{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./gpu.nix
    ./powermanagement.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
