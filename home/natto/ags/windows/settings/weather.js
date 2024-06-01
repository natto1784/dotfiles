const conditionIcons = {
  Clear: "clear",
  Sunny: "clear",
  "Partly Cloudy": "few-clouds",
  Cloudy: "overcast",
  Overcast: "overcast",
  "Light Rain": "showers-scattered",
  Drizzle: "showers-scattered",
  Rain: "showers",
  "Heavy Rain": "showers",
  Showers: "showers",
  Thunderstorm: "storm",
  Snow: "snow",
  "Light Snow": "snow",
  "Heavy Snow": "snow",
  Mist: "fog",
  Fog: "fog",
  Haze: "fog",
  Dust: "fog",
  Smoke: "fog",
  Sand: "fog",
  Wind: "windy",
  Tornado: "tornado",
  undefined: "clear",
};

const fetchWeather = async () => {
  return await Utils.fetch("http://wttr.in/?format=j1")
    .then((res) => res.json())
    .then((j) => j["current_condition"][0])
    .catch((e) => {
      console.error(e);
      console.log("settings/weather: error fetching weather data");
    });
};

export default () => {
  const data = Variable(undefined, {
    poll: [600000, async () => await fetchWeather()],
  });

  return Widget.Box(
    {
      vertical: true,
      visible: data.bind().as((d) => !!d),
      className: "weather",
    },
    Widget.Icon({
      icon: data.bind().as((d) => {
        const condition = d?.["weatherDesc"]?.[0]?.["value"];
        return `weather-${conditionIcons[condition]}-symbolic`;
      }),
    }),
    Widget.Label({
      label: data.bind().as((d) => {
        const conditions = d?.["weatherDesc"]?.map((w) => w["value"]) || [];

        return conditions.join(" ");
      }),
    }),
    Widget.Label({
      label: data.bind().as((d) => {
        const temperature = d?.["temp_C"];
        const feelsLike = d?.["FeelsLikeC"];

        return `${temperature}°C (${feelsLike}°C)`;
      }),
    }),
    Widget.Label({
      label: data.bind().as((d) => {
        const humidity = d?.["humidity"];
        const precipitation = d?.["precipMM"];

        return `${humidity}%, ${precipitation}mm`;
      }),
    }),
  );
};
