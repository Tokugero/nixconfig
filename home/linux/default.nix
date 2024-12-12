{ pkgs, ...}:

{
    # Allow unfree
    nixpkgs.config.allowUnfree = true;
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    discord
                    google-chrome
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
        wireguard-go
        ntfs3g
        parted
        openconnect
    ];
}