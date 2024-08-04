{ config
, hostname
, ...
}:{
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    resolvconf.dnsExtensionMechanism = false;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  services = {
    openssh = {
      enable = false;
      settings = {
        #X11Forwarding = true;
        #PermitRootLogin = "no"; # disable root login
        #PasswordAuthentication = false; # disable password login
      };
      openFirewall = true;
    };

    tailscale.enable = true;
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}
