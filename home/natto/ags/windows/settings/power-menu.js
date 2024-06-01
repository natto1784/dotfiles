export default () => {
  const isLocked = Variable(true);
  const power = Variable("poweroff");
  const suspend = Variable("sleep");

  const cursor = "pointer";

  const unlockButton = Widget.Button({
    onPrimaryClick: () => {
      isLocked.value = false;
    },
    tooltipText: "Unock power menu",
    child: Widget.Icon("system-lock-screen-symbolic"),
    cursor,
  });

  const lockButton = Widget.Button({
    onPrimaryClick: () => {
      isLocked.value = true;
    },
    tooltipText: "Lock power menu",
    child: Widget.Icon("system-lock-screen-symbolic"),
    cursor,
  });

  const poweroffButton = Widget.Button({
    onPrimaryClick: () => {
      Utils.exec("poweroff");
    },
    onSecondaryClick: () => (power.value = "reboot"),
    tooltipText: "Shutdown",
    child: Widget.Icon("system-shutdown-symbolic"),
    cursor,
  });

  const rebootButton = Widget.Button({
    onPrimaryClick: () => {
      Utils.exec("reboot");
    },
    onSecondaryClick: () => (power.value = "poweroff"),
    tooltipText: "Reboot",
    child: Widget.Icon("system-reboot-symbolic"),
    cursor,
  });

  const sleepButton = Widget.Button({
    onPrimaryClick: () => {
      Utils.exec("systemctl suspend");
    },
    onSecondaryClick: () => (suspend.value = "hibernate"),
    tooltipText: "Sleep",
    child: Widget.Icon("weather-clear-night-symbolic"),
    cursor,
  });

  const hibernateButton = Widget.Button({
    onPrimaryClick: () => {
      Utils.exec("systemctl hibernate");
    },
    onSecondaryClick: () => (suspend.value = "sleep"),
    tooltipText: "Hibernate",
    child: Widget.Icon("computer-symbolic"),
    cursor,
  });

  const powerStack = Widget.Stack({
    children: {
      poweroff: poweroffButton,
      reboot: rebootButton,
    },
    shown: power.bind(),
  });

  const suspendStack = Widget.Stack({
    children: {
      sleep: sleepButton,
      hibernate: hibernateButton,
    },
    shown: suspend.bind(),
  });

  return Widget.Stack({
    className: "power-menu",
    children: {
      locked: Widget.CenterBox({ centerWidget: unlockButton }),
      unlocked: Widget.CenterBox({
        startWidget: powerStack,
        centerWidget: lockButton,
        endWidget: suspendStack,
      }),
    },
    shown: isLocked.bind().as((l) => (l ? "locked" : "unlocked")),
  });
};
