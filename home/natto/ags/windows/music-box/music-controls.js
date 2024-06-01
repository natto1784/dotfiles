const PLAY_ICON = "media-playback-start-symbolic";
const PAUSE_ICON = "media-playback-pause-symbolic";
const PREV_ICON = "go-previous-symbolic";
const NEXT_ICON = "go-next-symbolic";

export default (player) => {
  const playPause = Widget.Button({
    class_name: "play-pause",
    on_clicked: () => player.playPause(),
    visible: player.bind("can_play"),
    cursor: "pointer",
    child: Widget.Icon({
      icon: player.bind("play_back_status").transform((s) => {
        switch (s) {
          case "Playing":
            return PAUSE_ICON;
          case "Paused":
          case "Stopped":
            return PLAY_ICON;
        }
      }),
    }),
  });

  const prev = Widget.Button({
    yalign: 0.5,
    onClicked: () => player.previous(),
    visible: player.bind("can_go_prev"),
    child: Widget.Icon(PREV_ICON),
    cursor: "pointer",
  });

  const next = Widget.Button({
    onClicked: () => player.next(),
    visible: player.bind("can_go_next"),
    child: Widget.Icon(NEXT_ICON),
    cursor: "pointer",
  });

  return Widget.CenterBox({
    vertical: true,
    centerWidget: Widget.Box({
      className: "music-controls",
      children: [prev, playPause, next],
    }),
  });
};
