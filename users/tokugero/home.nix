# Flake to define home-manager user configuration
{...}:

{
    home.stateVersion = "24.05";

    programs = {
        home-manager.enable = true;

        git = {
            enable = true;
            userName = "Philip Almueti";
            userEmail = "palmueti@gmail.com";
            extraConfig = {
                init.defaultBranch = "main";
                core.sshCommand = "ssh -i ~/.ssh/github ";
            };
        };
    };
}
