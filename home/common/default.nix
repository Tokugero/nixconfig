{ pkgs, config, ...}:
let
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "05n42xbmfwlx6msv1j4jjnhnnmi8a03in9cr8gsmc1x01qxkn9ql";
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
        tailscale
        wireguard-go
        vault
        openconnect
    ];
}
