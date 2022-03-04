{ config, pkgs, lib, ... }:
let
  home = config.home.homeDirectory;
in
{
  imports = [
    ./stuff/programs.nix
    ./stuff/xsession.nix
    ./stuff/secret.nix
    ./stuff/services.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  age = {
    sshKeyPaths = [ "${home}/.ssh/id_ed25519" ];
    secrets = {
      /*     fish_variables = {
        file = ./secrets/fish_variables.age;
        path = "${home}/.config/fish/fish_variables";
        mode = "660";
        };
      */
      mpdasrc = {
        file = ./secrets/mpdasrc.age;
        path = "${home}/.config/mpdasrc";
      };
      zshrc = {
        file = ./secrets/.zshrc.age;
        path = "${home}/.zshrc";
        mode = "660";
      };
    };
  };
  home = {
    packages = with pkgs; [
      ffmpeg-full
      sox
      rage
      curl
      pamixer
      mpdas
      pavucontrol
      unstable.anup
      xfce.thunar
      xfce.xfconf
      xfce.tumbler
      master.discord
      mpd_discord_richpresence
      sox
      qbittorrent
      #tor-browser-bundle-bin
      mpc_cli
      hexchat
      luajit
      mpv
      jmtpfs
      dunst
      flameshot
      yt-dlp
      xclip
      xorg.xkbcomp
      xorg.xmodmap
      p7zip
      unrar
      glxinfo
      sxiv
      vim
      feh
      dmenu
      st
      neofetch
      xmobar
      xdotool
      arc-theme
      arc-icon-theme
      tor-browser-bundle-bin
      wineWowPackages.stable
      master.winetricks
      games.wine-discord-ipc-bridge
      (games.osu-stable.overrideAttrs (_: {
        tricks = [ "gdiplus" "dotnet48" "meiryo" ];
      }))
      pmidi
      #   dosbox
      authy
      unstable.premid
      (master.tauon.override { withDiscordRPC = true; })
      nbfc-linux
      pulseaudio
      (texlive.combine { inherit (texlive) scheme-small babel lm graphics-def url; })
      #    carla
      #      electrum
      anki-bin
      spotify
      deluge
      teams
#      libreoffice
      google-drive-ocamlfuse
      customscripts
      (qjackctl.override { jackSession = true; })
      stable.ardour
      calf
      #     stable.blender
      neomutt
      mailcap
      cantata
    ];

    file = {
      /*  dwm-autostart = {
        source = ./config/dwm/autostart.sh;
        target = "${home}/.dwm/autostart.sh";
        };
        dwm-status = {
        source = ./config/dwm/bruhstatus.sh;
        target = "${home}/.dwm/bruhstatus.sh";
        };*/
      dunstrc = {
        source = ./config/dunst/dunstrc;
        target = "${home}/.config/dunst/dunstrc";
      };
    };
  };
}
