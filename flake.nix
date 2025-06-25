{
  description = "NixOS Configurations for Toku";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nix-homebrew,
    nix-vscode-extensions,
    homebrew-core,
    homebrew-cask,
    unstable,
    ...
  }: {
    darwinConfigurations = {
      mbp = let
        username = "tokugero";
        system = "aarch64-darwin";
        specialArgs = {inherit username inputs system;};
      in
        nix-darwin.lib.darwinSystem {
          inherit specialArgs;
          system = system;
          modules = [
            ./hosts/mbp
            ./home/macos/default.nix
            home-manager.darwinModules.home-manager
            {
              users.users.${username}.home = "/Users/${username}";
            }
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = import ./users/${username}/home.nix;
                
                extraSpecialArgs = inputs // specialArgs;
              };
            }
          ];
        };
    };
    nixosConfigurations = {
      pangolin = let
        username = "tokugero";
        system = "x86_64-linux";
        specialArgs = {inherit username inputs system;};
      in
        unstable.lib.nixosSystem {
          inherit specialArgs;
          system = system;

          modules = [
            ./hosts/pangolin
            ./home/x86/default.nix
            ./users/${username}/linux.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./users/${username}/home.nix;
              home-manager.extraSpecialArgs = inputs // specialArgs;
            }
          ];
        };
      desktop = let
        username = "tokugero";
        system = "x86_64-linux";
        specialArgs = {inherit username inputs system;};
      in
        unstable.lib.nixosSystem {
          inherit specialArgs;
          system = system;

          modules = [
            ./hosts/desktop
            ./home/x86/default.nix
            ./users/${username}/linux.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./users/${username}/home.nix;
              home-manager.extraSpecialArgs = inputs // specialArgs;
            }
          ];
        };
      kbp = let
        username = "tokugero";
        system = "aarch64-linux";
        specialArgs = {inherit username inputs system; };
      in
        unstable.lib.nixosSystem {
          inherit specialArgs;
          system = system;
          modules = [
            ./hosts/kbp
            ./users/${username}/linux.nix
            
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./users/${username}/home.nix;
              home-manager.extraSpecialArgs = inputs // specialArgs;
            }
          ];
        };
    };
  };
}
