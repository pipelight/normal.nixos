{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # Loosen Security for fast sudoing
  security.sudo.extraRules = [
    {
      groups = ["wheel"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  users.groups = {
    wheel.members = config.normal.users;
  };

  services.dbus.implementation = "broker";

  security.polkit.enable = true;

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
