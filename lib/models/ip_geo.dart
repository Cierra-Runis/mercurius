import 'package:mercurius/index.dart';

part 'ip_geo.g.dart';

@JsonSerializable(explicitToJson: true)
class IpGeo {
  IpGeo();

  String? status;
  String? info;
  String? infocode;
  String? province;
  String? city;
  String? adcode;
  String? rectangle;

  factory IpGeo.fromJson(Map<String, dynamic> json) => _$IpGeoFromJson(json);
  Map<String, dynamic> toJson() => _$IpGeoToJson(this);
}
