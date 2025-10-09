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
      programs.light.enable = true;
      security.rtkit.enable = true;

      ## Sound
      services.pulseaudio.enable = false;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      users.groups = let
        e = config.normal.users;
      in {
        audio.members = e;
        video.members = e;
        # Mudra/Swhkd
        input.members = e;
      };

      # Mudras/Swhkd
      # No longer need to be root.
      # Members of the input group can interact with keyboard.
      systemd.tmpfiles.rules = [
        "z /dev/input 0775 root input - -"
        "z /dev/uinput 0660 root input - -"
      ];

      environment.systemPackages = with pkgs; [
        # pactl audio control cli
        xdg-utils
        pulseaudio
        pamixer
      ];

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
    }
