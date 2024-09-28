{
  pkgs,
  hostname,
  ...
}:
{
  networking = {
    hostName = "${hostname}";
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
      connectionConfig."ipv6.ip6-privacy" = 2;
    };
    firewall = {
      enable = true;
      # trustedInterfaces = [ "tailscale0" ];
      # allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  services = {
    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        server_names = [ "cloudflare" ];
      };
    };

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

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    dnscrypt-proxy2.serviceConfig = {
      StateDirectory = "dnscrypt-proxy";
    };
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
