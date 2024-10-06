{
  systemd.services = {
    NetworkManager-dispatcher = {
      serviceConfig = {
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateUsers = true;
        PrivateDevices = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = "AF_INET";
        RestrictNamespaces = true;
        SystemCallFilter = [
          "write"
          "read"
          "openat"
          "close"
          "brk"
          "fstat"
          "lseek"
          "mmap"
          "mprotect"
          "munmap"
          "rt_sigaction"
          "rt_sigprocmask"
          "ioctl"
          "nanosleep"
          "select"
          "access"
          "execve"
          "getuid"
          "arch_prctl"
          "set_tid_address"
          "set_robust_list"
          "prlimit64"
          "pread64"
          "getrandom"
        ];
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any";
      };
    };

    NetworkManager = {
      serviceConfig = {
        NoNewPrivileges = true;
        ProtectClock = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        SystemCallArchitectures = "native";
        MemoryDenyWriteExecute = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        RestrictNamespaces = true;
        ProtectKernelTunables = true;
        ProtectHome = true;
        PrivateTmp = true;
        UMask = "0077";
      };
    };

    emergency = {
      serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        PrivateUsers = true;
        PrivateDevices = true; # Might need adjustment for emergency access
        PrivateIPC = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = "AF_INET";
        RestrictNamespaces = true;
        SystemCallFilter = [
          "write"
          "read"
          "openat"
          "close"
          "brk"
          "fstat"
          "lseek"
          "mmap"
          "mprotect"
          "munmap"
          "rt_sigaction"
          "rt_sigprocmask"
          "ioctl"
          "nanosleep"
          "select"
          "access"
          "execve"
          "getuid"
          "arch_prctl"
          "set_tid_address"
          "set_robust_list"
          "prlimit64"
          "pread64"
          "getrandom"
        ];
        UMask = "0077";
        IPAddressDeny = "any";
      };
    };

    "getty@tty1" = {
      serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        PrivateUsers = true;
        PrivateDevices = true;
        PrivateIPC = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = "AF_INET";
        RestrictNamespaces = true;
        SystemCallFilter = [
          "write"
          "read"
          "openat"
          "close"
          "brk"
          "fstat"
          "lseek"
          "mmap"
          "mprotect"
          "munmap"
          "rt_sigaction"
          "rt_sigprocmask"
          "ioctl"
          "nanosleep"
          "select"
          "access"
          "execve"
          "getuid"
          "arch_prctl"
          "set_tid_address"
          "set_robust_list"
          "prlimit64"
          "pread64"
          "getrandom"
        ];
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any";
      };
    };

    "getty@tty7" = {
      serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        PrivateUsers = true;
        PrivateDevices = true;
        PrivateIPC = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = "AF_INET";
        RestrictNamespaces = true;
        SystemCallFilter = [
          "write"
          "read"
          "openat"
          "close"
          "brk"
          "fstat"
          "lseek"
          "mmap"
          "mprotect"
          "munmap"
          "rt_sigaction"
          "rt_sigprocmask"
          "ioctl"
          "nanosleep"
          "select"
          "access"
          "execve"
          "getuid"
          "arch_prctl"
          "set_tid_address"
          "set_robust_list"
          "prlimit64"
          "pread64"
          "getrandom"
        ];
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any";
      };
    };

    nix-daemon = {
      serviceConfig = {
        ProtectHome = true;
        PrivateUsers = false;
      };
    };

    rescue = {
      serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        PrivateUsers = true;
        PrivateDevices = true; # Might need adjustment for rescue operations
        PrivateIPC = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = "AF_INET AF_INET6"; # Networking might be necessary in rescue mode
        RestrictNamespaces = true;
        SystemCallFilter = [
          "write"
          "read"
          "openat"
          "close"
          "brk"
          "fstat"
          "lseek"
          "mmap"
          "mprotect"
          "munmap"
          "rt_sigaction"
          "rt_sigprocmask"
          "ioctl"
          "nanosleep"
          "select"
          "access"
          "execve"
          "getuid"
          "arch_prctl"
          "set_tid_address"
          "set_robust_list"
          "prlimit64"
          "pread64"
          "getrandom"
        ];
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any"; # May need to be relaxed for network troubleshooting in rescue mode
      };
    };

    "systemd-ask-password-console" = {
      serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        PrivateUsers = true;
        PrivateDevices = true; # May need adjustment for console access
        PrivateIPC = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = "AF_INET AF_INET6";
        RestrictNamespaces = true;
        SystemCallFilter = [ "@system-service" ]; # A more permissive filter
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any";
      };
    };

    "systemd-ask-password-wall" = {
      serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        PrivateUsers = true;
        PrivateDevices = true;
        PrivateIPC = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = "AF_INET AF_INET6";
        RestrictNamespaces = true;
        SystemCallFilter = [ "@system-service" ]; # A more permissive filter
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any";
      };
    };

    systemd-journald = {
      serviceConfig = {
        UMask = 77;
        PrivateNetwork = true;
        ProtectHostname = true;
        ProtectKernelModules = true;
      };
    };

    thermald = {
      serviceConfig = {
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true; # Necessary for adjusting cooling policies
        ProtectKernelModules = true; # May need adjustment for module control
        ProtectControlGroups = true;
        ProtectKernelLogs = true;
        ProtectClock = true;
        ProtectProc = "invisible";
        ProcSubset = "pid";
        PrivateTmp = true;
        PrivateUsers = true;
        PrivateDevices = true; # May require access to specific hardware devices
        PrivateIPC = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        CapabilityBoundingSet = "";
        RestrictNamespaces = true;
        SystemCallFilter = [ "@system-service" ];
        SystemCallArchitectures = "native";
        UMask = "0077";
        IPAddressDeny = "any";
        DeviceAllow = [ ];
        RestrictAddressFamilies = [ ];
      };
    };
  };
}
