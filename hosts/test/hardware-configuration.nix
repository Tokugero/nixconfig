{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [ ];

    boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ahci" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    { 
        device = "/dev/disk/by-uuid/bb000c23-1acc-429d-a355-eb26285fd73c";
        fsType = "ext4";
    };

    swapDevices =
    [ 
        { device = "/dev/disk/by-uuid/ce8faac6-fdfb-4462-9eee-e4b07186da51"; }
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.ens33.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
