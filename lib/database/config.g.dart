// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConfigCollection on Isar {
  IsarCollection<Config> get configs => this.collection();
}

const ConfigSchema = CollectionSchema(
  name: r'Config',
  id: -3644000870443854999,
  properties: {
    r'backgroundImagePath': PropertySchema(
      id: 0,
      name: r'backgroundImagePath',
      type: IsarType.string,
    ),
    r'themeMode': PropertySchema(
      id: 1,
      name: r'themeMode',
      type: IsarType.byte,
      enumMap: _ConfigthemeModeEnumValueMap,
    )
  },
  estimateSize: _configEstimateSize,
  serialize: _configSerialize,
  deserialize: _configDeserialize,
  deserializeProp: _configDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _configGetId,
  getLinks: _configGetLinks,
  attach: _configAttach,
  version: '3.1.0+1',
);

int _configEstimateSize(
  Config object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.backgroundImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _configSerialize(
  Config object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.backgroundImagePath);
  writer.writeByte(offsets[1], object.themeMode.index);
}

Config _configDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Config(
    themeMode:
        _ConfigthemeModeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
            ThemeMode.system,
  );
  object.backgroundImagePath = reader.readStringOrNull(offsets[0]);
  object.id = id;
  return object;
}

P _configDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (_ConfigthemeModeValueEnumMap[reader.readByteOrNull(offset)] ??
          ThemeMode.system) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ConfigthemeModeEnumValueMap = {
  'system': 0,
  'light': 1,
  'dark': 2,
};
const _ConfigthemeModeValueEnumMap = {
  0: ThemeMode.system,
  1: ThemeMode.light,
  2: ThemeMode.dark,
};

Id _configGetId(Config object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _configGetLinks(Config object) {
  return [];
}

void _configAttach(IsarCollection<dynamic> col, Id id, Config object) {
  object.id = id;
}

extension ConfigQueryWhereSort on QueryBuilder<Config, Config, QWhere> {
  QueryBuilder<Config, Config, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConfigQueryWhere on QueryBuilder<Config, Config, QWhereClause> {
  QueryBuilder<Config, Config, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Config, Config, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idBetween(
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

extension ConfigQueryFilter on QueryBuilder<Config, Config, QFilterCondition> {
  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backgroundImagePath',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backgroundImagePath',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'backgroundImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'backgroundImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'backgroundImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'backgroundImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'backgroundImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backgroundImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backgroundImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      backgroundImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backgroundImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<Config, Config, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<Config, Config, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeEqualTo(
      ThemeMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeGreaterThan(
    ThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeLessThan(
    ThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeBetween(
    ThemeMode lower,
    ThemeMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConfigQueryObject on QueryBuilder<Config, Config, QFilterCondition> {}

extension ConfigQueryLinks on QueryBuilder<Config, Config, QFilterCondition> {}

extension ConfigQuerySortBy on QueryBuilder<Config, Config, QSortBy> {
  QueryBuilder<Config, Config, QAfterSortBy> sortByBackgroundImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundImagePath', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByBackgroundImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundImagePath', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }
}

extension ConfigQuerySortThenBy on QueryBuilder<Config, Config, QSortThenBy> {
  QueryBuilder<Config, Config, QAfterSortBy> thenByBackgroundImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundImagePath', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByBackgroundImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundImagePath', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }
}

extension ConfigQueryWhereDistinct on QueryBuilder<Config, Config, QDistinct> {
  QueryBuilder<Config, Config, QDistinct> distinctByBackgroundImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode');
    });
  }
}

extension ConfigQueryProperty on QueryBuilder<Config, Config, QQueryProperty> {
  QueryBuilder<Config, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Config, String?, QQueryOperations>
      backgroundImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundImagePath');
    });
  }

  QueryBuilder<Config, ThemeMode, QQueryOperations> themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }
}
