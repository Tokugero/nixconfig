{ pkgs, config, inputs, system, ... }:
{
    enable = true; #config.nixpkgs.hostPlatform.config != "aarch64-apple-darwin";
    package = if config.nixpkgs.hostPlatform.config == "aarch64-apple-darwin" then pkgs.vscode else pkgs.vscode-fhs;
    mutableExtensionsDir = false;

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
        signageos.signageos-vscode-sops
        redhat.ansible
        redhat.vscode-yaml
        yzhang.markdown-all-in-one
    ] ++ (with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [ #https://github.com/nix-community/nix-vscode-extensions
        juanblanco.solidity
        bpfdeploy.bpftrace
        signageos.signageos-vscode-sops-beta
        zobo.php-intellisense
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