## Drawing software
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
  mkIf config.normal.office.draw.enable {
    home.packages = with pkgs; [
      # Drawing
      inkscape
      gimp

      # Image manipulation tools
      imagemagick
      ghostscript
    ];
  }
