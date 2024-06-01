import Controls from "../music-box/music-controls.js";
import { shrinkText } from "../../utils/text.js";
import { findPlayer } from "../../utils/music.js";
import { WindowNames } from "../../constants.js";

const mpris = await Service.import("mpris");
const players = mpris.bind("players");

/** @param {import('types/service/mpris').MprisPlayer} player */
const Player = (player, monitor) => {
  const revealer = Widget.Revealer({
    revealChild: false,
    transitionDuration: 300,
    transition: "slide_left",
    child: Controls(player),
  });

  return Widget.EventBox({
    visible: player.bus_name === findPlayer(mpris.players).bus_name,
    cursor: "pointer",
    setup: (self) => {
      self.on("leave-notify-event", () => {
        revealer.reveal_child = false;
      });
      self.on("enter-notify-event", () => {
        revealer.reveal_child = true;
      });
    },
    child: Widget.Box({
      className: "music",
      children: [
        Widget.Button({
          onClicked: () =>
            App.toggleWindow(`${WindowNames.MUSIC_BOX}-${monitor}`),
          className: "music-title",
          child: Widget.Label().hook(player, (self) => {
            self.tooltip_text = player.track_title;
            self.label = shrinkText(self.tooltip_text, 50);
          }),
        }),
        revealer,
      ],
    }),
  })
    .hook(
      mpris,
      (self, bus_name) => {
        self.visible = player.bus_name === bus_name;
      },
      "player-changed",
    )
    .hook(
      mpris,
      (self) => {
        self.visible = player === findPlayer(mpris.players);
      },
      "player-closed",
    );
};

export default (monitor) =>
  Widget.Box({
    visible: players.as((p) => p.length > 0),
    children: players.as((ps) => ps.map((p) => Player(p, monitor))),
  });
