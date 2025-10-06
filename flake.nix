{
  description = "normal.nixos - NixOS configuration modules for desktops (and paranoids and hypochondriacs)";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    ###################################
    # NixOs pkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-deprecated.url = "github:nixos/nixpkgs/nixos-24.11";

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
    # wlr-which-key = {
    #   url = "github:pipelight/wlr-which-key?ref=dev";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    ###################################
    # LLM
    # ollama.url = "github:havaker/ollama-nix";
  };

  outputs = {
    self,
    flake-parts,
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-unstable,
    nixpkgs-deprecated,
    ...
  } @ inputs: let
    specialArgs = rec {
      inherit inputs;
      pkgs = import nixpkgs;
      pkgs-stable = import nixpkgs-stable;
      pkgs-unstable = import nixpkgs-unstable;
      pkgs-deprecated = import nixpkgs-deprecated;
    };
  in rec {
    # For internal usage
    nixosModules = {
      default = ./default.nix;
      inherit specialArgs;
    };
  };
}
