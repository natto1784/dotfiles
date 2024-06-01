const battery = await Service.import("battery");

const divide = ([total, free]) => free / total;

const cpuValue = Variable(0, {
  poll: [
    2000,
    "top -b -n 1",
    (out) =>
      divide([
        100,
        out
          .split("\n")
          .find((line) => line.includes("Cpu(s)"))
          .split(/\s+/)[1]
          .replace(",", "."),
      ]),
  ],
});

const memoryValue = Variable([0, 0], {
  poll: [
    2000,
    "free",
    (out) => {
      const data = out
        .split("\n")
        .find((line) => line.includes("Mem:"))
        .split(/\s+/)
        .splice(1, 2);
      return [(data[1] / (1024 * 1024)).toFixed(2), divide(data)];
    },
  ],
});

const diskValue = Variable(["0G", "0%"], {
  poll: [
    120000,
    "df -kh /",
    (out) => out.split("\n")[1].split(/\s+/).splice(3, 2),
  ],
});

const mkMetric = ({
  className,
  tooltipText,
  value,
  label,
  icon,
  visible = true,
}) =>
  Widget.Box(
    {
      spacing: 10,
      className,
      tooltipText,
      visible,
    },
    Widget.CircularProgress({
      className: "metric-progress",
      child: Widget.Icon({
        icon,
        className: "metric-icon",
      }),
      value,
    }),
    Widget.Label({
      wrap: true,
      label,
    }),
  );

export const cpuMetric = mkMetric({
  className: "cpu-metric",
  tooltipText: cpuValue.bind().as((c) => `CPU: ${(c * 100).toFixed(2)}%`),
  value: cpuValue.bind(),
  label: cpuValue.bind().as((c) => `${(c * 100).toFixed(2)}%`),
  icon: "cpu-symbolic",
});

export const memoryMetric = mkMetric({
  className: "memory-metric",
  tooltipText: memoryValue.bind().as((m) => `RAM :${m[0]}G`),
  value: memoryValue.bind().as((m) => m[1]),
  label: memoryValue.bind().as((m) => `${m[0]}G`),
  icon: "memory-symbolic",
});

export const diskMetric = mkMetric({
  className: "disk-metric",
  tooltipText: diskValue.bind().as((d) => `Free Space :${d[0]}`),
  value: diskValue.bind().as((d) => Number(d[1]) / 100),
  label: diskValue.bind().as((d) => d[1]),
  icon: "drive-harddisk-symbolic",
});

export const batteryMetric = mkMetric({
  className: "battery-metric",
  tooltipText: battery.bind("percent").as((p) => `Battery: ${p}%`),
  value: battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0)),
  label: battery.bind("percent").as((p) => `${p}%`),
  icon: battery.bind("icon_name"),
  visible: battery.bind("available"),
});
