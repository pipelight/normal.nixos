{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    #doas

    # Versioning
    git
    util-linux

    # Builders
    pkg-config
    gnumake
    cmake
    bintools
  ];
}
