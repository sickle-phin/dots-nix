{ config, lib, ... }:
let
  inherit (lib.lists) concatLists optionals;
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
      "kernel.core_pattern" = "|/bin/false";
      "kernel.core_uses_pid" = 1;
      "kernel.ctrl-alt-del" = 0;
      "kernel.dmesg_restrict" = 1;
      "kernel.ftrace_enabled" = 0;
      "kernel.kptr_restrict" = 2;
      "kernel.perf_event_paranoid" = 3;
      "kernel.printk" = "3 3 3 3";
      "kernel.randomize_va_space" = 2;
      "kernel.sysrq" = 0;
      "kernel.unprivileged_bpf_disabled" = 1;
      "kernel.yama.ptrace_scope" = 1;
      "net.core.bpf_jit_harden" = 2;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv4.conf.all.log_martians" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv4.conf.default.log_martians" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.icmp_echo_ignore_all" = 1;
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      "net.ipv4.tcp_dsack" = 1;
      "net.ipv4.tcp_fack" = 1;
      "net.ipv4.tcp_sack" = 1;
      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.tcp_rfc1337" = 1;
      "net.ipv6.conf.all.accept_ra" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.use_tempaddr" = 2;
      "net.ipv6.conf.default.accept_ra" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.defalut.accept_source_route" = 0;
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_rnd_compat_bits" = 16;
      "vm.swappiness" = 1;
      "vm.unprivileged_userfaultfd" = 0;
    };

    kernelParams = [
      "boot.shell_on_fail"
      "debugfs=off"
      "fbcon=nodefer"
      "init_on_alloc=1"
      "init_on_free=1"
      "lockdown=confidentiality"
      "loglevel=0"
      "mce=0"
      "module.sig_enforce=1"
      "oops=panic"
      "page_alloc.shuffle=1"
      "page_poison=1"
      "quiet"
      "randomize_kstack_offset=on"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "slab_nomerge"
      "sysrq_always_enabled=0"
      "udev.log_priority=0"
      "vsyscall=none"
    ];

    blacklistedKernelModules = concatLists [
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

        # Old or rare or insufficiently audited filesystems
        "adfs" # Active Directory Federation Services
        "affs" # Amiga Fast File System
        "befs" # "Be File System"
        "bfs" # BFS, used by SCO UnixWare OS for the /stand slice
        "cramfs" # compressed ROM/RAM file system
        "cifs" # smb (Common Internet File System)
        "efs" # Extent File System
        "erofs" # Enhanced Read-Only File System
        "exofs" # EXtended Object File System
        "freevxfs" # Veritas filesystem driver
        "f2fs" # Flash-Friendly File System
        "vivid" # Virtual Video Test Driver (unnecessary)
        "gfs2" # Global File System 2
        "hpfs" # High Performance File System (used by OS/2)
        "hfs" # Hierarchical File System (Macintosh)
        "hfsplus" # " same as above, but with extended attributes
        "jffs2" # Journalling Flash File System (v2)
        "jfs" # Journaled File System - only useful for VMWare sessions
        "ksmbd" # SMB3 Kernel Server
        "minix" # minix fs - used by the minix OS
        "nfsv3" # " (v3)
        "nfsv4" # Network File System (v4)
        "nfs" # Network File System
        "nilfs2" # New Implementation of a Log-structured File System
        "omfs" # Optimized MPEG Filesystem
        "qnx4" # extent-based file system used by the QNX4 and QNX6 OSes
        "qnx6" # ^
        "squashfs" # compressed read-only file system (used by live CDs)
        "sysv" # implements all of Xenix FS, SystemV/386 FS and Coherent FS.
        "udf" # https://docs.kernel.org/5.15/filesystems/udf.html
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
    virtualisation.flushL1DataCache = "always";
  };
}
