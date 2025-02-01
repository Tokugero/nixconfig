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
                        package = pkgs.vscode.fhs;

                        extensions = (with pkgs.vscode-extensions; [
                            bbenoist.nix
                            dracula-theme.theme-dracula
                            eamodio.gitlens
                            esbenp.prettier-vscode
                            github.copilot
                            github.copilot-chat
                            golang.go
                            hashicorp.terraform
                            ms-azuretools.vscode-docker
                            ms-vscode.cpptools-extension-pack
                            ms-python.python
                            ms-toolsai.datawrangler
                            ms-toolsai.jupyter
                            ms-vscode-remote.remote-containers
                            ms-vscode-remote.remote-ssh
                            ms-vscode.powershell
                            redhat.ansible
                            redhat.vscode-yaml
                            yzhang.markdown-all-in-one
                            devsense.phptools-vscode
                        ]);

                        userSettings = {
                            "telemetry.telemetryLevel" = "off";
                            "workbench.sideBar.location" = "right";
                            "terminal.integrated.shellIntegration.history" = 10000;
                            "terminal.integrated.scrollback" = 100000;
                            "update.mode" = "none";
                        };
                    };
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
