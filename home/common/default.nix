{ pkgs, config, ...}:
let
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0mbjsaras0x4c999znc79c29d48i36qs28gym9b3hb8m8db9vv8h";
    }) {};
in
{
    home-manager = {
        users.tokugero = { pkgs, unstable, ... }:
        {  
            programs = {
                firefox = {
                    package = null; # This is installed system independent since darwin + linux packages are different
                    enable = true;
                    profiles."default" = {
                        isDefault = true;
                        settings = {
                            "browser.search.defaultenginename" = "Kagi";
                            "browser.search.order.1" = "Kagi";
                            "signon.rememberSignons" = false;
                            "widget.use-xdg-desktop-portal.file-picker" = 1;
                            "browser.aboutConfig.showWarning" = false;
                            "browser.compactmode.show" = true;
                        };
                        extensions = with nur.repos.rycee.firefox-addons; [
                            bitwarden
                            containerise
                            kagi-search
                            darkreader
                            cookie-quick-manager
                            privacy-badger
                            tree-style-tab
                            ublock-origin
                            floccus
                            foxyproxy-standard
                        ];
                        search = {
                            force = true;
                            default = "Kagi";
                            engines = {
                                "Kagi" = {
                                urls = [
                                    {
                                    template = "https://kagi.com/search?";
                                    params = [{
                                        name = "q";
                                        value = "{searchTerms}";
                                        }];
                                    }];
                                };
                            }; 
                        };
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
        powerline-fonts
        jq
        yq
        xsel
        openvpn
        wget
        ghostty
        wget2
        tailscale
        libreoffice-qt6-fresh
        wireguard-go
        vault
        openconnect
    ];
}
