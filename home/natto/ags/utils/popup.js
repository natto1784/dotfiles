export const Padding = (name, { hexpand = true, vexpand = true } = {}) =>
  Widget.EventBox({
    hexpand,
    vexpand,
    can_focus: false,
    setup: (w) => w.on("button-press-event", () => App.closeWindow(name)),
  });

export const Revealer = ({
  name,
  child,
  transition = "slide_down",
  transitionDuration = 200,
}) =>
  Widget.Box({
    css: "padding: 1px;",
    child: Widget.Revealer({
      transition,
      transitionDuration,
      child: Widget.Box({
        child,
      }),
      setup: (self) =>
        self.hook(App, (_, window, visible) => {
          if (window === name) self.reveal_child = visible;
        }),
    }),
  });

export default ({ name, layout, ...props }) =>
  Widget.Window({
    name,
    setup: (w) => w.keybind("Escape", () => App.closeWindow(name)),
    visible: false,
    keymode: "on-demand",
    exclusivity: "normal",
    layer: "top",
    anchor: ["top", "bottom", "right", "left"],
    child: layout,
    ...props,
  });
