import 'package:mercurius/index.dart';

String _ipGeoUrl =
    'https://restapi.amap.com/v3/ip?&output=json&key=eb5254d31736ca5298ad4d68fae76c09';

String _geoUrl = 'https://geoapi.qweather.com/v2/city/lookup?';

String _weatherUrl = 'https://devapi.qweather.com/v7/weather/3d?';

String _defaultIpGeoJsonString =
    '{"status":"1","info":"OK","infocode":"10000","province":"江西省","city":"南昌市","adcode":"360100","rectangle":"115.6786001,28.48182853;116.1596596,28.86719757"}';

String _defaultGeoJsonString =
    '{"code":"200","location":[{"name":"青山湖","id":"101240110","lat":"28.68929","lon":"115.94904","adm2":"南昌","adm1":"江西省","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"35","fxLink":"http://hfx.link/1ty11"}],"refer":{"sources":["QWeather"],"license":["QWeather Developers License"]}';

String _defaultWeatherJsonString =
    '{"code":"200","updateTime":"2022-11-25T13:35+08:00","fxLink":"http://hfx.link/1ty11","daily":[{"fxDate":"2022-11-25","sunrise":"06:47","sunset":"17:21","moonrise":"07:56","moonset":"18:20","moonPhase":"峨眉月","moonPhaseIcon":"801","tempMax":"21","tempMin":"16","iconDay":"101","textDay":"多云","iconNight":"151","textNight":"多云","wind360Day":"270","windDirDay":"西风","windScaleDay":"1-2","windSpeedDay":"3","wind360Night":"0","windDirNight":"北风","windScaleNight":"1-2","windSpeedNight":"3","humidity":"87","precip":"0.0","pressure":"1012","vis":"25","cloud":"25","uvIndex":"1"},{"fxDate":"2022-11-26","sunrise":"06:48","sunset":"17:21","moonrise":"09:04","moonset":"19:21","moonPhase":"峨眉月","moonPhaseIcon":"801","tempMax":"23","tempMin":"16","iconDay":"100","textDay":"晴","iconNight":"151","textNight":"多云","wind360Day":"45","windDirDay":"东北风","windScaleDay":"1-2","windSpeedDay":"3","wind360Night":"90","windDirNight":"东风","windScaleNight":"3-4","windSpeedNight":"16","humidity":"78","precip":"0.0","pressure":"1006","vis":"24","cloud":"25","uvIndex":"4"},{"fxDate":"2022-11-27","sunrise":"06:48","sunset":"17:21","moonrise":"10:08","moonset":"20:29","moonPhase":"峨眉月","moonPhaseIcon":"801","tempMax":"20","tempMin":"18","iconDay":"305","textDay":"小雨","iconNight":"305","textNight":"小雨","wind360Day":"135","windDirDay":"东南风","windScaleDay":"3-4","windSpeedDay":"16","wind360Night":"135","windDirNight":"东南风","windScaleNight":"3-4","windSpeedNight":"16","humidity":"94","precip":"1.0","pressure":"1005","vis":"12","cloud":"55","uvIndex":"1"}],"refer":{"sources":["QWeather","NMC","ECMWF"],"license":["CC BY-SA 4.0"]}}';

class LocationModel extends ChangeNotifier {
  Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime(0),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  GeoBody geoBody = GeoBody();

  WeatherBody weatherBody = WeatherBody();

  /// 获取当前位置
  void _fetchCurrentPosition(bool force) async {
    DateTime now = DateTime.now();
    CacheLocation? cacheLocation = profileModel.profile.cacheLocation;

    /// 如果含缓存地址, 时差不超过 5 天, 且非强制
    if (cacheLocation != null &&
        now.difference(cacheLocation.cacheDateTime!).inDays <= 5 &&
        !force) {
      /// 则使用缓存地址即可
      DevTools.printLog(
          '[035] profile 中已含 cacheLocation 记录且与现在时差为 ${now.difference(cacheLocation.cacheDateTime!).inSeconds} 秒，不超过 5 天，且不是强制模式');
      position = Position(
        longitude: double.parse(cacheLocation.longitude!),
        latitude: double.parse(cacheLocation.latitude!),
        timestamp: cacheLocation.cacheDateTime,
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
      );
      DevTools.printLog('[029] 获取位置为 $position');
    } else {
      /// 反之需要获取新地址
      force ? DevTools.printLog('[038] 进入强制模式') : null;

      /// 获取权限
      LocationPermission permission = await Geolocator.checkPermission();
      DevTools.printLog('[028] 当前权限状况为 $permission');
      while (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        DevTools.printLog('[023] 获取权限');
        permission = await Geolocator.requestPermission();
      }
      DevTools.printLog('[042] 当前权限状况为 $permission');
      DevTools.printLog('[030] 获取位置中');

      /// 尝试使用 GPS 定位
      try {
        position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          timeLimit: const Duration(seconds: 5),
        );
      } catch (e) {
        /// 失败则使用 ip 定位
        DevTools.printLog('[044] 超时 $e 尝试使用 ip 获取');
        Response response;
        IpGeo ipGeo;

        /// 尝试连接 ipDeo 获取位置
        try {
          response = await Dio().get(_ipGeoUrl);
        } catch (e) {
          /// TODO: 考察初次使用软件无网络进行至这一步的结果
          DevTools.printLog('[036] ipGeo 连接失败');
          notifyListeners();
          super.notifyListeners();
          return;
        }

        DevTools.printLog('[037] ipGeo 连接成功，且为 ${response.toString()}');

        if (response.statusCode == 200) {
          ipGeo = IpGeo.fromJson(jsonDecode(response.toString()));
          if (ipGeo.province == null ||
              ipGeo.city == null ||
              ipGeo.rectangle == null) {
            ipGeo = IpGeo.fromJson(jsonDecode(_defaultIpGeoJsonString));
            DevTools.printLog('[039] 获取 ipGeo 失败');
          } else {
            DevTools.printLog('[043] 获取 ipGeo 成功，且为 ${jsonEncode(ipGeo)}');
          }
        } else {
          ipGeo = IpGeo.fromJson(jsonDecode(_defaultIpGeoJsonString));
          DevTools.printLog('[040] 获取 ipGeo 失败');
        }

        var match = RegExp(r'(.*),(.*);').firstMatch(ipGeo.rectangle!);

        position = Position(
          longitude: double.parse(match![1].toString()),
          latitude: double.parse(match[2].toString()),
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
        );
      }

      DevTools.printLog('[041] 获取位置为 $position');

      profileModel.changeProfile(
        profileModel.profile
          ..cacheLocation = (CacheLocation()
            ..latitude = position.latitude.toString()
            ..longitude = position.longitude.toString()
            ..cacheDateTime = position.timestamp),
      );
    }

    _fetchGeoBody();
    notifyListeners();
    super.notifyListeners();
  }

  /// 根据当前位置获取城市信息
  void _fetchGeoBody() async {
    Response response;
    try {
      String longitude =
          (((position.longitude * 100).toInt()) / 100).toString();

      String latitude = (((position.latitude * 100).toInt()) / 100).toString();

      response = await Dio().get(
          '${_geoUrl}location=$longitude,$latitude&key=${ApiKeyConstance.weatherKey}');
    } catch (e) {
      /// TODO: 考察初次使用软件无网络进行至这一步的结果
      DevTools.printLog('[024] 城市搜索 连接失败');
      notifyListeners();
      super.notifyListeners();
      return;
    }

    DevTools.printLog('[025] 城市搜索 连接成功');

    if (response.statusCode == 200) {
      geoBody = GeoBody.fromJson(jsonDecode(response.toString()));
      DevTools.printLog('[026] 获取城市成功，且城市 id 为 ${geoBody.location![0].id}');
    } else {
      geoBody = GeoBody.fromJson(jsonDecode(_defaultGeoJsonString));
      DevTools.printLog('[027] 获取城市失败');
    }

    _fetchWeatherBody();

    notifyListeners();
    super.notifyListeners();
  }

  /// 根据当前位置获取天气
  void _fetchWeatherBody() async {
    Response response;
    try {
      response = await Dio().get(
          '${_weatherUrl}location=${geoBody.location![0].id}&key=${ApiKeyConstance.weatherKey}');
    } catch (e) {
      DevTools.printLog('[031] 天气获取 连接失败');
      notifyListeners();
      super.notifyListeners();
      return;
    }

    DevTools.printLog('[032] 天气获取 连接成功');

    if (response.statusCode == 200) {
      weatherBody = WeatherBody.fromJson(jsonDecode(response.toString()));
      DevTools.printLog('[033] 获取天气成功，且为 ${weatherBody.toJson()}');
    } else {
      weatherBody = WeatherBody.fromJson(jsonDecode(_defaultWeatherJsonString));
      DevTools.printLog('[034] 获取城市失败');
    }

    notifyListeners();
    super.notifyListeners();
  }

  void refetchCurrentPosition(bool force) {
    _fetchCurrentPosition(force);
    notifyListeners();
    super.notifyListeners();
  }

  void init() {
    DevTools.printLog('[022] CurrentPosition 初始化中');
    _fetchCurrentPosition(false);
  }
}
