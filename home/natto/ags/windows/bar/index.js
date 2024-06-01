import Hyprland from "./hyprland.js";
import Music from "./music.js";
import Tray from "./tray.js";
import Time from "./time.js";
import Network from "./network.js";
import Bluetooth from "./bluetooth.js";
import Settings from "./settings.js";

import { WindowNames } from "../../constants.js";

const { BAR } = WindowNames;

const Left = () => {
  return Widget.Box({
    className: "bar-left",
    spacing: 8,
    children: [Hyprland()],
  });
};

const Center = (monitor) => {
  return Widget.Box({
    className: "bar-center",
    spacing: 8,
    children: [Music(monitor)],
  });
};

const Right = (monitor) => {
  return Widget.Box({
    className: "bar-right",
    hpack: "end",
    spacing: 10,
    children: [
      Tray(),
      Bluetooth(),
      Network(),
      Time(monitor),
      Settings(monitor),
    ],
  });
};

export default (monitor = 0) =>
  Widget.Window({
    name: `${BAR}-${monitor}`,
    className: BAR,
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      startWidget: Left(),
      centerWidget: Center(monitor),
      endWidget: Right(monitor),
    }),
  });
