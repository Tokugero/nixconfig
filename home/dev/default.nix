{ pkgs, ...}:

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
                        nixfmt-rfc-style
                        nixpkgs-fmt
                        tenv
                        powershell
                        sqlite
                    ];
                };
                programs = {
                    vscode = import ./vscode.nix;
                };
            };
    };

    #

    environment = {
        systemPackages = with pkgs; [
            python312
            python312Packages.pip
        ];
    };
}
