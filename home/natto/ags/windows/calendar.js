import Popup, { Padding, Revealer } from "../utils/popup.js";
import { WindowNames } from "../constants.js";

const Tray = Widget.Calendar({
  className: "calendar-unwrapped",
  showDayNames: true,
  showHeading: true,
});

export default (monitor = 0) => {
  const { CALENDAR } = WindowNames;
  const name = `${CALENDAR}-${monitor}`;

  return Popup({
    name,
    className: CALENDAR,
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
              child: Tray,
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
