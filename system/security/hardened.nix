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
      "kernel.yama.ptrace_scope" = 2;
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
      "init_on_alloc=1"
      "init_on_free=1"
      "lockdown=confidentiality"
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
      "splash"
      "udev.log_priority=0"
      "vsyscall=none"
      "loglevel=0"
    ];

    blacklistedKernelModules = [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"

      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];
  };

  security = {
    lockKernelModules = true;
    protectKernelImage = true;
    forcePageTableIsolation = true;
    virtualisation.flushL1DataCache ="always";
  };
}
