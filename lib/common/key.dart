enum MercuriusApi {
  aMap(
    'aMap',
    'aMap related api',
    'https://restapi.amap.com/v3/ip',
    'eb5254d31736ca5298ad4d68fae76c09',
  ),
  qWeather(
    'qWeather',
    'qWeather related api',
    'https://devapi.qweather.com/v7/weather/now',
    'a13fc8e191d14cc0930bc07c6660d900',
  );

  const MercuriusApi(
    this.apiName,
    this.apiDescription,
    this.apiUrl,
    this.apiKey,
  );

  final String apiName;
  final String apiDescription;
  final String apiUrl;
  final String apiKey;
}
