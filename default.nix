#####################################
## Umport
{
  inputs,
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-deprecated,
  ...
}: let
  cfg = config.normal;
  umport = {
    paths = [
      ./.
    ];
    exclude = [
      # Testing dir
      ./templates

      ./flake.nix
      ./default.nix
      ./window_managers/niri/niri.latest.nix
    ];
  };
in {
  imports = let
    slib = inputs.nixos-tidy.lib;
  in
    [
      ######################
      ## Modules
      # Nur
      inputs.nur.modules.nixos.default
      # Tidy
      inputs.nixos-tidy.nixosModules.home-merger
      inputs.nixos-tidy.nixosModules.allow-unfree
    ]
    ++ slib.umportNixModules umport
    ++ slib.umportHomeModules umport
    # Function's second argument (home manager options)
    {
      users = cfg.users;
      extraSpecialArgs = {
        inherit inputs cfg pkgs-stable pkgs-unstable pkgs-deprecated;
      };
      imports = [
        ######################
        ## Modules
        # # Nur
        inputs.nur.modules.homeManager.default
        # Firefox
        inputs.arkenfox.hmModules.arkenfox
      ];
    };
}
