import Popup, { Padding, Revealer } from "../../utils/popup.js";
import { WindowNames } from "../../constants.js";
import Audio from "./audio.js";
import Backlight from "./backlight.js";
import {
  cpuMetric,
  memoryMetric,
  diskMetric,
  batteryMetric,
} from "./metrics.js";
import Temperature from "./temperature.js";
import Weather from "./weather.js";
import PowerMenu from "./power-menu.js";

const metrics = Widget.Box({
  className: "metrics",
  vertical: true,
  children: [cpuMetric, memoryMetric, diskMetric, batteryMetric],
});

const sliders = Widget.Box({
  className: "sliders",
  vertical: true,
  children: [Audio(), Backlight()],
});

const settingsCol = Widget.CenterBox({
  className: "settings-col",
  vertical: true,
  spacing: 8,
  startWidget: sliders,
  centerWidget: Widget.CenterBox({
    className: "settings-col-temps",
    startWidget: Temperature(),
    endWidget: Weather(),
  }),
  endWidget: PowerMenu(),
});

const settings = Widget.Box({
  className: "settings-unwrapped",
  children: [metrics, settingsCol],
});

export default (monitor = 0) => {
  const { SETTINGS } = WindowNames;
  const name = `${SETTINGS}-${monitor}`;

  return Popup({
    name,
    className: SETTINGS,
    monitor,
    layout: Widget.Box({
      children: [
        Padding(name),
        Widget.Box({
          hexpand: false,
          vertical: true,
          children: [
            Revealer({
              name,
              child: settings,
              transition: "slide_down",
              transitionDuration: 400,
            }),
            Padding(name),
          ],
        }),
      ],
    }),
  });
};
