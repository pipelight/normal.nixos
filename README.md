# normal.nixos

A set of **nixos modules** which provide trivial configuration
for desktop.

Still for **paranoids** and **hypochondriacs**.

<img src="./public/images/normal.nixos.png" width="500px"/>

## Motivations

This project aims to provide a reasonable NixOs base configuration
for desktops with:

Safer browsing:

- Firefox - A custom firefox with security features (+ i2p profile).
- Searxng - A local search engine aggregator without metadata.

Password and Keys:

- KeepassXC (custom security centric layout)

Fast WM:

- Niri

And **keyboard first** apps (qwerty, colemak-dh).

You can easily cherry-pick or copy/paste and modules of your choice.

## Configuration directory architecture

This flake makes a heavy use of [home-merger](https://github.com/pipelight/nixos-utils) to
keep config files in separate dotfiles in their original formats, and keep a
consistent file tree.

## Installation and Usage (Flake)

Add the repo url to your flake inputs.

```nix
# flake.nix
inputs = {
  normal = {
      url = "github:pipelight/normal.nixos";
  };
};
```

Add the module to your system configuration.

```nix
# flake.nix
nixosConfigurations = {
  my_machine = pkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
        # Import the module and the related configuration file.
        inputs.normal.nixosModules.default
        ./normal.nix
    ];
  };
};
```

See `option.nix` for available options.

```nix
# normal.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.normal = {
    users = ["anon"];

    keyboard.layout = "colemak-dh";

    # Graphical
    wm.hyprland.enable = true;

    browser = {
      firefox.enable = true;
      searxng.enable = true;
      i2p.enable = true;
      tor.enable = true;
    };
  };
}
```

```sh
nixos-rebuild switch
```

## What is inside ?

### Browsing and Search engines

Internet navigation:

- firefox security enhanced: with an hardened version of arkenfox
- secure dns: with bind9 dns over https
- search engine: searxng search engine configuration.

Linux ipv6 privacy features enabled.

### Passwords and keys

Password manager:

- KeepassXC (custom security centric layout)

### Desktop environments

- Gnome vanilla.
- Hyprland, Eww, Dunst
- Niri (+Mudras), Waybar, Dunst

### Per layout configurations.

Every command-line tool that has vim specific bindings has been customized to be usable with:

- Qwerty
- Azerty
  and
- Colemak-dh
