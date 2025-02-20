{ pkgs, ...}:
let
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0s46c0zqxkflqz43dll40a64i0zqca66r19n7il55xkp7ir56sy3";
    }) {};
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
                };
            };
        };
        useGlobalPkgs = true;
    };

    services.gnome.gnome-browser-connector.enable = true;

}
