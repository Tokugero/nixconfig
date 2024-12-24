{ pkgs, ...}:
let
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0ync3h68cfsbp9nn8x736dhlb2jp2m2ycqdww3xzffi0m41ay8im";
    }) {};
in
{
    home-manager = {
        users.tokugero = { pkgs, ... }:
        {  
            programs = {
                firefox = {
                    enable = true;
                    profiles."default" = {
                        extensions = with nur.repos.rycee.firefox-addons; [
                            bitwarden
                            containerise
                            darkreader
                            privacy-badger
                            tree-style-tab
                            ublock-origin
                            floccus
                            foxyproxy-standard
                        ];
                    };
                };
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
        firefox-unwrapped
        brave
        jq
        yq
        xsel
        openvpn
        tailscale
        wireguard-go
    ];
}