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
                    ansible
                    ansible-lint
                    awscli2
                    chruby
                    cilium-cli
                    dig
                    istioctl
                    jekyll
                    espeak
                    ffmpeg
                    k9s
                    kubectl
                    kubernetes-helm
                    kubevirt
                    linkerd
                    ngrok
                    nil
                    nixfmt-rfc-style
                    nixpkgs-fmt
                    ntp
                    powershell
                    sops
                    sqlite
                    talosctl
                    tenv
                    python313
                    python313Packages.pip
                    python313Packages.pywinrm
                    python313Packages.sympy
                ];
            };
            programs.vscode = import ./vscode.nix { inherit pkgs config inputs system; };
        };
    };

    environment = {
        systemPackages = with pkgs; [
            gcc
            ruby_3_4
            rubyPackages_3_4.json
            rubyPackages_3_4.jekyll
            rubyPackages_3_4.jekyll-feed
            rubyPackages_3_4.jekyll-remote-theme
            rubyPackages_3_4.github-pages
            rubyPackages_3_4.kramdown-parser-gfm
            rubyPackages_3_4.webrick
        ];
    };

    programs.wireshark = {
        enable = true;
        dumpcap.enable = true;
        usbmon.enable = true;
    };

    users.users.tokugero.extraGroups = [ "wireshark" ];
}
