{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      dive
      podman-tui
      podman-compose
      waydroid-helper
      ;
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = false;
      };
    };
    spiceUSBRedirection.enable = true;
    waydroid.enable = true;
  };

  programs.virt-manager.enable = true;
}
