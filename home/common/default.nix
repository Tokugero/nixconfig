{ pkgs, ...}:

{
    home-manager = {
        users.tokugero = { pkgs, ... }:
        {
            home = {
                packages = with pkgs; [
                    oh-my-zsh
                    tailscale
                    vim
                    wireguard-go
                ];
            };

        };
        useGlobalPkgs = true;
    };
}