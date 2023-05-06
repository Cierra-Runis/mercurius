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
    r'moodType': PropertySchema(
      id: 3,
      name: r'moodType',
      type: IsarType.byte,
      enumMap: _DiarymoodTypeEnumValueMap,
    ),
    r'titleString': PropertySchema(
      id: 4,
      name: r'titleString',
      type: IsarType.string,
    ),
    r'weatherType': PropertySchema(
      id: 5,
      name: r'weatherType',
      type: IsarType.byte,
      enumMap: _DiaryweatherTypeEnumValueMap,
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
  {
    final value = object.titleString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
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
  writer.writeByte(offsets[3], object.moodType.index);
  writer.writeString(offsets[4], object.titleString);
  writer.writeByte(offsets[5], object.weatherType.index);
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
    moodType: _DiarymoodTypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
        DiaryMoodType.defaultType,
    titleString: reader.readStringOrNull(offsets[4]),
    weatherType:
        _DiaryweatherTypeValueEnumMap[reader.readByteOrNull(offsets[5])] ??
            DiaryWeatherType.defaultType,
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
      return (_DiarymoodTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          DiaryMoodType.defaultType) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (_DiaryweatherTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          DiaryWeatherType.defaultType) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DiarymoodTypeEnumValueMap = {
  'defaultType': 0,
  'angry': 1,
  'confused': 2,
  'frown': 3,
  'laughing': 4,
  'silentSquint': 5,
  'sadCrying': 6,
  'smileDizzy': 7,
  'mehClosedEye': 8,
};
const _DiarymoodTypeValueEnumMap = {
  0: DiaryMoodType.defaultType,
  1: DiaryMoodType.angry,
  2: DiaryMoodType.confused,
  3: DiaryMoodType.frown,
  4: DiaryMoodType.laughing,
  5: DiaryMoodType.silentSquint,
  6: DiaryMoodType.sadCrying,
  7: DiaryMoodType.smileDizzy,
  8: DiaryMoodType.mehClosedEye,
};
const _DiaryweatherTypeEnumValueMap = {
  'defaultType': 0,
  'cloudy': 1,
  'fewClouds': 2,
  'heavyThunderstorm': 3,
  'lightRain': 4,
  'heavyRain': 5,
  'lightSnow': 6,
  'heavySnow': 7,
  'foggy': 8,
};
const _DiaryweatherTypeValueEnumMap = {
  0: DiaryWeatherType.defaultType,
  1: DiaryWeatherType.cloudy,
  2: DiaryWeatherType.fewClouds,
  3: DiaryWeatherType.heavyThunderstorm,
  4: DiaryWeatherType.lightRain,
  5: DiaryWeatherType.heavyRain,
  6: DiaryWeatherType.lightSnow,
  7: DiaryWeatherType.heavySnow,
  8: DiaryWeatherType.foggy,
};

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

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodTypeEqualTo(
      DiaryMoodType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodType',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodTypeGreaterThan(
    DiaryMoodType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moodType',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodTypeLessThan(
    DiaryMoodType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moodType',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> moodTypeBetween(
    DiaryMoodType lower,
    DiaryMoodType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moodType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherTypeEqualTo(
      DiaryWeatherType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weatherType',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherTypeGreaterThan(
    DiaryWeatherType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weatherType',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherTypeLessThan(
    DiaryWeatherType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weatherType',
        value: value,
      ));
    });
  }

  QueryBuilder<Diary, Diary, QAfterFilterCondition> weatherTypeBetween(
    DiaryWeatherType lower,
    DiaryWeatherType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weatherType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByMoodType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodType', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByMoodTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodType', Sort.desc);
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

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByWeatherType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherType', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> sortByWeatherTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherType', Sort.desc);
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

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByMoodType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodType', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByMoodTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodType', Sort.desc);
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

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByWeatherType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherType', Sort.asc);
    });
  }

  QueryBuilder<Diary, Diary, QAfterSortBy> thenByWeatherTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherType', Sort.desc);
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

  QueryBuilder<Diary, Diary, QDistinct> distinctByMoodType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moodType');
    });
  }

  QueryBuilder<Diary, Diary, QDistinct> distinctByTitleString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleString', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diary, Diary, QDistinct> distinctByWeatherType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weatherType');
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

  QueryBuilder<Diary, DiaryMoodType, QQueryOperations> moodTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moodType');
    });
  }

  QueryBuilder<Diary, String?, QQueryOperations> titleStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleString');
    });
  }

  QueryBuilder<Diary, DiaryWeatherType, QQueryOperations>
      weatherTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weatherType');
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
      moodType: $enumDecodeNullable(_$DiaryMoodTypeEnumMap, json['moodType']) ??
          DiaryMoodType.defaultType,
      weatherType:
          $enumDecodeNullable(_$DiaryWeatherTypeEnumMap, json['weatherType']) ??
              DiaryWeatherType.defaultType,
    );

Map<String, dynamic> _$DiaryToJson(Diary instance) => <String, dynamic>{
      'id': instance.id,
      'createDateTime': instance.createDateTime.toIso8601String(),
      'latestEditTime': instance.latestEditTime.toIso8601String(),
      'titleString': instance.titleString,
      'contentJsonString': instance.contentJsonString,
      'weatherType': _$DiaryWeatherTypeEnumMap[instance.weatherType]!,
      'moodType': _$DiaryMoodTypeEnumMap[instance.moodType]!,
    };

const _$DiaryMoodTypeEnumMap = {
  DiaryMoodType.defaultType: 'defaultType',
  DiaryMoodType.angry: 'angry',
  DiaryMoodType.confused: 'confused',
  DiaryMoodType.frown: 'frown',
  DiaryMoodType.laughing: 'laughing',
  DiaryMoodType.silentSquint: 'silentSquint',
  DiaryMoodType.sadCrying: 'sadCrying',
  DiaryMoodType.smileDizzy: 'smileDizzy',
  DiaryMoodType.mehClosedEye: 'mehClosedEye',
};

const _$DiaryWeatherTypeEnumMap = {
  DiaryWeatherType.defaultType: 'defaultType',
  DiaryWeatherType.cloudy: 'cloudy',
  DiaryWeatherType.fewClouds: 'fewClouds',
  DiaryWeatherType.heavyThunderstorm: 'heavyThunderstorm',
  DiaryWeatherType.lightRain: 'lightRain',
  DiaryWeatherType.heavyRain: 'heavyRain',
  DiaryWeatherType.lightSnow: 'lightSnow',
  DiaryWeatherType.heavySnow: 'heavySnow',
  DiaryWeatherType.foggy: 'foggy',
};
