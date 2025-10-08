{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.office.video-editing.enable {
    home.packages = with pkgs; [
      # Media player
      vlc

      # Video manipulation tools
      ffmpeg
      mkvtoolnix
      mediainfo

      # Download videos
      yt-dlp
    ];
  }
