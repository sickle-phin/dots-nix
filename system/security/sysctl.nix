{
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.printk" = "3 3 3 3";
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;
  };
}
