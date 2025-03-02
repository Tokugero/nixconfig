{ pkgs, config, ...}:

{
    home-manager = {
        users.tokugero = { pkgs, unstable, ... }:
        {  
            programs = {
                firefox = import ./firefox.nix { inherit pkgs config; };
            };
            home = {
                packages = with pkgs; [
                    vim
                ];
            };
        };
    };

    environment.systemPackages = with pkgs; [
        cabextract
        gzip
        jq
        openconnect
        openvpn
        p7zip
        powerline-fonts
        sshpass
        tailscale
        unrar-wrapper
        unzip
        vault
        wget
        wget2
        wireguard-go
        wireguard-tools
        xsel
        xz
        yq
    ];
}
