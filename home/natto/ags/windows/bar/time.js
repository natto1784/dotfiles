const time = Variable("", {
  poll: [1000, 'date "+%H:%M:%S"'],
});

const getDate = () => " " + Utils.exec('date "+%a, %b %e"');
const date = Variable(getDate());

export default () => {
  const revealer = Widget.Revealer({
    revealChild: false,
    transitionDuration: 300,
    transition: "slide_left",
    child: Widget.Label({
      label: date.bind(),
    }),
  });

  return Widget.EventBox({
    cursor: "pointer",
    setup: (self) => {
      self.on("leave-notify-event", () => {
        revealer.reveal_child = false;
      });
      self.on("enter-notify-event", () => {
        date.value = getDate();
        revealer.reveal_child = true;
      });
    },
    child: Widget.Button({
      className: "date-wrapper",
      onPrimaryClick: () => App.toggleWindow("calendar-0"),
      child: Widget.Box({
        children: [
          Widget.Label({
            label: time.bind(),
          }),
          revealer,
        ],
      }),
    }),
  });
};
