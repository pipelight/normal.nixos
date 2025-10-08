{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.chat.enable {
    # Allow bottom tier apps
    allow-unfree = [
      "discord"
    ];
  }
