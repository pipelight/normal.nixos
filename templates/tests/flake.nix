{
  description = "A flake that uses crocuda.nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    normal.url = "github:pipelight/normal.nixos?ref=dev";

    ###################################
    ## normal.nixos dependencies
    nixos-tidy = {
      url = "github:pipelight/nixos-tidy?ref=dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      default = pkgs.lib.nixosSystem rec {
        specialArgs = {inherit inputs;};

        modules = let
          ### The Nix AND Home module configuration
          # To be inported once as a regular module and once in home-manager.
          normalCfg = {...}: {
            normal = {
              users = ["anon"];
              wm = {
                niri.enable = true;
              };
              editors = {
                nvchad-ide.enable = true;
              };
              terminal = {
                git.conventional.enable = true;
              };
            };
          };
        in [
          # Base hardware config for tests
          ../commons/configuration.nix
          ../commons/hardware-configuration.nix

          inputs.normal.nixosModules.default
          normalCfg

          ###################################
          # You may move this module into its own file.
          ({
            pkgs,
            lib,
            config,
            inputs,
            ...
          }: {
            users.users."root" = {
              initialPassword = "root";
            };
            users.users."anon" = {
              isNormalUser = true;
              initialPassword = "anon";
            };
          })

          ###################################
          # You may move this module into its own file.
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users."anon" = {...}: {
              home.stateVersion = "25.05";
              imports = [
                inputs.normal.homeModules.default
                normalCfg
              ];
            };
          }
        ];
      };
    };
    packages."${system}" = {
      default = nixosConfigurations.default.config.system.build.toplevel;
    };
  };
}
