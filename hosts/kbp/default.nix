{ pkgs, ... }: {
    imports = [
        ../../home/default.nix
        ../../home/common/default.nix
        ../../home/dev/default.nix
        ../../home/linux/default.nix
        ../../home/pentest/default.nix
        ./hardware-configuration.nix
        ];

    nixpkgs.config.allowUnsupportedSystem = true;
    networking.hostName = "kbp";
    networking.interfaces.ens160.useDHCP = true;

    virtualisation.vmware.guest.enable = true;

    #networking.hosts = {
    #  "10.129.167.185" = [ "fluffy.htb" "dc01.fluffy.htb" ];
    #};
    #networking.timeServers = [ "fluffy.htb" ];
    #services.ntp.enable = true;
    #security.krb5.settings = {
    #  domain_realm = {
    #    "fluffy.htb" = "FLUFFY.HTB";
    #  };
    #  realms = {
    #    "FLUFFY.HTB" = {
    #      kdc = [ "fluffy.htb" ];
    #    };
    #  };
    #};
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
    
    environment.systemPackages = with pkgs; [
      open-vm-tools
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "24.11";
}
