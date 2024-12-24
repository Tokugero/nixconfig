# Flake to define home-manager user configuration
{ pkgs, ... }:
{
    home.stateVersion = "24.05";
    home.shellAliases = {
            pbcopy="xsel --clipboard --input";
            pbpaste="xsel --clipboard --output";
            thm-vpn="sudo openvpn --config ~/vpn/thm.ovpn";
            htb-vpn="sudo openvpn --config ~/vpn/htb.ovpn";
            rebuild="sudo nixos-rebuild switch --flake";
        };
    # Using home.files define an authorizedKeys file with the contents "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxmYRVyvWcZgvApd94KWSO+c1vXCRA6RfazlSrASgBp"
    home.file.authorized_keys = {
        enable = true;
        target = ".ssh/authorized_keys";
        text = ''
            ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxmYRVyvWcZgvApd94KWSO+c1vXCRA6RfazlSrASgBp
        '';
    };
    programs = {
        home-manager.enable = true;

        git = {
            enable = true;
            userName = "Philip Almueti";
            userEmail = "palmueti@gmail.com";
            extraConfig = {
                init.defaultBranch = "main";
                core.sshCommand = "ssh -i ~/.ssh/github ";
                pull.rebase = "true";
            };
        };
        zsh = {
            enable = true;
            autosuggestion.enable = true;
            enableCompletion = true;
            syntaxHighlighting.enable = true;
            oh-my-zsh = {
                enable = true;
                plugins = [
                    "git"
                    "sudo"
                ];
                theme = "agnoster";
            };
        };
    };
}
