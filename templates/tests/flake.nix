{
  description = "A flake that uses normal.nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    normal.url = "github:pipelight/normal.nixos?ref=dev";

    ###################################
    ### normal.nixos dependencies
    nixos-tidy = {
      url = "github:pipelight/nixos-tidy?ref=dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ###################################
    ## Browser
    # NUR - Nix User Repository
    nur.url = "github:nix-community/NUR";
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
    # Torrent
    rustmission.url = "github:intuis/rustmission";
    # Window Manager
    mudras.url = "github:pipelight/mudras?ref=dev";
    yofi = {
      url = "github:l4l/yofi?ref=09901e75cbdf2147553ab888adde480e57baa0d1";
      # url = "github:l4l/yofi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs;
  in rec {
    nixosConfigurations = {
      # Default module
      default = pkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ../commons/configuration.nix
          ../commons/hardware-configuration.nix

          inputs.normal.nixosModules.default

          ###################################
          # You may move this module into its own file.
          ({
            lib,
            inpus,
            config,
            ...
          }: {
            normal = {
              users = ["anon"];
              font = {
                enable = true;
                size = 11;
              };
              terminal = {
                torrent = {
                  enable = true;
                };
              };
              wm = {
                niri.enable = true;
                gnome.enable = true;
              };
            };
          })
          ###################################
        ];
      };
    };
    packages."${system}" = {
      default = nixosConfigurations.default.config.system.build.toplevel;
    };
  };
}
