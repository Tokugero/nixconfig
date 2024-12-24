{pkgs, ...}:
{
    users.groups.tokugero = {};
    users.users.tokugero = {
        isNormalUser = true;
        group = "tokugero";
        extraGroups = [ "wheel" "docker" ];
    };
}