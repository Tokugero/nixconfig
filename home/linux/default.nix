{ pkgs, ...}:

{
    # import ./gnome.nix

    imports = [
        ./gnome.nix
    ];
    
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    #discord
                    remmina
                    python312Packages.pygments
                ];
            };
        };
        useGlobalPkgs = true;
    };

    # Enable ntfs mounting
    services = {
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
        autosuspend.enable = false;
    };

    powerManagement.enable = false;

    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
        brave
        wireguard-go
        ntfs3g
        parted
        openconnect
    ];

    programs.nix-ld.enable = true;
    
    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };

    programs.zsh.interactiveShellInit = ''
        nixupdate() {
            OLDDIR=$(pwd);
            cd ~/.nix;
            sudo nixos-rebuild switch --impure --upgrade --flake .#$1
            cd $OLDDIR;
        };
    '';
}
