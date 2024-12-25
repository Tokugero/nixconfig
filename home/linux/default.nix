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
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = with pkgs; [
        firefox
        brave
        wireguard-go
        ntfs3g
        parted
        openconnect
    ];

    programs.nix-ld.enable = true;
    
    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };
}
