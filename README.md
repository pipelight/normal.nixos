# normal.nixos

A set of **nixos modules** which provide trivial configuration
for desktop.

Still for **paranoids** and **hypochondriacs**.

<img src="./public/images/normal.nixos.png" width="500px"/>

## Motivations

This project aims to provide a resonable NixOs base configuration
for desktops with:

- Arkenfox - A Firefox with security features.
- Searxng - A local search engine aggregator without metadata.

And **keyboard first** apps (qwerty, colemak-dh).

It is divided in **modules** that can be cherry picked or copy/pasted and
modified at your will.

## Configuration directory architecture

This flake makes a heavy use of [home-merger](https://github.com/pipelight/nixos-utils) to
keep config files in separate dotfiles in their original formats, and keep a
consistent file tree.

## Installation and Usage (Flake)

Setting up a user is sufficient to get you up and running on a fresh nixos
installation.

Enable the software you wish to use via the module options, and you are done.
Refer to `default.nix` for the list of all available options.

```nix
# crocuda.nix
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

Then import the module and its configuration file from your flake.nix.

```nix
# flake.nix
nixosConfigurations = {
  # CrocudaVM config
  my_machine = pkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
        # Import the module and the related configuration
        inputs.normal.nixosModules.default
        ./normal.nix
    ];
  };
};
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
