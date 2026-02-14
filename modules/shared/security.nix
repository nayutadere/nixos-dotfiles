{ config, lib, pkgs, ... }:

{
  # automatically update the system with security patches
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "04:00";
    flake = "path:/home/nayuta/nixos-dotfiles";
  };

  boot.kernel.sysctl = {
    # protect against SYN flood attacks
    "net.ipv4.tcp_syncookies" = 1;

    # disable IP forwarding
    "net.ipv4.ip_forward" = 0;
    "net.ipv6.conf.all.forwarding" = 0;

    # disable ICMP redirects (prevent MITM attacks)
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    # ignore ICMP pings (no more pinging the server)
    "net.ipv4.icmp_echo_ignore_all" = 1;

    # disable source routing (prevent ip spoof)
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.default.accept_source_route" = 0;

    # enable reverse path filtering
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;

    # log suspicious packets
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.default.log_martians" = 1;

    # protect against time-wait assassination
    "net.ipv4.tcp_rfc1337" = 1;

    # disable IPv6 router advertisements
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv6.conf.default.accept_ra" = 0;

    # kernel hardening
    "kernel.dmesg_restrict" = 1; # Prevent non-root from reading kernel logs
    "kernel.kptr_restrict" = 2;  # Hide kernel pointers (prevents exploits)
    "kernel.unprivileged_bpf_disabled" = 1; # Disable unprivileged BPF
    "kernel.unprivileged_userns_clone" = 0; # Disable unprivileged user namespaces
    "kernel.yama.ptrace_scope" = 2; # Restrict ptrace to prevent process inspection

    # filesystem hardening
    "fs.protected_hardlinks" = 1;  # Prevent hardlink exploits
    "fs.protected_symlinks" = 1;   # Prevent symlink exploits
    "fs.protected_fifos" = 2;      # Prevent FIFO exploits
    "fs.protected_regular" = 2;    # Prevent file exploits in world-writable dirs
  };

  boot.blacklistedKernelModules = [
    "dccp"
    "sctp"
    "rds"
    "tipc"

    # uncommon filesystems
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "udf"
  ];

  networking.firewall = {
    enable = true;

    logRefusedConnections = true;
    logRefusedPackets = false; #

    rejectPackets = false;
  };

  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
    KbdInteractiveAuthentication = false;
    X11Forwarding = false;
    MaxAuthTries = 3;
  };

  security.auditd.enable = true;
  security.audit = {
    enable = true;
    rules = [
      # audit any access to shadow file (password hashes)
      "-w /etc/shadow -p wa -k shadow"

      # audit sudo usage
      "-w /usr/bin/sudo -p x -k sudo"
      "-w /etc/sudoers -p wa -k sudoers"

      # audit SSH
      "-w /etc/ssh/sshd_config -p wa -k sshd"

      # audit user/group modifications
      "-w /etc/passwd -p wa -k passwd"
      "-w /etc/group -p wa -k group"

      # audit login/logout
      "-w /var/log/lastlog -p wa -k lastlog"
      "-w /var/log/faillog -p wa -k faillog"
    ];
  };

  systemd.coredump.enable = false;

  # clear /tmp on boot
  boot.tmp.cleanOnBoot = true;

  # security.apparmor = {
  #   enable = true;
  #   packages = [ pkgs.apparmor-profiles ];
  # };
}
