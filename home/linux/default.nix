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

    environment.systemPackages = with pkgs; [
        wireguard-go
        openconnect
    ];
}