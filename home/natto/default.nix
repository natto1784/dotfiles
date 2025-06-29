{ ... }:
{
  home = {
    homeDirectory = "/home/natto";
    username = "natto";
    stateVersion = "22.11";
  };

  imports = [
    ./email.nix
    ./pass.nix
    ./browser.nix
    ./pdf.nix
    ./mpv.nix
    ./foot.nix
    # ./xsession.nix
    ./wayland.nix
    ./pkgs.nix
    ./stuff.nix
    ./gtk.nix
    ./dunst.nix
    ./git.nix
    ./music.nix
    ./zsh.nix
    ./games.nix
  ];
}
