{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      dive
      podman-tui
      podman-compose
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
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = false;
              tpmSupport = false;
            }).fd
          ];
        };
      };
    };
    spiceUSBRedirection.enable = true;
    waydroid.enable = true;
  };

  programs.virt-manager.enable = true;
}
