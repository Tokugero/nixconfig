{ pkgs, config, inputs, system, ...}:

{
    nixpkgs.config.allowUnfree = true;

    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    alejandra
                    awscli2
                    k9s
                    kubectl
                    chruby
                    nil
                    ngrok
                    nixfmt-rfc-style
                    nixpkgs-fmt
                    tenv
                    powershell
                    sqlite
                    talosctl
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
