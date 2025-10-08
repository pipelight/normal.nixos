{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.security.utils.enable {
    home.packages = with pkgs; [
      ## Password managers
      keepassxc
      # keys
      gnupg

      # Luks - disk encryption
      cryptsetup

      # Nixos easy cli
      # inputs.nixos-cli.packages.${system}.default
    ];

    home.file = {
      # ".config/keepassxc/keepassxc.ini".source = dotfiles/keepassxc/keepassxc.ini;
    };
  }
