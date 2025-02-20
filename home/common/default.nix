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
                    bitwarden-cli
                    vim
                ];
            };
        };
    };

    environment.systemPackages = with pkgs; [
        cabextract
        ghostty
        gzip
        jq
        libreoffice-qt6-fresh
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
        xsel
        xz
        yq
    ];

}
