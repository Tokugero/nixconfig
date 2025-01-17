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
                    ];
                };
                programs = {
                    vscode = {
                        enable = true;

                        extensions = (with pkgs.vscode-extensions; [
                            bbenoist.nix
                            ms-vscode.powershell
                            dracula-theme.theme-dracula
                            eamodio.gitlens
                            ms-toolsai.datawrangler
                            esbenp.prettier-vscode
                            github.copilot
                            github.copilot-chat
                            golang.go
                            hashicorp.terraform
                            ms-vscode-remote.remote-containers
                            ms-azuretools.vscode-docker
                            ms-python.python
                            ms-vscode-remote.remote-ssh
                            ms-toolsai.jupyter
                            redhat.ansible
                            redhat.vscode-yaml
                            yzhang.markdown-all-in-one
                        ]);

                        userSettings = {
                            "telemetry.telemetryLevel" = "off";
                            "workbench.sideBar.location" = "right";
                        };
                    };
                };
            };
    };

    #

    environment.systemPackages = with pkgs; [
        libgcc
        python312
        python312Packages.ipykernel
        python312Packages.jupyter
        python312Packages.jupyter-core
        python312Packages.pip
    ];


}
