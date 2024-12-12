{ config, pkgs, ...}: {
    imports = [
        (import ../../home/common/default.nix { inherit config pkgs; })
        (import ../../home/dev/default.nix { inherit config pkgs; })
    ];
}