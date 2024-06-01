import GLib from "gi://GLib";

export const lengthStr = (length) => {
  if (length < 0) return "0:00";

  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
};

export const blurBg = (cover) => {
  if (!cover) return "";

  const cachePath = Utils.CACHE_DIR + "/media";
  const blurPath = cachePath + "/blur";
  const bgPath = blurPath + cover.substring(cachePath.length);

  if (!GLib.file_test(bgPath, GLib.FileTest.EXISTS)) {
    Utils.ensureDirectory(blurPath);
    Utils.exec(
      `convert ${cover}  -scale 10% -blur 0x2 -resize 1000% ${bgPath}`,
    );
  }

  return `
background-image: url('${bgPath}');
background-repeat: no-repeat;
background-position: center;
background-size: cover;
  `;
};

export const findPlayer = (players) => {
  const active = players.find((p) => p.playBackStatus === "Playing");

  if (active) return active;

  for (const p of players) if (p) return p;

  return undefined;
};
