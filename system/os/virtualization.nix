{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;
}
