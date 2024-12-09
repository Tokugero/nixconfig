{ pkgs, ...}:

{
    users.users = {
        tokugero = {
            isNormalUser = true;
            home = "/home/tokugero";
            description = "Toku";
            extraGroups = [ "wheel" "networkmanager" "docker" ];
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxmYRVyvWcZgvApd94KWSO+c1vXCRA6RfazlSrASgBp"
            ];
        };
    };
}