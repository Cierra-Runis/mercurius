// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_image.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetDiaryImageCollection on Isar {
  IsarCollection<DiaryImage> get diaryImages => this.collection();
}

const DiaryImageSchema = CollectionSchema(
  name: r'DiaryImage',
  id: 6855977980390253393,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _diaryImageEstimateSize,
  serialize: _diaryImageSerialize,
  deserialize: _diaryImageDeserialize,
  deserializeProp: _diaryImageDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'diaries': LinkSchema(
      id: -825110331718546819,
      name: r'diaries',
      target: r'Diary',
      single: false,
      linkName: r'diaryImages',
    )
  },
  embeddedSchemas: {},
  getId: _diaryImageGetId,
  getLinks: _diaryImageGetLinks,
  attach: _diaryImageAttach,
  version: '3.0.5',
);

int _diaryImageEstimateSize(
  DiaryImage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _diaryImageSerialize(
  DiaryImage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
}

DiaryImage _diaryImageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DiaryImage();
  object.dateTime = reader.readDateTime(offsets[0]);
  object.id = id;
  return object;
}

P _diaryImageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _diaryImageGetId(DiaryImage object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _diaryImageGetLinks(DiaryImage object) {
  return [object.diaries];
}

void _diaryImageAttach(IsarCollection<dynamic> col, Id id, DiaryImage object) {
  object.id = id;
  object.diaries.attach(col, col.isar.collection<Diary>(), r'diaries', id);
}

extension DiaryImageQueryWhereSort
    on QueryBuilder<DiaryImage, DiaryImage, QWhere> {
  QueryBuilder<DiaryImage, DiaryImage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DiaryImageQueryWhere
    on QueryBuilder<DiaryImage, DiaryImage, QWhereClause> {
  QueryBuilder<DiaryImage, DiaryImage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DiaryImage, DiaryImage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterWhereClause> idBetween(
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

extension DiaryImageQueryFilter
    on QueryBuilder<DiaryImage, DiaryImage, QFilterCondition> {
  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> idBetween(
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
}

extension DiaryImageQueryObject
    on QueryBuilder<DiaryImage, DiaryImage, QFilterCondition> {}

extension DiaryImageQueryLinks
    on QueryBuilder<DiaryImage, DiaryImage, QFilterCondition> {
  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> diaries(
      FilterQuery<Diary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'diaries');
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition>
      diariesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'diaries', length, true, length, true);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition> diariesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'diaries', 0, true, 0, true);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition>
      diariesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'diaries', 0, false, 999999, true);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition>
      diariesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'diaries', 0, true, length, include);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition>
      diariesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'diaries', length, include, 999999, true);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterFilterCondition>
      diariesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'diaries', lower, includeLower, upper, includeUpper);
    });
  }
}

extension DiaryImageQuerySortBy
    on QueryBuilder<DiaryImage, DiaryImage, QSortBy> {
  QueryBuilder<DiaryImage, DiaryImage, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }
}

extension DiaryImageQuerySortThenBy
    on QueryBuilder<DiaryImage, DiaryImage, QSortThenBy> {
  QueryBuilder<DiaryImage, DiaryImage, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DiaryImage, DiaryImage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DiaryImageQueryWhereDistinct
    on QueryBuilder<DiaryImage, DiaryImage, QDistinct> {
  QueryBuilder<DiaryImage, DiaryImage, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }
}

extension DiaryImageQueryProperty
    on QueryBuilder<DiaryImage, DiaryImage, QQueryProperty> {
  QueryBuilder<DiaryImage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DiaryImage, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }
}
