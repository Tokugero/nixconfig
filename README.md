```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

sudo nixos-rebuild switch --flake .#test --impure --upgrade

mac process
nix flake update
darwin-rebuild switch --flake .#mbp --impure
sudo nix-collect-garbage -d

nix-derivation show
nix-store --query --graph
`nix copy --to <destination> $(nix build -f asdf.nix)` to copy all paths of a build