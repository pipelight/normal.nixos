{
  description = "A flake that uses normal.nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    normal = {
      url = "github:pipelight/normal.nixos?ref=dev";
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

          inputs.virshle.nixosModules.default

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
              torrent = {
                enable = true;
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
