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

    services.tailscale = {
        enable = true;
        authKeyFile = "/home/tokugero/.tailscale/tailscale.key";
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

    programs.zsh.interactiveShellInit = ''
        syncuniversalsecrets() {
            if [ -z "$BW_SESSION" ]; then
                echo "Please run 'syncsecrets' to execute this function";
                return 1;
            fi
            echo "Syncing universal secrets";
            echo "Getting tailscale key";
            mkdir -p ~/.tailscale;
            bw get item tailscale_all_tailscale.key | jq -r .notes | base64 -d > ~/.tailscale/tailscale.key;
        };
    '';
}
