{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    zmk-nix = {
      url = "github:lilyinstarlight/zmk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    zmk-nix,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames zmk-nix.packages);
  in {
    packages = forAllSystems (system: rec {
      default = firmware;

      firmware = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "firmware";

        src = nixpkgs.lib.sourceFilesBySuffices self [".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig"];
        # extraWestBuildFlags = [
        #   "DZMK_EXTRA_MODULES"
        #   "/home/anon/Fast/nixos/keyboard/zmk_config/modules/zmk-keyboard-tbkblu"
        # ];
        board = "nice_nano@2.0.0";
        # board = "nice_nano_v2";
        # board = "tbkblu";
        # board = "tbkblu";
        # board = "nice_nano_v2";
        # board = "nice_nano";
        # shield = "lily58_%PART%";
        shield = "tbkblu_%PART%";

        # zephyrDepsHash = "";
        zephyrDepsHash = "sha256-QYwf9HpRmnKf2fJ8BauefEvZ0ms2bYVPbZ0REU0bces=";
        # zephyrDepsHash = "sha256-gMjN+WqgWWW2zJrDHJwl7eE6SvATXN2ouhNn2G4B0M0=";
        # zephyrDepsHash = "sha256-nQhe+umxFHqzfgGUBoZzL+Ru3MNGxeC/B88d+WIEKDA=";

        meta = {
          description = "ZMK firmware";
          license = nixpkgs.lib.licenses.mit;
          platforms = nixpkgs.lib.platforms.all;
        };
      };

      flash = zmk-nix.packages.${system}.flash.override {inherit firmware;};
      update = zmk-nix.packages.${system}.update;
    });

    devShells = forAllSystems (system: {
      default = zmk-nix.devShells.${system}.default;
    });
  };
}
