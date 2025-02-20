{ pkgs, config, ...}:
{
  programs.zsh.shellAliases = {
    # Example:
    # ll = "ls -l";
    docker = "lima nerdctl";
  };
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
      "deskflow"
    ];
    casks = [
      "brave-browser"
      "firefox"
      "ghostty"
      "visual-studio-code"
      "discord"
    ];
    taps = {
      "deskflow/homebrew-tap" = inputs.deskflow; # Need to test this
    };
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