{config, lib, pkgs, ...}:

{
  services.openssh = {
    enable = true;
    openFirewall = false;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      MaxAuthTries = 3;
    };

    extraConfig = ''
      MaxStartups 3:50:10
    '';
  };

  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "1h";

    bantime-increment = {
      enable = true;
      maxtime = "3000y";
      factor = "4";
    };

    jails = {
      sshd = {
        settings = {
          enabled = true;
          port = "ssh";
          filter = "sshd";
          maxretry = 3;
        };
      };
    };
  };

  # anti virus
  services.clamav = {
    daemon.enable = true;
    updater.enable = true; # Keep virus definitions updated
    updater.interval = "daily";
    updater.frequency = 24;
  };

  # limit connections
  networking.firewall = {
    extraCommands = ''
      # Rate limit HTTP/HTTPS connections: max 50/minute per IP
      iptables -A INPUT -p tcp --dport 80 -m state --state NEW -m recent --set
      iptables -A INPUT -p tcp --dport 80 -m state --state NEW -m recent --update --seconds 60 --hitcount 50 -j DROP
      iptables -A INPUT -p tcp --dport 443 -m state --state NEW -m recent --set
      iptables -A INPUT -p tcp --dport 443 -m state --state NEW -m recent --update --seconds 60 --hitcount 50 -j DROP

      # Rate limit SSH: max 4/minute per IP
      iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
      iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
    '';
  };

  # Install security monitoring tools
  environment.systemPackages = with pkgs; [
    iptables # firewall management
    tcpdump # network analysis
    nmap # network scanning
    lynis # check security
  ];

  # automatically reboot at 4-5 AM after updates if needed
  # use lib.mkForce to override the false value from shared/security.nix
  # for no free pkgs
  nixpkgs.config.allowUnfree = lib.mkForce false;
  system.autoUpgrade.allowReboot = lib.mkForce true;
  system.autoUpgrade.rebootWindow = {
    lower = "04:00";
    upper = "05:00";
  };
}
