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