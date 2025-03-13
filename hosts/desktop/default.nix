{ pkgs, ... }: {
    imports = [
        ../../home/default.nix
        ../../home/common/default.nix
        ../../home/dev/default.nix
        ../../home/linux/default.nix
        ../../home/leisure/default.nix
        ./hardware-configuration.nix
    ];

    services.hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };

    networking.hostName = "desktop";

    networking.hosts = {
      #"10.10.120.90" = [ "frostypines.thm" ];
    };

    environment.systemPackages = with pkgs; [
      deskflow
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "deskflow-1.19.0"
      "deskflow-1.20.0"
      "deskflow-1.20.1"
    ];

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    boot.kernel = {
      sysctl."net.core.wmem_max" = 8388608;
    };
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.11";
}