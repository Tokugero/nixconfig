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

    networking.hosts = {
      #"10.10.120.90" = [ "frostypines.thm" ];
    };
    services.ntp.servers = [ "puppy.htb" ];

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
