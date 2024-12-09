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
                            esbenp.prettier-vscode
                            github.copilot
                            github.copilot-chat
                            golang.go
                            hashicorp.terraform
                            ms-azuretools.vscode-docker
                            ms-python.python
                            ms-vscode-remote.remote-ssh
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
        useGlobalPkgs = true;
    };

    environment.systemPackages = with pkgs; [
        python312
    ];

    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };
}
