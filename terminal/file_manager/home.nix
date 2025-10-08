{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.terminal.file_manager.enable {
    home.file = {
      ".config/yazi/keymap.toml".source = dotfiles/yazi/keymap.toml;
      ".config/yazi/yazi.toml".source = dotfiles/yazi/yazi.toml;
    };

    home.packages = with pkgs; [
      # File manager
      # ranger
      yazi
    ];
  }
