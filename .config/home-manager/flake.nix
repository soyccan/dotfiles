{
  description = "Home Manager configuration of soyccan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    myHomeConfigurations = {
      "soyccan@soc5" = {
        system = "x86_64-linux";
        username = "soyccan";
        homeDirectory = "/home/soyccan";
      };
      "soyccan@scnmac" = {
        system = "aarch64-darwin";
        username = "soyccan";
        homeDirectory = "/Users/soyccan";
      };
    };

    makeHomeConfiguration = config@{ system, username, homeDirectory }: (
      home-manager.lib.homeManagerConfiguration {
        modules = [ ./home.nix ];
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          # these args are passed to home.nix
          inherit system username homeDirectory;
        };
      }
    );
  in {
    homeConfigurations = (
      nixpkgs.lib.attrsets.mapAttrs
      (confName: conf: makeHomeConfiguration conf)
      myHomeConfigurations
    );
  };
}
