{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.office.chat.enable {
    # Allow bottom tier apps
    allow-unfree = [
      "discord"
    ];
  }
