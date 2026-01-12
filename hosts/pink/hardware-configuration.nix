{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "aesni_intel"
        "cryptd"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-intel"
      "iwlwifi"
    ];
    kernelParams = [ "i915.enable_guc=2" ];
    extraModprobeConfig = "";
    extraModulePackages = [ ];
  };

  systemd.tmpfiles.rules = [
    "w /sys/firmware/acpi/interrupts/gpe6F - - - - disable"
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20f0u4c2.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
