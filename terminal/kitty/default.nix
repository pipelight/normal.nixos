{pkgs, ...}: {
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/kitty/current-theme.conf - - - - %h/.config/kitty/themes/doom_chad.conf"
  ];
}
