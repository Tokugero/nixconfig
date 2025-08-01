{ pkgs, ...}:
{
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    kdePackages.plasma-browser-integration
		    kdePackages.qtbase
                    kdePackages.qtwebsockets
                    kdePackages.qtdeclarative
                ];
            };
        };
    };
    services = {
        desktopManager = {
            plasma6.enable = true;
        };
        displayManager = {
            sddm.enable = true;
            sddm.wayland.enable = true;
            defaultSession = "plasma";
        };
        xrdp = {
            defaultWindowManager = "startplasma-x11";
        };
    };
    #https://github.com/NixOS/nixpkgs/issues/75867
    programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
    xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-kde
        xdg-desktop-portal-wlr
    ];
}
