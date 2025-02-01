{ pkgs, ...}:

{
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    #discord
                    remmina
                ];
            };
            programs.plasma = import ./plasma.nix;
        };
        useGlobalPkgs = true;
    };

    # Enable ntfs mounting
    services = {
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
        autosuspend.enable = false;
    };

    powerManagement.enable = false;

    environment.systemPackages = with pkgs; [
        firefox
        brave
        wireguard-go
        ntfs3g
        parted
        openconnect
        kdePackages.oxygen
    ];

    programs.nix-ld.enable = true;
    
    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };
}
