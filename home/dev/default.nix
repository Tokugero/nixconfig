{ pkgs, config, inputs, system, ...}:

{
    nixpkgs.config.allowUnfree = true;

    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    #gash-utils
                    age
                    alejandra
                    ansible
                    ansible-lint
                    awscli2
                    chruby
                    dig
                    istioctl
                    jekyll
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
            python312Packages.pywinrm
            python312Packages.sympy
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
}
