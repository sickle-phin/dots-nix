{ pkgs, ... }:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };

    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      dive
      podman-tui
      podman-compose
      ;
  };
  programs.virt-manager.enable = true;
}
