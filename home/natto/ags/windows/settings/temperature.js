export default () => {
  const getThermalZone = () => {
    try {
      return Utils.exec([
        "bash",
        "-c",
        `awk '{print FILENAME ":" $0}'  /sys/class/thermal/thermal_zone*/type`,
      ])
        .split("\n")
        .find((line) => line.includes("x86_pkg_temp"))
        .split(":")[0]
        .slice(0, -4);
    } catch (e) {
      console.error(e);
      console.log("settings/temperature: cannot get thermal zone");
    }
    return undefined;
  };

  const thermalZone = Variable(getThermalZone());

  const tempValue = thermalZone.value
    ? Variable(0, {
        poll: [
          5000,
          () => {
            try {
              return (
                Utils.readFile(`${thermalZone.value}/temp`) / 1000
              ).toFixed(2);
            } catch {
              console.log(
                "settings/temperature: specified thermal zone does not exist",
              );
            }
            return 0;
          },
        ],
      })
    : Variable(undefined);

  return Widget.CenterBox({
    vertical: true,
    visible: thermalZone.bind().as((t) => !!t),
    centerWidget: Widget.Box(
      {
        vertical: true,
        spacing: 8,
        tooltipText: tempValue.bind().as((t) => `CPU Temperature: ${t}°C`),
        className: tempValue
          .bind()
          .as((t) => `temperature${t > 65 ? "-hot" : ""}`),
      },
      Widget.Icon({
        icon: "sensors-temperature-symbolic",
      }),
      Widget.Label({
        label: tempValue.bind().as((t) => `${t}°C`),
      }),
    ),
  });
};
