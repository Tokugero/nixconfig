{
    #https://github.com/nix-community/plasma-manager/blob/trunk/examples/home.nix

    enable = true;

    workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        clickItemTo = "select";
        cursor = {
            theme = "breeze";
            size = 32;
        };
    };

    fonts = {
        general = {
        family = "JetBrains Mono";
        pointSize = 12;
        };
    };
    
    configFile = {
        kwinrc.Desktops.Number = {
            value = 4;
        };
    };
}
