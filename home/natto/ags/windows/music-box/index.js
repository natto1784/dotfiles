// Mostly taken from https://github.com/Aylur/ags/blob/11150225e62462bcd431d1e55185e810190a730a/example/media-widget/Media.js

import Popup, { Padding, Revealer } from "../../utils/popup.js";
import { shrinkText } from "../../utils/text.js";
import { lengthStr, blurBg } from "../../utils/music.js";
import { findPlayer } from "../../utils/music.js";
import { WindowNames } from "../../constants.js";
import Controls from "./music-controls.js";

const FALLBACK_ICON = "audio-x-generic-symbolic";
const { MUSIC_BOX } = WindowNames;

const mpris = await Service.import("mpris");

const Player = (player) => {
  const img = Widget.Box({
    visible: player.bind("cover_path"),
    className: "cover-art",
    vpack: "start",
    css: player
      .bind("cover_path")
      .as(
        (p) =>
          (p ? "min-width: 200px; min-height: 200px;" : "") +
          `background-image: url('${p}');`,
      ),
  });

  const title = Widget.Label({
    className: "title",
    wrap: true,
    hpack: "start",
    label: player.bind("track_title").as((t) => shrinkText(t, 40)),
  });

  const artist = Widget.Label({
    className: "artist",
    wrap: true,
    hpack: "start",
    label: player.bind("track_artists").as((a) => shrinkText(a.join(", "), 80)),
  });

  const positionSlider = Widget.Slider({
    className: "position",
    drawValue: false,
    onChange: ({ value }) => (player.position = value * player.length),
    visible: player.bind("length").as((l) => l > 0),
    setup: (self) => {
      const update = () => {
        if (self.dragging) return;

        const value = player.position / player.length;
        self.value = value > 0 ? value : 0;
      };

      self
        .hook(player, update)
        .hook(player, update, "position")
        .poll(1000, update);
    },
  });

  const positionLabel = Widget.Label({
    ypad: 0,
    hpack: "start",
    className: "position-label",
    setup: (self) => {
      const update = (_, time) => {
        self.label = lengthStr(time || player.position);
        self.visible = player.length > 0;
      };

      self.hook(player, update, "position");
      self.poll(1000, update);
    },
  });

  const lengthLabel = Widget.Label({
    ypad: 0,
    hpack: "end",
    className: "length-label",
    visible: player.bind("length").as((l) => l > 0),
    label: player.bind("length").as(lengthStr),
  });

  const icon = Widget.Icon({
    className: "icon",
    hexpand: true,
    hpack: "end",
    vpack: "start",
    tooltipText: player.identity || "",
    icon: player.bind("entry").as((entry) => {
      const name = `${entry}-symbolic`;
      return Utils.lookUpIcon(name) ? name : FALLBACK_ICON;
    }),
  });

  return Widget.Box(
    {
      className: "music-player",
      visible: player.bus_name === findPlayer(mpris.players).bus_name,
      css: player.bind("cover_path").as(blurBg),
    },
    img,
    Widget.CenterBox({
      className: "music-details",
      vertical: true,
      hexpand: true,
      spacing: 25,
      startWidget: Widget.Box(
        {
          vertical: true,
          spacing: 6,
        },
        title,
        Widget.Box({
          className: "icon-wrapper",
          spacing: 10,
          children: [artist, icon],
        }),
      ),
      centerWidget: positionSlider,
      endWidget: Widget.CenterBox({
        spacing: 6,
        startWidget: positionLabel,
        centerWidget: Controls(player),
        endWidget: lengthLabel,
      }),
    }),
  )
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
        self.visible = player.bus_name === findPlayer(mpris.players).bus_name;
      },
      "player-closed",
    );
};

const PlayerBox = () =>
  Widget.Box({
    className: `${MUSIC_BOX}-unwrapped`,
    vertical: true,
    css: "padding: 1px;",
    children: mpris.bind("players").as((ps) => ps.map(Player)),
  });

export default (monitor = 0) => {
  const name = `${MUSIC_BOX}-${monitor}`;

  return Popup({
    name,
    className: MUSIC_BOX,
    monitor,
    layout: Widget.Box({
      children: [
        Padding(name), // left
        Widget.Box({
          hexpand: false,
          vexpand: false,
          vertical: true,
          children: [
            Revealer({
              name,
              child: PlayerBox(),
              transition: "slide_down",
              transitionDuration: 400,
            }),
            Padding(name), // down
          ],
        }),
        Padding(name), // right
      ],
    }),
  });
};
