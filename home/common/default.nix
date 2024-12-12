{ pkgs, ...}:

{
    home-manager = {
        backupFileExtension = "backup";
        users.tokugero = { pkgs, ... }:
        {
            
            home = {
                packages = with pkgs; [
                    # bitwarden-cli
                    # TODO: refactor
                    google-chrome
                    brave
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