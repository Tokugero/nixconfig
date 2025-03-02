{ config, pkgs, inputs, system, ...}: {
    imports = [
        (import ../../home/common/default.nix { inherit config pkgs; })
        (import ../../home/dev/default.nix { inherit config pkgs inputs system; })
    ];

    security.pam.enableSudoTouchIdAuth = true;

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
    nix.linux-builder.enable = true;
}