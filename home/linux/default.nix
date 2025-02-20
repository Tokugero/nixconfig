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
            # If $1 is not set, then use hostname
            if [ -z "$1" ]; then
                echo "No hostname provided, using $(hostname)";
                sudo nixos-rebuild switch --impure --upgrade --flake .#$(hostname);
            else
                sudo nixos-rebuild switch --impure --upgrade --flake .#$1
            fi
            cd $OLDDIR;
        };
    '';
}
