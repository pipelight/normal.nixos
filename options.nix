{
  config,
  lib,
  utils,
  inputs,
  ...
}: let
  moduleName = "normal";
in
  with lib; {
    # Set the module options
    options.${moduleName} = {
      users = mkOption {
        type = with types; listOf str;
        description = ''
          The name of the user whome to add this module for.
        '';
        default = ["anon"];
      };

      # Set the keyboard layout
      keyboard.layout = mkOption {
        type = with types; enum ["colemak-dh" "qwerty" "azerty"];
        description = ''
          The default hyprland keybindings
        '';
        default = "colemak-dh";
      };
      font = {
        enable = mkEnableOption ''
          Enable default font
        '';
        size = mkOption {
          type = with types; number;
          description = ''
            General font size.
          '';
        };
      };

      #########################
      ## Network and connectivity
      network = {
        bluetooth.enable = mkEnableOption ''
          Enable bluetooth with Playstation remote controller fixes.
        '';
        tools.enable = mkEnableOption ''
          Add some network troubleshooting tools.
        '';
        multicast-forwarding.enable = mkEnableOption ''
          Enable kernel ipv6 multicast forwarding.
        '';
      };
      # Set editors with the specified keyboard layout
      terminal = {
        emulators.kitty.enable = mkEnableOption ''
          Toggle the module
        '';
        git.conventional = {
          enable = mkEnableOption ''
            Conventional commits helpers
          '';
        };
        cicd.enable = mkEnableOption ''
          Enable lightweight cicd tools
        '';
        file_manager.enable = mkEnableOption ''
          Toggle the module
        '';
        torrent.enable = mkEnableOption ''
          Toggle the module
        '';
        ##########################
        ## The AI crap
        llm = {
          ollama = {
            enable = mkEnableOption ''
              Toggle the ollama server
            '';
          };
        };
      };

      editors = {
        neovim.enable = mkEnableOption ''
          Install base neovim with the specified keyboard layout
        '';
        nvchad.enable = mkEnableOption ''
          Install lightweight nvchad(neovim) with the specified keyboard layout
        '';
        nvchad-ide.enable = mkEnableOption ''
          Install nvchad(neovim) with the specified keyboard layout
          and complete ide extensions
        '';
      };
      #########################
      ## Window manager
      # Heavily customed hypr
      wm = {
        niri = {
          enable = mkEnableOption ''
            Toggle the hyprland window manager
          '';
        };
        hyprland = {
          enable = mkEnableOption ''
            Toggle the hyprland window manager
          '';
          mode = mkOption {
            type = with types; enum ["bspwm" "niri"];
            description = ''
              The default window manager tilling behavior
            '';
            default = "niri";
          };
          wide = mkEnableOption ''
            Convenient window splits for ultrawide monitors
          '';
        };
        gnome = {
          enable = mkEnableOption ''
            Toggle the gnome desktop environment.
          '';
          flatpak.enable = mkEnableOption ''
            Toggle flatpak and flathub package management.
          '';
        };
      };

      #########################
      ## Office
      # The desktop stuffs that you usualy don't want in a vm
      browser = {
        firefox = {
          enable = mkEnableOption ''
            Toggle the module
          '';
          i2p.enable = mkEnableOption ''
            Enable firefox profile for i2p browsing.
          '';
        };
        searxng = {
          enable = mkEnableOption ''
            Toggle searx local search engine.
          '';
        };
      };

      chat = {
        enable = mkEnableOption ''
          Toggle signal, element, mails...
        '';
      };

      office = {
        write.enable = mkEnableOption ''
          Enable libre/open office sute
        '';
        printers.enable = mkEnableOption ''
          Enable printers and scanners
        '';
        draw.enable = mkEnableOption ''
          Enable Gimp and Inkscape
        '';
        video-editing.enable = mkEnableOption ''
          Enable video editors
        '';
        stream.enable = mkEnableOption ''
          Toggle streaming module
        '';
        gaming.enable = mkEnableOption ''
          Enable some emulators
        '';
      };

      android = {
        enable = mkEnableOption ''
          Android tooling
        '';
      };

      yubikey.enable = mkEnableOption ''
        Toggle the module
      '';
    };
  }
