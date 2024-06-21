{ config
, ...
}:{
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
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

  programs.ssh.startAgent = true;
}
