{pkgs, ...}:
{
    users.groups = {
        tokugero = { };
        dialout = { }; # This is so browsers can interact with serial ports
    };
    users.users.tokugero = {
        isNormalUser = true;
        group = "tokugero";
        extraGroups = [ "wheel" "docker" "dialout" ];
    };
}
