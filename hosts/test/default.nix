{ pkgs, ... }: {
    imports = [
	../../home/default.nix
        ../../home/common/default.nix
        ../../home/dev/default.nix
        ../../home/linux/default.nix
        ./hardware-configuration.nix
    ];

    networking.hostName = "nixos-test";
    networking.interfaces.ens33.useDHCP = true;

    virtualisation.vmware.guest.enable = true;

    boot.loader = {
        grub = {
            enable = true;
            device = "/dev/sda";
            useOSProber = true;
        };
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.11";
}
