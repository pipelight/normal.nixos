{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.security.utils.enable {
    home.file = {
      # ".config/keepassxc/keepassxc.ini".source = dotfiles/keepassxc/keepassxc.ini;
    };
    home.packages = with pkgs; [
      ## Password managers
      keepassxc

      ## Cryptographic keys
      sops
      age
      ssh-to-age # ed25519 to age

      ## Luks - disk encryption
      cryptsetup

      # Nixos easy cli
      # inputs.nixos-cli.packages.${system}.default
    ];
  }
