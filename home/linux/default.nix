{ pkgs, ...}:

{
    # import ./gnome.nix

    imports = [
        ./gnome.nix
        #./plasma.nix
    ];
    
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                shellAliases = {
                    nixclean="sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 1d; sudo nix-collect-garbage -d; sudo nixos-rebuild list-generations;";
                };
                packages = with pkgs; [
                    #discord
                    bitwarden-cli
                    remmina
                    python313Packages.pygments
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
        chromium
        ghostty
        wireguard-go
        ntfs3g
        parted
        outils
        openconnect
        zip
    ];
    
    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
        daemon.settings = {
            insecure-registries = [ "http://192.168.1.10:5010" ];
        };
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
    services.flatpak.enable = true;
    xdg.portal.enable = true;
}
