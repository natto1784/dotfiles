import Bar from "./windows/bar/index.js";
import Settings from "./windows/settings/index.js";
import MusicBox from "./windows/music-box/index.js";
import Calendar from "./windows/calendar.js";

const configDir = App.configDir;

const scssStyle = `${configDir}/style.scss`;
const cssStyle = `${configDir}/style.css`;

const compileSass = () => {
  Utils.exec(`scss ${scssStyle} ${cssStyle}`);
  console.log("sass compiled to css");
};

compileSass();

Utils.monitorFile(`${configDir}/styles`, () => {
  console.log("change detected in style");
  compileSass();
  App.resetCss();
  App.applyCss(cssStyle);
  console.log("new style applied");
});

App.config({
  style: "./style.css",
  windows: [Bar(), MusicBox(), Settings(), Calendar()],
});

export {};
