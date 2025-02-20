{ pkgs, ...}:

{
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    obs-studio
                ];
            };
        };
        useGlobalPkgs = true;
    };

    environment.systemPackages = with pkgs; [
        #
    ];

    programs = {
        steam.enable = true;
        steam.protontricks.enable = true;
    };

    programs.zsh.interactiveShellInit = ''
        syncsecrets = () {
            export BW_SESSION=$(bw unlock --raw);
            echo "Syncing secrets";
            bw sync;
            echo "Getting wrccdc password";
            bw get item wrccdc_dev_.wrccdc | jq -r .notes | base64 -d > ~/.wrccdc;
            echo "Getting kubeconfig";
            mkdir -p ~/.kube && touch ~/.kube/config;
            bw get item kubeconfig_dev_.kubeconfig | jq -r .notes | base64 -d > ~/.kube/config;
            echo "Getting talosconfig";
            mkdir -p ~/.talos && touch ~/.talos/config;
            bw get item talosconfig_dev_config | jq -r .notes | base64 -d > ~/.talos/config;
            echo "Getting aws credentials";
            mkdir -p ~/.aws && touch ~/.aws/credentials;
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
                chmod 0600 $location;
                echo "Synced "$location;
            done;
            bw lock;
            unset BW_SESSION;
        };
    '';
}
