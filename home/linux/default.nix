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
                    bitwarden-cli
                    remmina
                    python312Packages.pygments
                ];
            };
        };
        useGlobalPkgs = true;
    };

    services.mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad-vpn;
    };
    
    # This option isn't in nix-darwin yet
    services.tailscale.authKeyFile = "/home/tokugero/.tailscale/tailscale.key";

    # Enable ntfs mounting
    services = {
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
        autosuspend.enable = false;
    };

    powerManagement.enable = false;

    environment.systemPackages = with pkgs; [
        bpftrace
        brave
        ghostty
        wireguard-go
        ntfs3g
        parted
        openconnect
    ];
    
    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };

    programs = {
        nix-ld.enable = true;
        firefox.enable = true;
        zsh.interactiveShellInit = ''
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
    };
}
