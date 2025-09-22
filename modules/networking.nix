{
  config,
  hostname,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkDefault;
  inherit (lib.modules) mkIf;
in
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
      wifi = {
        backend = "iwd";
        macAddress = "random";
      };
      ethernet.macAddress = mkIf (config.networking.hostName != "pink") "random";
      connectionConfig."ipv6.ip6-privacy" = 2;
    };
    wireless.iwd.settings.General.AddressRandomization = "network";

    firewall = {
      enable = true;
      allowPing = false;
      interfaces."virbr*" = mkIf config.virtualisation.libvirtd.enable {
        allowedTCPPorts = [ 53 ];
        allowedUDPPorts = [
          53
          67
        ];
      };
    };
    nftables.enable = true;
  };

  boot = {
    kernel.sysctl = {
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
    };
    kernelModules = [ "tcp_bbr" ];

    initrd.systemd.network.wait-online.enable = false;
  };

  systemd = {
    network.wait-online.enable = false;
    services.NetworkManager-wait-online.enable = false;
  };

  services = {
    dnscrypt-proxy = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        server_names = [
          "cloudflare"
          "cloudflare-ipv6"
        ];
      };
    };

    openssh = {
      enable = mkDefault config.myOptions.test.enable;
      startWhenNeeded = mkDefault false;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AuthenticationMethods = "publickey";
        PubkeyAuthentication = "yes";
        ChallengeResponseAuthentication = "no";
        UsePAM = false;
        UseDns = false;
        X11Forwarding = false;
      };
      openFirewall = true;
      hostKeys = [
        {
          path =
            if config.preservation.enable then
              "/persistent/etc/ssh/ssh_host_ed25519_key"
            else
              "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
      knownHosts = {
        "github.com" = {
          hostNames = [
            "github.com"
          ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        };
      };
    };

    tailscale.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
