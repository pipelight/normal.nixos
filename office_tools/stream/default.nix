{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.office.stream.enable {
    # https://nixos.wiki/wiki/OBS_Studio
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    environment.systemPackages = with pkgs; [
      obs-cli
      # shotcut
      # kdePackages.kdenlive
    ];
    environment.sessionVariables = {
      HYPRSHOT_DIR = "$HOME/Pictures/Screenshots";
    };
  }
