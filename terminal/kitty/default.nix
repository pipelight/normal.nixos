{pkgs, ...}: {
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/kitty/current-theme.conf - - - - %h/.config/kitty/doom_chad.conf"
  ];
}
