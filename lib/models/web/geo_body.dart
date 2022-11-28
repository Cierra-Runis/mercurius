import 'package:mercurius/index.dart';

part 'geo_body.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoBody {
  GeoBody();

  String? code;
  List<Location>? location;
  Refer? refer;

  factory GeoBody.fromJson(Map<String, dynamic> json) =>
      _$GeoBodyFromJson(json);
  Map<String, dynamic> toJson() => _$GeoBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Location {
  Location();

  String? name;
  String? id;
  String? lat;
  String? lon;
  String? adm2;
  String? adm1;
  String? country;
  String? tz;
  String? utcOffset;
  String? isDst;
  String? type;
  String? rank;
  String? fxLink;
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Refer {
  Refer();

  List<String>? sources;
  List<String>? license;

  factory Refer.fromJson(Map<String, dynamic> json) => _$ReferFromJson(json);
  Map<String, dynamic> toJson() => _$ReferToJson(this);
}
