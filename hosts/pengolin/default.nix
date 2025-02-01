{ pkgs, ... }: {
    imports = [
	../../home/default.nix
        ../../home/common/default.nix
        ../../home/dev/default.nix
        ../../home/linux/default.nix
        ../../home/pentest/default.nix
        ./hardware-configuration.nix
    ];

    networking.hostName = "pengolin";
    networking.interfaces.enp2s0.useDHCP = true;
    networking.interfaces.wlo1.useDHCP = true;

    networking.hosts = {
      #"10.10.120.90" = [ "frostypines.thm" ];
    };

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    boot.kernel = {
      sysctl."net.core.wmem_max" = 8388608;
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
