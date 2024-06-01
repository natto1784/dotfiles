const systemtray = await Service.import("systemtray");

const SysTrayItem = (item) =>
  Widget.Button({
    className: "system-tray-item",
    child: Widget.Icon().bind("icon", item, "icon"),
    tooltipMarkup: item.bind("tooltip_markup"),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
    cursor: "pointer",
  });

export default () =>
  Widget.Box({
    className: "system-tray-unwrapped",
    children: systemtray.bind("items").as((i) => i.map(SysTrayItem)),
  });
