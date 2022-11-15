import 'package:mercurius/index.dart';

part 'sentence.g.dart';

@JsonSerializable()
class Sentence {
  Sentence();

  num? id;
  String? context;
  User? owner;
  String? createdAt;

  factory Sentence.fromJson(Map<String, dynamic> json) =>
      _$SentenceFromJson(json);
  Map<String, dynamic> toJson() => _$SentenceToJson(this);
}
