import 'package:json_annotation/json_annotation.dart';
import "index.dart";
part 'sentence.g.dart';

@JsonSerializable()
class Sentence {
  Sentence();

  late num id;
  late String context;
  late User owner;
  late String createdAt;

  factory Sentence.fromJson(Map<String, dynamic> json) =>
      _$SentenceFromJson(json);
  Map<String, dynamic> toJson() => _$SentenceToJson(this);
}
