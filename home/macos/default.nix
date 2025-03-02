{ pkgs, config, ...}:
{
  environment.shellAliases = {
    # Example:
    # ll = "ls -l";
    docker = "lima nerdctl";
  };

  programs.zsh.interactiveShellInit = ''
            syncsecrets = () {
                export BW_SESSION=$(bw unlock --raw);
                echo "Syncing secrets";
                bw sync;
                if [ -n "$(type -f syncuniversalsecrets)" ] ; then
                    syncuniversalsecrets;
                fi
                echo "Getting wrccdc password";
                mkdir -p ~/.credentials && touch ~/.credentials/wrccdc;
                bw get item wrccdc_dev_.wrccdc | jq -r .notes | base64 -d > ~/.credentials/wrccdc;
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
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
      gimp
      inkscape
      iterm2
      lima
      raycast
    ];

  homebrew = {
    enable = true;
    brews = [
      "aws-iam-authenticator"
      "mas"
      "bitwarden-cli"
      #"deskflow"
    ];
    casks = [
      "brave-browser"
      "firefox"
      "ghostty"
      "visual-studio-code"
      "discord"
    ];
    taps = [
      #"deskflow/homebrew-tap" = inputs.deskflow; # Need to test this
    ];
    masApps = {
      #Example: "xcode" = 497799835;
      "windows app" = 1295203466;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
  system.defaults = {
    dock.autohide = true;
  };

  nixpkgs.config.allowUnfree = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}