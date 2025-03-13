{ pkgs, config, inputs, system, ...}:

{
    nixpkgs.config.allowUnfree = true;

    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    age
                    alejandra
                    ansible-lint
                    awscli2
                    chruby
                    k9s
                    kubectl
                    linkerd
                    ngrok
                    nil
                    nixfmt-rfc-style
                    nixpkgs-fmt
                    powershell
                    sops
                    sqlite
                    talosctl
                    tenv
                ];
            };
            programs.vscode = import ./vscode.nix { inherit pkgs config inputs system; };
        };
    };

    #

    environment = {
        systemPackages = with pkgs; [
            gcc
            python312
            python312Packages.pip
        ];
    };
}
