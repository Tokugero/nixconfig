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
}
