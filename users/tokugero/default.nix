{ pkgs, ...}:

{

    programs.zsh = {
        enable = true;

        #shellAliases = {
        #    pbcopy="xsel --clipboard --input";
        #    pbpaste="xsel --clipboard --output";
        #    thm-vpn="sudo openvpn --config ~/vpn/thm.ovpn";
        #    htb-vpn="sudo openvpn --config ~/vpn/htb.ovpn";
        #    nixr="sudo nixos-rebuild switch --flake";
        #    darr="sudo darwin-rebuild switch --flake";
        #};
        #syntaxHighlighting.enable = true;
        # TODO: refactor
        # autosuggestions.enable = true;
        enableCompletion = true;
        #ohMyZsh = {
        #    enable = true;
        #    plugins = [
        #        "git"
        #        "sudo"
        #    ];
        #    theme = "agnoster";
        #};
    };
    users.users = {
        tokugero = {
            shell = pkgs.zsh;
            #isNormalUser = true;
            #home = "/home/tokugero";
            home = "/Users/tokugero";
            description = "Toku";
            #extraGroups = [ "wheel" "networkmanager" "docker" ];
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxmYRVyvWcZgvApd94KWSO+c1vXCRA6RfazlSrASgBp"
            ];
        };
    };
}