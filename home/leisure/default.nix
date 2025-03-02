{ pkgs, config, ...}:
let
    username = "tokugero";
in
{
    home-manager = {
        users.${username} = { pkgs, ... }: 
        {
            home = {
                enableNixpkgsReleaseCheck = false;
                packages = with pkgs; [
                    obs-studio
                    #synergy
                    bambu-studio
                    hashcat
                    wordlists
                    deskflow
                    libei
                ];
            };
        };
        useGlobalPkgs = true;
    };

    environment.systemPackages = with pkgs; [
        #
    ];

    nixpkgs.config.permittedInsecurePackages = [
        "deskflow-1.19.0"
    ];

    programs = {
        steam.enable = true;
        steam.protontricks.enable = true;
        zsh.interactiveShellInit = ''
            syncsecrets = () {
                export BW_SESSION=$(bw unlock --raw);
                echo "Syncing secrets";
                bw sync;
                if [ -n "$(type -f syncuniversalsecrets)" ] ; then
                    syncuniversalsecrets;
                fi
                echo "Getting wrccdc password";
                mkdir -p ~/.credentials && touch ~/.credentials/wrccdc; chown -R ${username}:${username} ~/.credentials && chmod -R 0700 ~/.credentials;
                bw get item wrccdc_dev_.wrccdc | jq -r .notes | base64 -d > ~/.credentials/wrccdc;
                echo "Getting age keys";
                mkdir -p ~/.age && touch ~/.age/public.key && touch ~/.age/private.key; chown -R ${username}:${username} ~/.age && chmod -R 0700 ~/.age
                bw get item age_dev_public.key | jq -r .notes | base64 -d > ~/.age/public.key;
                bw get item age_dev_private.key | jq -r .notes | base64 -d > ~/.age/private.key;
                echo "Getting kubeconfig";
                mkdir -p ~/.kube && touch ~/.kube/config; chown -R ${username}:${username} ~/.kube && chmod -R 0700 ~/.kube;
                bw get item kubeconfig_dev_.kubeconfig | jq -r .notes | base64 -d > ~/.kube/config;
                echo "Getting talosconfig";
                mkdir -p ~/.talos && touch ~/.talos/config; chown -R ${username}:${username} ~/.talos && chmod -R 0700 ~/.talos;
                bw get item talosconfig_dev_config | jq -r .notes | base64 -d > ~/.talos/config;
                echo "Getting aws credentials";
                mkdir -p ~/.aws && touch ~/.aws/credentials; chown -R ${username}:${username} ~/.aws && chmod -R 0700 ~/.aws;
                bw get item aws_dev_credentials | jq -r .notes | base64 -d > ~/.aws/credentials;
                echo "Getting ssh keys";
                results=$(bw list items --folderid $(bw get folder cli | jq -r .id) --search "ssh_dev");
                IFS=$'\n';
                for item in $(echo $results | jq -r '.[] | .notes + " " + (.fields[] | select(.name == "path") | .value)'); do
                    content=$(echo $item | awk '{print $1}' | base64 -d);
                    location=$(eval "echo $(echo $item | awk '{print $2}')");
                    mkdir -p ~/.ssh; 
                    echo $location;
                    touch $location;
                    echo $content > $location;
                    echo "Synced "$location;
                done;
                chown -R ${username}:${username} ~/.ssh && chmod -R 0700 ~/.ssh
                bw lock;
                unset BW_SESSION;
            };
        '';
    };

    # services = {
    #     synergy = {
    #         client = {
    #             enable = true;
    #             autoStart = true;
    #             screenName = config.networking.hostName;
    #             serverAddress = "192.168.20.213";
    #         };
    #     };
    # };
}
