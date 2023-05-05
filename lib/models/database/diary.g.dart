// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDiaryCollection on Isar {
  IsarCollection<Diary> get diarys => this.collection();
}

const DiarySchema = CollectionSchema(
  name: r'Diary',
  id: -5216934141026337743,
  properties: {
    r'contentJsonString': PropertySchema(
      id: 0,
      name: r'contentJsonString',
      type: IsarType.string,
    ),
    r'createDateTime': PropertySchema(
      id: 1,
      name: r'createDateTime',
      type: IsarType.dateTime,
    ),
    r'latestEditTime': PropertySchema(
      id: 2,
      name: r'latestEditTime',
      type: IsarType.dateTime,
    ),
    r'mood': PropertySchema(
      id: 3,
      name: r'mood',
      type: IsarType.string,
    ),
    r'titleString': PropertySchema(
      id: 4,
      name: r'titleString',
      type: IsarType.string,
    ),
    r'weather': PropertySchema(
      id: 5,
      name: r'weather',
      type: IsarType.string,
    )
  },
  estimateSize: _diaryEstimateSize,
  serialize: _diarySerialize,
  deserialize: _diaryDeserialize,
  deserializeProp: _diaryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _diaryGetId,
  getLinks: _diaryGetLinks,
  attach: _diaryAttach,
  version: '3.1.0+1',
);

int _diaryEstimateSize(
  Diary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.contentJsonString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mood.length * 3;
  {
    final value = object.titleString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.weather.length * 3;
  return bytesCount;
}

void _diarySerialize(
  Diary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contentJsonString);
  writer.writeDateTime(offsets[1], object.createDateTime);
  writer.writeDateTime(offsets[2], object.latestEditTime);
  writer.writeString(offsets[3], object.mood);
  writer.writeString(offsets[4], object.titleString);
  writer.writeString(offsets[5], object.weather);
}

Diary _diaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Diary(
    contentJsonString: reader.readStringOrNull(offsets[0]),
    createDateTime: reader.readDateTime(offsets[1]),
    id: id,
    latestEditTime: reader.readDateTime(offsets[2]),
    mood: reader.readStringOrNull(offsets[3]) ?? '一般',
    titleString: reader.readStringOrNull(offsets[4]),
    weather: reader.readStringOrNull(offsets[5]) ?? '100',
  );
  return object;
}

P _diaryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '一般') as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '100') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _diaryGetId(Diary object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _diaryGetLinks(Diary object) {
  return [];
}

void _diaryAttach(IsarCollection<dynamic> col, Id id, Diary object) {}

extension DiaryQueryWhereSort on QueryBuilder<Diary, Diary, QWhere> {
  QueryBuilder<Diary, Diary, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DiaryQueryWhere on QueryBuilder<Diary, Diary, QWhereClause> {
  QueryBuilder<Diary, Diary, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Diary, Diary, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Diary, Diary, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Diary, Diary, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DiaryQueryFilter on QueryBuilder<Diary, Diary, QFilterCondition> {
  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentJsonString',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition>
      contentJsonStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentJsonString',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition>
      contentJsonStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentJsonString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentJsonString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentJsonString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> contentJsonStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentJsonString',
        value: '',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition>
      contentJsonStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentJsonString',
        value: '',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> createDateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> createDateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> createDateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> createDateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> latestEditTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latestEditTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> latestEditTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latestEditTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> latestEditTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latestEditTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> latestEditTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latestEditTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mood',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mood',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mood',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mood',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mood',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mood',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mood',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mood',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mood',
        value: '',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mood',
        value: '',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'titleString',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'titleString',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleString',
        value: '',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> titleStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleString',
        value: '',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weather',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weather',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weather',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weather',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'weather',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'weather',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'weather',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'weather',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weather',
        value: '',
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'weather',
        value: '',
      ));
    });
  }
}

extension DiaryQueryObject on QueryBuilder<Diary, Diary, QFilterCondition> {}

extension DiaryQueryLinks on QueryBuilder<Diary, Diary, QFilterCondition> {}

extension DiaryQuerySortBy on QueryBuilder<Diary, Diary, QSortBy> {
  QueryBuilder<Diary, Diary, QAfterSortBy> sortByContentJsonString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentJsonString', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByContentJsonStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentJsonString', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByCreateDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByLatestEditTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestEditTime', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByLatestEditTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestEditTime', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByTitleString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleString', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByTitleStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleString', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByWeather() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weather', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByWeatherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weather', Sort.desc);
    });
  }
}

extension DiaryQuerySortThenBy on QueryBuilder<Diary, Diary, QSortThenBy> {
  QueryBuilder<Diary, Diary, QAfterSortBy> thenByContentJsonString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentJsonString', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByContentJsonStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentJsonString', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByCreateDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByLatestEditTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestEditTime', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByLatestEditTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestEditTime', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByTitleString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleString', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByTitleStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleString', Sort.desc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByWeather() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weather', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByWeatherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weather', Sort.desc);
    });
  }
}

extension DiaryQueryWhereDistinct on QueryBuilder<Diary, Diary, QDistinct> {
  QueryBuilder<Diary, Diary, QDistinct> distinctByContentJsonString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentJsonString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diary, Diary, QDistinct> distinctByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createDateTime');
    });
  }

  QueryBuilder<Diary, Diary, QDistinct> distinctByLatestEditTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latestEditTime');
    });
  }

  QueryBuilder<Diary, Diary, QDistinct> distinctByMood(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mood', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diary, Diary, QDistinct> distinctByTitleString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleString', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diary, Diary, QDistinct> distinctByWeather(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weather', caseSensitive: caseSensitive);
    });
  }
}

extension DiaryQueryProperty on QueryBuilder<Diary, Diary, QQueryProperty> {
  QueryBuilder<Diary, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Diary, String?, QQueryOperations> contentJsonStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentJsonString');
    });
  }

  QueryBuilder<Diary, DateTime, QQueryOperations> createDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createDateTime');
    });
  }

  QueryBuilder<Diary, DateTime, QQueryOperations> latestEditTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latestEditTime');
    });
  }

  QueryBuilder<Diary, String, QQueryOperations> moodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mood');
    });
  }

  QueryBuilder<Diary, String?, QQueryOperations> titleStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleString');
    });
  }

  QueryBuilder<Diary, String, QQueryOperations> weatherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weather');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diary _$DiaryFromJson(Map<String, dynamic> json) => Diary(
      id: json['id'] as int?,
      createDateTime: DateTime.parse(json['createDateTime'] as String),
      latestEditTime: DateTime.parse(json['latestEditTime'] as String),
      titleString: json['titleString'] as String?,
      contentJsonString: json['contentJsonString'] as String?,
      mood: json['mood'] as String? ?? '一般',
      weather: json['weather'] as String? ?? '100',
    );

Map<String, dynamic> _$DiaryToJson(Diary instance) => <String, dynamic>{
      'id': instance.id,
      'createDateTime': instance.createDateTime.toIso8601String(),
      'latestEditTime': instance.latestEditTime.toIso8601String(),
      'titleString': instance.titleString,
      'contentJsonString': instance.contentJsonString,
      'weather': instance.weather,
      'mood': instance.mood,
    };
