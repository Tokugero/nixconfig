{ pkgs, config, ...}:
let 
    username = "tokugero";
in
{
    home-manager = {
        users.${username} = { pkgs, unstable, ... }:
        {  
            home = {
                packages = with pkgs; [
                    flameshot
                    vim
                ];
            };
            programs.firefox = import ./firefox.nix { inherit pkgs config; };
        };
    };

    services.tailscale = {
        enable = true;
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
            mkdir -p ~/.tailscale; chown -R ${username}:${username} ~/.tailscale && chmod -R 0700 ~/.tailscale;
            bw get item tailscale_all_tailscale.key | jq -r .notes | base64 -d > ~/.tailscale/tailscale.key;
        };
    '';
}
