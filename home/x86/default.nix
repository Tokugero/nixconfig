{ pkgs, ...}:

{
    # Allow unfree
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    libreoffice-qt6-fresh
                    discord
                ];
            };
        };
        useGlobalPkgs = true;
    };

    #environment.systemPackages = with pkgs; [
    #];
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["tokugero"];

    virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        allowedBridges = [ "virbr1" "virbr0" ];
    };

    virtualisation.spiceUSBRedirection.enable = true;
}
