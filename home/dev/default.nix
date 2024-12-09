{ pkgs, ...}:

{
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
		            vscode
                ];
            };

        };
        useGlobalPkgs = true;
    };

    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };
}
