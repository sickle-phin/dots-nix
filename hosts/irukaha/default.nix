{ inputs, config, pkgs, lib, ... }:
{
  imports =
    [
      ../../modules
      ../../modules/gamemode.nix
      ./hardware-configuration.nix
      ./disk-config.nix
      ./impermanence.nix
    ];

  # Bootloader.
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = lib.mkForce false;
        consoleMode = "max";
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        useOSProber = false;
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      };
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    plymouth.enable = true;
    plymouth.theme = "breeze";
    plymouth.extraConfig = "DeviceScale=an-integer-scaling-factor";
    consoleLogLevel = 0;
    initrd.verbose = false;
    initrd.systemd.network.wait-online.enable = false;
    tmp.cleanOnBoot = true;
  };

  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "irukaha";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    resolvconf.dnsExtensionMechanism = false;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    bluetooth.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.blueman.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    VK_DRIVER_FILES="/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    VKD3D_CONFIG="dxr11,dxr";
    PROTON_ENABLE_NVAPI = 1;
    PROTON_ENABLE_NGX_UPDATER = 1;
    PROTON_HIDE_NVIDIA_GPU = 0;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    platformOptimizations.enable = true;
  };

  environment.systemPackages = with pkgs; [
    steam-run
  ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  system.stateVersion = "23.11";

}

