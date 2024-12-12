{ pkgs, ...}:

{
    # Allow unfree
    home-manager = {
        users.tokugero = { pkgs, ... }: 
        {
            home = {
                packages = with pkgs; [
                    discord
                ];
            };
        };
        useGlobalPkgs = true;
    };

    #environment.systemPackages = with pkgs; [
    #];
}
