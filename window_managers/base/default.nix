{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.normal;
in
  with lib;
    mkIf cfg.wm.niri.enable {
      ## Screen
      programs.light.enable = true;

      ## Sound
      users.groups.audio.members = config.normal.users;
      services.pulseaudio.enable = false;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      ## Video
      users.groups.video.members = config.normal.users;

      # Mudras/Swhkd
      # No longer need to be root.
      # Members of the **input** group can interact with keyboard.
      users.groups.input.members = config.normal.users;
      systemd.tmpfiles.rules = [
        "z /dev/input 0775 root input - -"
        "z /dev/uinput 0660 root input - -"
      ];

      environment.systemPackages = with pkgs; [
        # pactl audio control cli
        pulseaudio
        pamixer
      ];

      ## Non blocking processes
      security.rtkit.enable = true;

      ###################################
      # Fonts
      fonts = {
        fontconfig = {
          defaultFonts = rec {
            emoji = ["Noto Color Emoji"];
            monospace = [
              "JetBrains Mono Nerd Font Mono"
              "JetBrains Mono NL Nerd Font Mono"
              "NotoSansM Nerd Font Mono"
              "Noto Sans Mono CJK JP"
            ];
            sansSerif = monospace;
            serif = monospace;
          };
        };
        packages = with pkgs; [
          #25.05
          nerd-fonts.jetbrains-mono
          nerd-fonts.noto

          noto-fonts-color-emoji
          noto-fonts-cjk-sans
        ];
      };

      ###################################
      # Theming
      programs.dconf.enable = true;

      environment.etc = {
        # Qt4
        "xdg/Trolltech.conf".text = ''
          [Qt]
          style=GTK+
        '';
      };
      environment.sessionVariables = {
        # QT_WAYLAND_DECORATION = "adwaita";
        QT_WAYLAND_DECORATION = "breeze-dark";
        QT_QPA_PLATFORMTHEME = "gtk3";
      };
    }
