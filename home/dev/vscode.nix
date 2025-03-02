{ pkgs, config, inputs, system, ... }:
{
    enable = config.nixpkgs.hostPlatform.config != "aarch64-apple-darwin";
    package = pkgs.vscode.fhs;
    mutableExtensionsDir = false;

    extensions = (with pkgs.vscode-extensions; [
        bbenoist.nix
        devsense.phptools-vscode
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
    ] ++ (with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [ #https://github.com/nix-community/nix-vscode-extensions
        juanblanco.solidity
        signageos.signageos-vscode-sops-beta
    ]));

    userSettings = {
        "telemetry.telemetryLevel" = "off";
        "workbench.sideBar.location" = "right";
        "terminal.integrated.shellIntegration.history" = 10000;
        "terminal.integrated.scrollback" = 100000;
        "update.mode" = "none";
        "terminal.integrated.fontFamily" = "Meslo LG M DZ for Powerline";
        "github.copilot.enable.markdown" = true;
        "sops.defaults.ageKeyFile" = "/home/tokugero/.age/private.key";
    };
}