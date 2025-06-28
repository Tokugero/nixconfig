{ pkgs, config, inputs, system, ... }:
{
    enable = true;
    # if package in is any of aarch64-apple-darwin or arm64-apple-darwin
    package = if config.nixpkgs.hostPlatform.config == "aarch64-apple-darwin" ||
                 config.nixpkgs.hostPlatform.config == "arm64-apple-darwin"
      then pkgs.vscode
      else pkgs.vscode-fhs;
    mutableExtensionsDir = false;

    profiles.default = {
        extensions =
            (with pkgs.vscode-extensions; [
                bbenoist.nix
                dracula-theme.theme-dracula
                eamodio.gitlens
                esbenp.prettier-vscode
                github.copilot
                github.copilot-chat
                golang.go
                hashicorp.terraform
                ms-azuretools.vscode-docker
                ms-python.python
                ms-toolsai.datawrangler
                ms-vscode-remote.remote-containers
                ms-vscode-remote.remote-ssh
                ms-vscode.cpptools-extension-pack
                ms-vscode.powershell
                redhat.ansible
                redhat.vscode-yaml
                signageos.signageos-vscode-sops
                yzhang.markdown-all-in-one
            ])
            ++ (with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
                bpfdeploy.bpftrace
                juanblanco.solidity
                signageos.signageos-vscode-sops-beta
                ms-toolsai.jupyter
                zobo.php-intellisense
            ]);

        userSettings = {
            "telemetry.telemetryLevel" = "off";
            "workbench.sideBar.location" = "right";
            "terminal.integrated.shellIntegration.history" = 10000;
            "terminal.integrated.scrollback" = 100000;
            "update.mode" = "none";
            "terminal.integrated.fontFamily" = "Meslo LG M DZ for Powerline";
            "github.copilot.enable.markdown" = true;
            "sops.defaults.ageKeyFile" = "/home/tokugero/.age/private.key";
            "markdown.copyFiles.destination" = {
                "**/*" = "\${documentBaseName}_files/\${fileName}";
            };
            "editor.pasteAs.preferences" = [
                "markdown.link.image"
            ];
            #"extensions.autoUpdate" = false;
        };
    };
}
