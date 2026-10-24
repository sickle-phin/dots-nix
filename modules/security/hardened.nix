{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (lib.meta) getExe';
in
{
  boot = {
    kernel.sysctl = {
      "dev.tty.ldisc_autoload" = 0;
      "fs.protected_fifos" = 2;
      "fs.protected_hardlinks" = 1;
      "fs.protected_regular" = 2;
      "fs.protected_symlinks" = 1;
      "fs.suid_dumpable" = 0;
      "kernel.core_pattern" = "|${getExe' pkgs.coreutils "false"}";
      "kernel.ctrl-alt-del" = 0;
      "kernel.dmesg_restrict" = 1;
      "kernel.ftrace_enabled" = 0;
      # Restrict io_uring to CAP_SYS_ADMIN processes; ordinary apps cannot create rings.
      "kernel.io_uring_disabled" = 1;
      "kernel.io_uring_group" = -1;
      "kernel.kexec_load_disabled" = 1;
      "kernel.kptr_restrict" = 2;
      "kernel.perf_event_paranoid" = 3;
      "kernel.printk" = "3 3 3 3";
      "kernel.randomize_va_space" = 2;
      "kernel.sysrq" = 0;
      "kernel.unprivileged_bpf_disabled" = 1;
      "kernel.yama.ptrace_scope" = 1;
      "net.core.bpf_jit_harden" = 2;
      # Leave forwarding and IPv6 RA to NetworkManager/virtualisation services.
      # Echo requests are filtered by networking.firewall.allowPing.
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv4.conf.all.log_martians" = 1;
      # Loose reverse-path checks support VPNs and asymmetric routing.
      "net.ipv4.conf.all.rp_filter" = 2;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv4.conf.default.log_martians" = 1;
      "net.ipv4.conf.default.rp_filter" = 2;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      "net.ipv4.tcp_dsack" = 1;
      "net.ipv4.tcp_rfc1337" = 1;
      "net.ipv4.tcp_sack" = 1;
      "net.ipv4.tcp_syncookies" = 1;
      # Preserve PAWS/RTT measurement with randomized timestamp offsets.
      "net.ipv4.tcp_timestamps" = 1;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.use_tempaddr" = 2;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_source_route" = 0;
      "vm.mmap_min_addr" = 65536;
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_rnd_compat_bits" = 16;
      "vm.unprivileged_userfaultfd" = 0;
    };

    kernelParams = [
      "debugfs=off"
      "init_on_alloc=1"
      "init_on_free=1"
      # Retained for a future kernel with lockdown and trusted module signing.
      # These parameters alone do not enable support in the current XanMod kernel.
      "lockdown=confidentiality"
      "module.sig_enforce=1"
      "oops=panic"
      "page_alloc.shuffle=1"
      "randomize_kstack_offset=on"
      "slab_nomerge"
      "vsyscall=none"
    ];

    blacklistedKernelModules = builtins.concatLists [
      [
        # Obscure network protocols
        "af_802154" # IEEE 802.15.4
        "appletalk" # Appletalk
        "atm" # ATM
        "ax25" # Amateur X.25
        "can" # Controller Area Network
        "dccp" # Datagram Congestion Control Protocol
        "decnet" # DECnet
        "econet" # Econet
        "ipx" # Internetwork Packet Exchange
        "n-hdlc" # High-level Data Link Control
        "netrom" # NetRom
        "p8022" # IEEE 802.3
        "p8023" # Novell raw IEEE 802.3
        "psnap" # SubnetworkAccess Protocol
        "rds" # Reliable Datagram Sockets
        "rose" # ROSE
        "sctp" # Stream Control Transmission Protocol
        "tipc" # Transparent Inter-Process Communication
        "x25" # X.25

        # Unused filesystems. Keep SMB/NFS, removable-media and image formats
        # available for normal desktop use (CIFS, HFS, UDF, SquashFS, F2FS).
        "adfs" # Acorn Disc Filing System
        "affs" # Amiga Fast File System
        "befs" # "Be File System"
        "bfs" # BFS, used by SCO UnixWare OS for the /stand slice
        "cramfs" # compressed ROM/RAM file system
        "efs" # Extent File System
        # "erofs" # Enhanced Read-Only File System - required for etc overlay
        "exofs" # EXtended Object File System
        "freevxfs" # Veritas filesystem driver
        "vivid" # Virtual Video Test Driver (unnecessary)
        "gfs2" # Global File System 2
        "hpfs" # High Performance File System (used by OS/2)
        "jffs2" # Journalling Flash File System (v2)
        "jfs" # Journaled File System - only useful for VMWare sessions
        "ksmbd" # SMB3 Kernel Server
        "minix" # minix fs - used by the minix OS
        "nilfs2" # New Implementation of a Log-structured File System
        "omfs" # Optimized MPEG Filesystem
        "qnx4" # extent-based file system used by the QNX4 and QNX6 OSes
        "qnx6" # ^
        "sysv" # implements all of Xenix FS, SystemV/386 FS and Coherent FS.
      ]
      (optionals (!config.myOptions.hasBluetooth) [
        "bluetooth"
        "btusb" # bluetooth dongles
      ])
    ];
  };

  security = {
    forcePageTableIsolation = true;
    protectKernelImage = true;
    # Conditional L1 flushing balances guest isolation and VM performance.
    virtualisation.flushL1DataCache = "cond";
  };
}
