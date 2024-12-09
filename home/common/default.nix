{ pkgs, ...}:

{
    home-manager = {
        users.tokugero = { pkgs, ... }:
        {
            home = {
                packages = with pkgs; [
                    bitwarden-cli
                    oh-my-zsh
                    vim
                ];
            };

        };
        useGlobalPkgs = true;
    };

    environment.systemPackages = with pkgs; [
        openvpn
        tailscale
        wireguard-go
    ];
}