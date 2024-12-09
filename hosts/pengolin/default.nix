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

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.11";
}
