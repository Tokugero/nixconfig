{ pkgs, ... }: {
    imports = [
        ../../home/default.nix
        ../../home/common/default.nix
        ../../home/dev/default.nix
        ../../home/linux/default.nix
        ../../home/pentest/default.nix
        ./hardware-configuration.nix
    ];

    services.xrdp = {
        enable = true;
        defaultWindowManager = "gnome-session";

        extraConfDirCommands = ''
            substituteInPlace $out/xrdp.ini \
            --replace 'crypt_level=high' 'crypt_level=low' \
            --replace '#tcp_send_buffer_bytes=32768' 'tcp_send_buffer_bytes=4194304'
        '';
    };
    
    networking.hostName = "pangolin";
    networking.interfaces.enp2s0.useDHCP = true;
    networking.interfaces.wlo1.useDHCP = true;

    # START CHALLENGE CONFIG SECTION
    networking.hosts = {
      #"10.10.120.90" = [ "support.thm" ];
    };
    services.ntp.servers = [ "scepter.htb" ];
    networking.timeServers = [ "scepter.htb" ];
    services.ntp.enable = true;

    # security.krb5.enable = true;
# 
    # security.krb5.settings = {
    #   realms = {
    #     "SCEPTER.HTB" = {
    #       kdc = [ "dc01.scepter.htb" ];
    #       admin_server = "dc01.scepter.htb";
    #       default_domain = "dc01.scepter.htb";
    #     };
    #   };
    #   libdefaults = {
    #     default_realm = "SCEPTER.HTB";
    #     dns_lookup_realm = true;
    #     dns_lookup_kdc = true;
    #   };
    #   domain_realm = {
    #     "scepter.htb" = "SCEPTER.HTB";
    #     ".scepter.htb" = "SCEPTER.HTB";
    #   };
    # };

    # END CHALLENGE CONFIG SECTION

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      kernel = {
        sysctl."net.core.wmem_max" = 8388608;
      };
      supportedFilesystems = [ "nfs" ];
    };

    services.logind.lidSwitch = "ignore";
    
    services.logind.extraConfig = ''
        HandlePowerKey=ignore
        HandleSuspendKey=ignore
        HandleHibernateKey=ignore
        HandleLidSwitch=ignore
        IdleAction=ignore
      '';

    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.11";
}
