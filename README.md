```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

sudo nixos-rebuild switch --flake .#test --impure --upgrade

mac process
nix flake update
darwin-rebuild switch --flake .#mbp --impure
sudo nix-collect-garbage -d