{ pkgs, ...}:

{
    home-manager = {
        users.tokugero = { pkgs, ... }:
        {
            
            home = {
                packages = with pkgs; [
                    bitwarden-cli
                    vim
                ];
            };

        };
        useGlobalPkgs = true;
    };

    environment.systemPackages = with pkgs; [
        jq
        yq
        xsel
        openvpn
        tailscale
        wireguard-go
    ];
}