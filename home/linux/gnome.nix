{ pkgs, ...}:
let
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    }) { inherit pkgs; };
in
{
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            programs.firefox.profiles."default".extensions = with nur.repos.rycee.firefox-addons; [
                gnome-shell-integration
            ];

            home = {
                packages = with pkgs; [
                    dconf2nix # dconf dump / | dconf2nix > dconf.nix
                    gnomeExtensions.system-monitor
                    gnomeExtensions.blur-my-shell
                    gnomeExtensions.tiling-shell
                    gnomeExtensions.bing-wallpaper-changer
                    gnomeExtensions.gtile
                ];
            };
            dconf = {
                enable = true;
                settings = {
                    "org/gnome/shell" = {
                        disable-user-extensions = false;
                        enabled-extensions = with pkgs.gnomeExtensions; [
                            blur-my-shell.extensionUuid
                            tiling-shell.extensionUuid
                            system-monitor.extensionUuid
                            bing-wallpaper-changer.extensionUuid
                            gtile.extensionUuid
                            ];
                        };

                    "org/gnome/desktop/wm/preferences" = {
                        "button-layout" = ":minimize,maximize,close";
                        };
                    "org/gnome/desktop/interface" = {
                        color-scheme = "prefer-dark";
                        };
                    "org/gnome/shell/extensions/bingwallpaper" = {
                        random-mode-include-only-uhd = true;
                        };    
                    "org/gnome/shell/extensions/gtile" = {
                        auto-close = true;
                        follow-cursor = false;
                        global-auto-tiling = false;
                        show-grid-lines = true;
                        show-icon = false;
                        };
                };
            };
        };
        useGlobalPkgs = true;
    };

    services.gnome.gnome-browser-connector.enable = true;

}
