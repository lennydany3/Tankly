// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SyncStatus>($VehiclesTable.$convertersyncStatus);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tankCapacityLMeta = const VerificationMeta(
    'tankCapacityL',
  );
  @override
  late final GeneratedColumn<double> tankCapacityL = GeneratedColumn<double>(
    'tank_capacity_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(Fuel.defaultTankCapacityL),
  );
  static const VerificationMeta _reserveLMeta = const VerificationMeta(
    'reserveL',
  );
  @override
  late final GeneratedColumn<double> reserveL = GeneratedColumn<double>(
    'reserve_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(Fuel.defaultReserveL),
  );
  static const VerificationMeta _defaultMileageKmplMeta =
      const VerificationMeta('defaultMileageKmpl');
  @override
  late final GeneratedColumn<double> defaultMileageKmpl =
      GeneratedColumn<double>(
        'default_mileage_kmpl',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(Fuel.defaultMileageKmpl),
      );
  static const VerificationMeta _learnedMileageKmplMeta =
      const VerificationMeta('learnedMileageKmpl');
  @override
  late final GeneratedColumn<double> learnedMileageKmpl =
      GeneratedColumn<double>(
        'learned_mileage_kmpl',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _distanceFactorMeta = const VerificationMeta(
    'distanceFactor',
  );
  @override
  late final GeneratedColumn<double> distanceFactor = GeneratedColumn<double>(
    'distance_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _safetyFactorMeta = const VerificationMeta(
    'safetyFactor',
  );
  @override
  late final GeneratedColumn<double> safetyFactor = GeneratedColumn<double>(
    'safety_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(Fuel.defaultSafetyFactor),
  );
  static const VerificationMeta _lowFuelThresholdLMeta = const VerificationMeta(
    'lowFuelThresholdL',
  );
  @override
  late final GeneratedColumn<double> lowFuelThresholdL =
      GeneratedColumn<double>(
        'low_fuel_threshold_l',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(Fuel.defaultLowThresholdL),
      );
  static const VerificationMeta _odometerStartKmMeta = const VerificationMeta(
    'odometerStartKm',
  );
  @override
  late final GeneratedColumn<double> odometerStartKm = GeneratedColumn<double>(
    'odometer_start_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    name,
    tankCapacityL,
    reserveL,
    defaultMileageKmpl,
    learnedMileageKmpl,
    distanceFactor,
    safetyFactor,
    lowFuelThresholdL,
    odometerStartKm,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tank_capacity_l')) {
      context.handle(
        _tankCapacityLMeta,
        tankCapacityL.isAcceptableOrUnknown(
          data['tank_capacity_l']!,
          _tankCapacityLMeta,
        ),
      );
    }
    if (data.containsKey('reserve_l')) {
      context.handle(
        _reserveLMeta,
        reserveL.isAcceptableOrUnknown(data['reserve_l']!, _reserveLMeta),
      );
    }
    if (data.containsKey('default_mileage_kmpl')) {
      context.handle(
        _defaultMileageKmplMeta,
        defaultMileageKmpl.isAcceptableOrUnknown(
          data['default_mileage_kmpl']!,
          _defaultMileageKmplMeta,
        ),
      );
    }
    if (data.containsKey('learned_mileage_kmpl')) {
      context.handle(
        _learnedMileageKmplMeta,
        learnedMileageKmpl.isAcceptableOrUnknown(
          data['learned_mileage_kmpl']!,
          _learnedMileageKmplMeta,
        ),
      );
    }
    if (data.containsKey('distance_factor')) {
      context.handle(
        _distanceFactorMeta,
        distanceFactor.isAcceptableOrUnknown(
          data['distance_factor']!,
          _distanceFactorMeta,
        ),
      );
    }
    if (data.containsKey('safety_factor')) {
      context.handle(
        _safetyFactorMeta,
        safetyFactor.isAcceptableOrUnknown(
          data['safety_factor']!,
          _safetyFactorMeta,
        ),
      );
    }
    if (data.containsKey('low_fuel_threshold_l')) {
      context.handle(
        _lowFuelThresholdLMeta,
        lowFuelThresholdL.isAcceptableOrUnknown(
          data['low_fuel_threshold_l']!,
          _lowFuelThresholdLMeta,
        ),
      );
    }
    if (data.containsKey('odometer_start_km')) {
      context.handle(
        _odometerStartKmMeta,
        odometerStartKm.isAcceptableOrUnknown(
          data['odometer_start_km']!,
          _odometerStartKmMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $VehiclesTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      tankCapacityL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tank_capacity_l'],
      )!,
      reserveL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reserve_l'],
      )!,
      defaultMileageKmpl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_mileage_kmpl'],
      )!,
      learnedMileageKmpl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}learned_mileage_kmpl'],
      ),
      distanceFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_factor'],
      )!,
      safetyFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}safety_factor'],
      )!,
      lowFuelThresholdL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}low_fuel_threshold_l'],
      )!,
      odometerStartKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_start_km'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const EnumIndexConverter<SyncStatus>(SyncStatus.values);
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  /// Client-generated UUID v4. Safe to retry, so a push can be replayed.
  final String id;

  /// Null until the rider signs in with Google, then stamped on every row.
  final String? userId;
  final DateTime createdAt;

  /// UTC, moved on every local change. A push only marks a row synced when this
  /// value is unchanged by the time the server confirms.
  final DateTime updatedAt;

  /// Soft delete. Nothing is ever removed from the local database, so an offline
  /// delete still syncs as a delete.
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final String name;
  final double tankCapacityL;

  /// Litres kept in reserve. Below this the gauge shows the reserve notch and
  /// the range estimate is not trusted.
  final double reserveL;

  /// Cold-start mileage. Used until [learnedMileageKmpl] exists.
  final double defaultMileageKmpl;

  /// Filled in by `MileageLearner` at refuel time.
  final double? learnedMileageKmpl;

  /// Corrects systematic GPS distance error, learned from odometer checks.
  /// Clamped to `[Odometer.minFactor, Odometer.maxFactor]`.
  final double distanceFactor;

  /// Range is quoted at `mileage x safetyFactor`.
  final double safetyFactor;
  final double lowFuelThresholdL;

  /// Real odometer at setup. The basis for the estimated odometer.
  final double odometerStartKm;
  final bool isActive;
  const Vehicle({
    required this.id,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.name,
    required this.tankCapacityL,
    required this.reserveL,
    required this.defaultMileageKmpl,
    this.learnedMileageKmpl,
    required this.distanceFactor,
    required this.safetyFactor,
    required this.lowFuelThresholdL,
    required this.odometerStartKm,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['sync_status'] = Variable<int>(
        $VehiclesTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['name'] = Variable<String>(name);
    map['tank_capacity_l'] = Variable<double>(tankCapacityL);
    map['reserve_l'] = Variable<double>(reserveL);
    map['default_mileage_kmpl'] = Variable<double>(defaultMileageKmpl);
    if (!nullToAbsent || learnedMileageKmpl != null) {
      map['learned_mileage_kmpl'] = Variable<double>(learnedMileageKmpl);
    }
    map['distance_factor'] = Variable<double>(distanceFactor);
    map['safety_factor'] = Variable<double>(safetyFactor);
    map['low_fuel_threshold_l'] = Variable<double>(lowFuelThresholdL);
    map['odometer_start_km'] = Variable<double>(odometerStartKm);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      name: Value(name),
      tankCapacityL: Value(tankCapacityL),
      reserveL: Value(reserveL),
      defaultMileageKmpl: Value(defaultMileageKmpl),
      learnedMileageKmpl: learnedMileageKmpl == null && nullToAbsent
          ? const Value.absent()
          : Value(learnedMileageKmpl),
      distanceFactor: Value(distanceFactor),
      safetyFactor: Value(safetyFactor),
      lowFuelThresholdL: Value(lowFuelThresholdL),
      odometerStartKm: Value(odometerStartKm),
      isActive: Value(isActive),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: $VehiclesTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      name: serializer.fromJson<String>(json['name']),
      tankCapacityL: serializer.fromJson<double>(json['tankCapacityL']),
      reserveL: serializer.fromJson<double>(json['reserveL']),
      defaultMileageKmpl: serializer.fromJson<double>(
        json['defaultMileageKmpl'],
      ),
      learnedMileageKmpl: serializer.fromJson<double?>(
        json['learnedMileageKmpl'],
      ),
      distanceFactor: serializer.fromJson<double>(json['distanceFactor']),
      safetyFactor: serializer.fromJson<double>(json['safetyFactor']),
      lowFuelThresholdL: serializer.fromJson<double>(json['lowFuelThresholdL']),
      odometerStartKm: serializer.fromJson<double>(json['odometerStartKm']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<int>(
        $VehiclesTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'name': serializer.toJson<String>(name),
      'tankCapacityL': serializer.toJson<double>(tankCapacityL),
      'reserveL': serializer.toJson<double>(reserveL),
      'defaultMileageKmpl': serializer.toJson<double>(defaultMileageKmpl),
      'learnedMileageKmpl': serializer.toJson<double?>(learnedMileageKmpl),
      'distanceFactor': serializer.toJson<double>(distanceFactor),
      'safetyFactor': serializer.toJson<double>(safetyFactor),
      'lowFuelThresholdL': serializer.toJson<double>(lowFuelThresholdL),
      'odometerStartKm': serializer.toJson<double>(odometerStartKm),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Vehicle copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    String? name,
    double? tankCapacityL,
    double? reserveL,
    double? defaultMileageKmpl,
    Value<double?> learnedMileageKmpl = const Value.absent(),
    double? distanceFactor,
    double? safetyFactor,
    double? lowFuelThresholdL,
    double? odometerStartKm,
    bool? isActive,
  }) => Vehicle(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    name: name ?? this.name,
    tankCapacityL: tankCapacityL ?? this.tankCapacityL,
    reserveL: reserveL ?? this.reserveL,
    defaultMileageKmpl: defaultMileageKmpl ?? this.defaultMileageKmpl,
    learnedMileageKmpl: learnedMileageKmpl.present
        ? learnedMileageKmpl.value
        : this.learnedMileageKmpl,
    distanceFactor: distanceFactor ?? this.distanceFactor,
    safetyFactor: safetyFactor ?? this.safetyFactor,
    lowFuelThresholdL: lowFuelThresholdL ?? this.lowFuelThresholdL,
    odometerStartKm: odometerStartKm ?? this.odometerStartKm,
    isActive: isActive ?? this.isActive,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      name: data.name.present ? data.name.value : this.name,
      tankCapacityL: data.tankCapacityL.present
          ? data.tankCapacityL.value
          : this.tankCapacityL,
      reserveL: data.reserveL.present ? data.reserveL.value : this.reserveL,
      defaultMileageKmpl: data.defaultMileageKmpl.present
          ? data.defaultMileageKmpl.value
          : this.defaultMileageKmpl,
      learnedMileageKmpl: data.learnedMileageKmpl.present
          ? data.learnedMileageKmpl.value
          : this.learnedMileageKmpl,
      distanceFactor: data.distanceFactor.present
          ? data.distanceFactor.value
          : this.distanceFactor,
      safetyFactor: data.safetyFactor.present
          ? data.safetyFactor.value
          : this.safetyFactor,
      lowFuelThresholdL: data.lowFuelThresholdL.present
          ? data.lowFuelThresholdL.value
          : this.lowFuelThresholdL,
      odometerStartKm: data.odometerStartKm.present
          ? data.odometerStartKm.value
          : this.odometerStartKm,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('name: $name, ')
          ..write('tankCapacityL: $tankCapacityL, ')
          ..write('reserveL: $reserveL, ')
          ..write('defaultMileageKmpl: $defaultMileageKmpl, ')
          ..write('learnedMileageKmpl: $learnedMileageKmpl, ')
          ..write('distanceFactor: $distanceFactor, ')
          ..write('safetyFactor: $safetyFactor, ')
          ..write('lowFuelThresholdL: $lowFuelThresholdL, ')
          ..write('odometerStartKm: $odometerStartKm, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    name,
    tankCapacityL,
    reserveL,
    defaultMileageKmpl,
    learnedMileageKmpl,
    distanceFactor,
    safetyFactor,
    lowFuelThresholdL,
    odometerStartKm,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.name == this.name &&
          other.tankCapacityL == this.tankCapacityL &&
          other.reserveL == this.reserveL &&
          other.defaultMileageKmpl == this.defaultMileageKmpl &&
          other.learnedMileageKmpl == this.learnedMileageKmpl &&
          other.distanceFactor == this.distanceFactor &&
          other.safetyFactor == this.safetyFactor &&
          other.lowFuelThresholdL == this.lowFuelThresholdL &&
          other.odometerStartKm == this.odometerStartKm &&
          other.isActive == this.isActive);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<String> name;
  final Value<double> tankCapacityL;
  final Value<double> reserveL;
  final Value<double> defaultMileageKmpl;
  final Value<double?> learnedMileageKmpl;
  final Value<double> distanceFactor;
  final Value<double> safetyFactor;
  final Value<double> lowFuelThresholdL;
  final Value<double> odometerStartKm;
  final Value<bool> isActive;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.name = const Value.absent(),
    this.tankCapacityL = const Value.absent(),
    this.reserveL = const Value.absent(),
    this.defaultMileageKmpl = const Value.absent(),
    this.learnedMileageKmpl = const Value.absent(),
    this.distanceFactor = const Value.absent(),
    this.safetyFactor = const Value.absent(),
    this.lowFuelThresholdL = const Value.absent(),
    this.odometerStartKm = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required String name,
    this.tankCapacityL = const Value.absent(),
    this.reserveL = const Value.absent(),
    this.defaultMileageKmpl = const Value.absent(),
    this.learnedMileageKmpl = const Value.absent(),
    this.distanceFactor = const Value.absent(),
    this.safetyFactor = const Value.absent(),
    this.lowFuelThresholdL = const Value.absent(),
    this.odometerStartKm = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       name = Value(name);
  static Insertable<Vehicle> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? syncStatus,
    Expression<String>? name,
    Expression<double>? tankCapacityL,
    Expression<double>? reserveL,
    Expression<double>? defaultMileageKmpl,
    Expression<double>? learnedMileageKmpl,
    Expression<double>? distanceFactor,
    Expression<double>? safetyFactor,
    Expression<double>? lowFuelThresholdL,
    Expression<double>? odometerStartKm,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (name != null) 'name': name,
      if (tankCapacityL != null) 'tank_capacity_l': tankCapacityL,
      if (reserveL != null) 'reserve_l': reserveL,
      if (defaultMileageKmpl != null)
        'default_mileage_kmpl': defaultMileageKmpl,
      if (learnedMileageKmpl != null)
        'learned_mileage_kmpl': learnedMileageKmpl,
      if (distanceFactor != null) 'distance_factor': distanceFactor,
      if (safetyFactor != null) 'safety_factor': safetyFactor,
      if (lowFuelThresholdL != null) 'low_fuel_threshold_l': lowFuelThresholdL,
      if (odometerStartKm != null) 'odometer_start_km': odometerStartKm,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<String>? name,
    Value<double>? tankCapacityL,
    Value<double>? reserveL,
    Value<double>? defaultMileageKmpl,
    Value<double?>? learnedMileageKmpl,
    Value<double>? distanceFactor,
    Value<double>? safetyFactor,
    Value<double>? lowFuelThresholdL,
    Value<double>? odometerStartKm,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      name: name ?? this.name,
      tankCapacityL: tankCapacityL ?? this.tankCapacityL,
      reserveL: reserveL ?? this.reserveL,
      defaultMileageKmpl: defaultMileageKmpl ?? this.defaultMileageKmpl,
      learnedMileageKmpl: learnedMileageKmpl ?? this.learnedMileageKmpl,
      distanceFactor: distanceFactor ?? this.distanceFactor,
      safetyFactor: safetyFactor ?? this.safetyFactor,
      lowFuelThresholdL: lowFuelThresholdL ?? this.lowFuelThresholdL,
      odometerStartKm: odometerStartKm ?? this.odometerStartKm,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $VehiclesTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tankCapacityL.present) {
      map['tank_capacity_l'] = Variable<double>(tankCapacityL.value);
    }
    if (reserveL.present) {
      map['reserve_l'] = Variable<double>(reserveL.value);
    }
    if (defaultMileageKmpl.present) {
      map['default_mileage_kmpl'] = Variable<double>(defaultMileageKmpl.value);
    }
    if (learnedMileageKmpl.present) {
      map['learned_mileage_kmpl'] = Variable<double>(learnedMileageKmpl.value);
    }
    if (distanceFactor.present) {
      map['distance_factor'] = Variable<double>(distanceFactor.value);
    }
    if (safetyFactor.present) {
      map['safety_factor'] = Variable<double>(safetyFactor.value);
    }
    if (lowFuelThresholdL.present) {
      map['low_fuel_threshold_l'] = Variable<double>(lowFuelThresholdL.value);
    }
    if (odometerStartKm.present) {
      map['odometer_start_km'] = Variable<double>(odometerStartKm.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('name: $name, ')
          ..write('tankCapacityL: $tankCapacityL, ')
          ..write('reserveL: $reserveL, ')
          ..write('defaultMileageKmpl: $defaultMileageKmpl, ')
          ..write('learnedMileageKmpl: $learnedMileageKmpl, ')
          ..write('distanceFactor: $distanceFactor, ')
          ..write('safetyFactor: $safetyFactor, ')
          ..write('lowFuelThresholdL: $lowFuelThresholdL, ')
          ..write('odometerStartKm: $odometerStartKm, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RefuelsTable extends Refuels with TableInfo<$RefuelsTable, Refuel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RefuelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SyncStatus>($RefuelsTable.$convertersyncStatus);
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litresMeta = const VerificationMeta('litres');
  @override
  late final GeneratedColumn<double> litres = GeneratedColumn<double>(
    'litres',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceTotalMeta = const VerificationMeta(
    'priceTotal',
  );
  @override
  late final GeneratedColumn<double> priceTotal = GeneratedColumn<double>(
    'price_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerLMeta = const VerificationMeta(
    'pricePerL',
  );
  @override
  late final GeneratedColumn<double> pricePerL = GeneratedColumn<double>(
    'price_per_l',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<double> odometerKm = GeneratedColumn<double>(
    'odometer_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFullMeta = const VerificationMeta('isFull');
  @override
  late final GeneratedColumn<bool> isFull = GeneratedColumn<bool>(
    'is_full',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_full" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AnchorMode, int> anchorMode =
      GeneratedColumn<int>(
        'anchor_mode',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<AnchorMode>($RefuelsTable.$converteranchorMode);
  static const VerificationMeta _assumedLeftoverLMeta = const VerificationMeta(
    'assumedLeftoverL',
  );
  @override
  late final GeneratedColumn<double> assumedLeftoverL = GeneratedColumn<double>(
    'assumed_leftover_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    at,
    litres,
    priceTotal,
    pricePerL,
    odometerKm,
    isFull,
    anchorMode,
    assumedLeftoverL,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'refuels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Refuel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('litres')) {
      context.handle(
        _litresMeta,
        litres.isAcceptableOrUnknown(data['litres']!, _litresMeta),
      );
    } else if (isInserting) {
      context.missing(_litresMeta);
    }
    if (data.containsKey('price_total')) {
      context.handle(
        _priceTotalMeta,
        priceTotal.isAcceptableOrUnknown(data['price_total']!, _priceTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_priceTotalMeta);
    }
    if (data.containsKey('price_per_l')) {
      context.handle(
        _pricePerLMeta,
        pricePerL.isAcceptableOrUnknown(data['price_per_l']!, _pricePerLMeta),
      );
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    }
    if (data.containsKey('is_full')) {
      context.handle(
        _isFullMeta,
        isFull.isAcceptableOrUnknown(data['is_full']!, _isFullMeta),
      );
    }
    if (data.containsKey('assumed_leftover_l')) {
      context.handle(
        _assumedLeftoverLMeta,
        assumedLeftoverL.isAcceptableOrUnknown(
          data['assumed_leftover_l']!,
          _assumedLeftoverLMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Refuel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Refuel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $RefuelsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      litres: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}litres'],
      )!,
      priceTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_total'],
      )!,
      pricePerL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_l'],
      ),
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_km'],
      ),
      isFull: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_full'],
      )!,
      anchorMode: $RefuelsTable.$converteranchorMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}anchor_mode'],
        )!,
      ),
      assumedLeftoverL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}assumed_leftover_l'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $RefuelsTable createAlias(String alias) {
    return $RefuelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const EnumIndexConverter<SyncStatus>(SyncStatus.values);
  static JsonTypeConverter2<AnchorMode, int, int> $converteranchorMode =
      const EnumIndexConverter<AnchorMode>(AnchorMode.values);
}

class Refuel extends DataClass implements Insertable<Refuel> {
  /// Client-generated UUID v4. Safe to retry, so a push can be replayed.
  final String id;

  /// Null until the rider signs in with Google, then stamped on every row.
  final String? userId;
  final DateTime createdAt;

  /// UTC, moved on every local change. A push only marks a row synced when this
  /// value is unchanged by the time the server confirms.
  final DateTime updatedAt;

  /// Soft delete. Nothing is ever removed from the local database, so an offline
  /// delete still syncs as a delete.
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final String vehicleId;
  final DateTime at;
  final double litres;
  final double priceTotal;

  /// Nullable: the rider may know the total but not the unit price.
  final double? pricePerL;
  final double? odometerKm;

  /// True when the rider filled the tank completely. Only this case yields an
  /// exact mileage observation.
  final bool isFull;

  /// `reset` assumes [assumedLeftoverL] was already in the tank; `full` sets the
  /// level to tank capacity.
  final AnchorMode anchorMode;

  /// Level assumed to be in the tank before this fill, in `reset` mode.
  final double assumedLeftoverL;
  final String? notes;
  const Refuel({
    required this.id,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.vehicleId,
    required this.at,
    required this.litres,
    required this.priceTotal,
    this.pricePerL,
    this.odometerKm,
    required this.isFull,
    required this.anchorMode,
    required this.assumedLeftoverL,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['sync_status'] = Variable<int>(
        $RefuelsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['at'] = Variable<DateTime>(at);
    map['litres'] = Variable<double>(litres);
    map['price_total'] = Variable<double>(priceTotal);
    if (!nullToAbsent || pricePerL != null) {
      map['price_per_l'] = Variable<double>(pricePerL);
    }
    if (!nullToAbsent || odometerKm != null) {
      map['odometer_km'] = Variable<double>(odometerKm);
    }
    map['is_full'] = Variable<bool>(isFull);
    {
      map['anchor_mode'] = Variable<int>(
        $RefuelsTable.$converteranchorMode.toSql(anchorMode),
      );
    }
    map['assumed_leftover_l'] = Variable<double>(assumedLeftoverL);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  RefuelsCompanion toCompanion(bool nullToAbsent) {
    return RefuelsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      vehicleId: Value(vehicleId),
      at: Value(at),
      litres: Value(litres),
      priceTotal: Value(priceTotal),
      pricePerL: pricePerL == null && nullToAbsent
          ? const Value.absent()
          : Value(pricePerL),
      odometerKm: odometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(odometerKm),
      isFull: Value(isFull),
      anchorMode: Value(anchorMode),
      assumedLeftoverL: Value(assumedLeftoverL),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Refuel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Refuel(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: $RefuelsTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      at: serializer.fromJson<DateTime>(json['at']),
      litres: serializer.fromJson<double>(json['litres']),
      priceTotal: serializer.fromJson<double>(json['priceTotal']),
      pricePerL: serializer.fromJson<double?>(json['pricePerL']),
      odometerKm: serializer.fromJson<double?>(json['odometerKm']),
      isFull: serializer.fromJson<bool>(json['isFull']),
      anchorMode: $RefuelsTable.$converteranchorMode.fromJson(
        serializer.fromJson<int>(json['anchorMode']),
      ),
      assumedLeftoverL: serializer.fromJson<double>(json['assumedLeftoverL']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<int>(
        $RefuelsTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'at': serializer.toJson<DateTime>(at),
      'litres': serializer.toJson<double>(litres),
      'priceTotal': serializer.toJson<double>(priceTotal),
      'pricePerL': serializer.toJson<double?>(pricePerL),
      'odometerKm': serializer.toJson<double?>(odometerKm),
      'isFull': serializer.toJson<bool>(isFull),
      'anchorMode': serializer.toJson<int>(
        $RefuelsTable.$converteranchorMode.toJson(anchorMode),
      ),
      'assumedLeftoverL': serializer.toJson<double>(assumedLeftoverL),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Refuel copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    String? vehicleId,
    DateTime? at,
    double? litres,
    double? priceTotal,
    Value<double?> pricePerL = const Value.absent(),
    Value<double?> odometerKm = const Value.absent(),
    bool? isFull,
    AnchorMode? anchorMode,
    double? assumedLeftoverL,
    Value<String?> notes = const Value.absent(),
  }) => Refuel(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    vehicleId: vehicleId ?? this.vehicleId,
    at: at ?? this.at,
    litres: litres ?? this.litres,
    priceTotal: priceTotal ?? this.priceTotal,
    pricePerL: pricePerL.present ? pricePerL.value : this.pricePerL,
    odometerKm: odometerKm.present ? odometerKm.value : this.odometerKm,
    isFull: isFull ?? this.isFull,
    anchorMode: anchorMode ?? this.anchorMode,
    assumedLeftoverL: assumedLeftoverL ?? this.assumedLeftoverL,
    notes: notes.present ? notes.value : this.notes,
  );
  Refuel copyWithCompanion(RefuelsCompanion data) {
    return Refuel(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      at: data.at.present ? data.at.value : this.at,
      litres: data.litres.present ? data.litres.value : this.litres,
      priceTotal: data.priceTotal.present
          ? data.priceTotal.value
          : this.priceTotal,
      pricePerL: data.pricePerL.present ? data.pricePerL.value : this.pricePerL,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      isFull: data.isFull.present ? data.isFull.value : this.isFull,
      anchorMode: data.anchorMode.present
          ? data.anchorMode.value
          : this.anchorMode,
      assumedLeftoverL: data.assumedLeftoverL.present
          ? data.assumedLeftoverL.value
          : this.assumedLeftoverL,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Refuel(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('at: $at, ')
          ..write('litres: $litres, ')
          ..write('priceTotal: $priceTotal, ')
          ..write('pricePerL: $pricePerL, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('isFull: $isFull, ')
          ..write('anchorMode: $anchorMode, ')
          ..write('assumedLeftoverL: $assumedLeftoverL, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    at,
    litres,
    priceTotal,
    pricePerL,
    odometerKm,
    isFull,
    anchorMode,
    assumedLeftoverL,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Refuel &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.vehicleId == this.vehicleId &&
          other.at == this.at &&
          other.litres == this.litres &&
          other.priceTotal == this.priceTotal &&
          other.pricePerL == this.pricePerL &&
          other.odometerKm == this.odometerKm &&
          other.isFull == this.isFull &&
          other.anchorMode == this.anchorMode &&
          other.assumedLeftoverL == this.assumedLeftoverL &&
          other.notes == this.notes);
}

class RefuelsCompanion extends UpdateCompanion<Refuel> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<String> vehicleId;
  final Value<DateTime> at;
  final Value<double> litres;
  final Value<double> priceTotal;
  final Value<double?> pricePerL;
  final Value<double?> odometerKm;
  final Value<bool> isFull;
  final Value<AnchorMode> anchorMode;
  final Value<double> assumedLeftoverL;
  final Value<String?> notes;
  final Value<int> rowid;
  const RefuelsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.at = const Value.absent(),
    this.litres = const Value.absent(),
    this.priceTotal = const Value.absent(),
    this.pricePerL = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.isFull = const Value.absent(),
    this.anchorMode = const Value.absent(),
    this.assumedLeftoverL = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RefuelsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required String vehicleId,
    required DateTime at,
    required double litres,
    required double priceTotal,
    this.pricePerL = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.isFull = const Value.absent(),
    this.anchorMode = const Value.absent(),
    this.assumedLeftoverL = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       vehicleId = Value(vehicleId),
       at = Value(at),
       litres = Value(litres),
       priceTotal = Value(priceTotal);
  static Insertable<Refuel> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? syncStatus,
    Expression<String>? vehicleId,
    Expression<DateTime>? at,
    Expression<double>? litres,
    Expression<double>? priceTotal,
    Expression<double>? pricePerL,
    Expression<double>? odometerKm,
    Expression<bool>? isFull,
    Expression<int>? anchorMode,
    Expression<double>? assumedLeftoverL,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (at != null) 'at': at,
      if (litres != null) 'litres': litres,
      if (priceTotal != null) 'price_total': priceTotal,
      if (pricePerL != null) 'price_per_l': pricePerL,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (isFull != null) 'is_full': isFull,
      if (anchorMode != null) 'anchor_mode': anchorMode,
      if (assumedLeftoverL != null) 'assumed_leftover_l': assumedLeftoverL,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RefuelsCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<String>? vehicleId,
    Value<DateTime>? at,
    Value<double>? litres,
    Value<double>? priceTotal,
    Value<double?>? pricePerL,
    Value<double?>? odometerKm,
    Value<bool>? isFull,
    Value<AnchorMode>? anchorMode,
    Value<double>? assumedLeftoverL,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return RefuelsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      vehicleId: vehicleId ?? this.vehicleId,
      at: at ?? this.at,
      litres: litres ?? this.litres,
      priceTotal: priceTotal ?? this.priceTotal,
      pricePerL: pricePerL ?? this.pricePerL,
      odometerKm: odometerKm ?? this.odometerKm,
      isFull: isFull ?? this.isFull,
      anchorMode: anchorMode ?? this.anchorMode,
      assumedLeftoverL: assumedLeftoverL ?? this.assumedLeftoverL,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $RefuelsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (litres.present) {
      map['litres'] = Variable<double>(litres.value);
    }
    if (priceTotal.present) {
      map['price_total'] = Variable<double>(priceTotal.value);
    }
    if (pricePerL.present) {
      map['price_per_l'] = Variable<double>(pricePerL.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<double>(odometerKm.value);
    }
    if (isFull.present) {
      map['is_full'] = Variable<bool>(isFull.value);
    }
    if (anchorMode.present) {
      map['anchor_mode'] = Variable<int>(
        $RefuelsTable.$converteranchorMode.toSql(anchorMode.value),
      );
    }
    if (assumedLeftoverL.present) {
      map['assumed_leftover_l'] = Variable<double>(assumedLeftoverL.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RefuelsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('at: $at, ')
          ..write('litres: $litres, ')
          ..write('priceTotal: $priceTotal, ')
          ..write('pricePerL: $pricePerL, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('isFull: $isFull, ')
          ..write('anchorMode: $anchorMode, ')
          ..write('assumedLeftoverL: $assumedLeftoverL, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FuelEventsTable extends FuelEvents
    with TableInfo<$FuelEventsTable, FuelEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SyncStatus>($FuelEventsTable.$convertersyncStatus);
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FuelEventKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<FuelEventKind>($FuelEventsTable.$converterkind);
  static const VerificationMeta _levelLMeta = const VerificationMeta('levelL');
  @override
  late final GeneratedColumn<double> levelL = GeneratedColumn<double>(
    'level_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    at,
    kind,
    levelL,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('level_l')) {
      context.handle(
        _levelLMeta,
        levelL.isAcceptableOrUnknown(data['level_l']!, _levelLMeta),
      );
    } else if (isInserting) {
      context.missing(_levelLMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $FuelEventsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      kind: $FuelEventsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      levelL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}level_l'],
      )!,
    );
  }

  @override
  $FuelEventsTable createAlias(String alias) {
    return $FuelEventsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const EnumIndexConverter<SyncStatus>(SyncStatus.values);
  static JsonTypeConverter2<FuelEventKind, int, int> $converterkind =
      const EnumIndexConverter<FuelEventKind>(FuelEventKind.values);
}

class FuelEvent extends DataClass implements Insertable<FuelEvent> {
  /// Client-generated UUID v4. Safe to retry, so a push can be replayed.
  final String id;

  /// Null until the rider signs in with Google, then stamped on every row.
  final String? userId;
  final DateTime createdAt;

  /// UTC, moved on every local change. A push only marks a row synced when this
  /// value is unchanged by the time the server confirms.
  final DateTime updatedAt;

  /// Soft delete. Nothing is ever removed from the local database, so an offline
  /// delete still syncs as a delete.
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final String vehicleId;
  final DateTime at;
  final FuelEventKind kind;

  /// The level this event asserts. Stored as well as derived, so a later change
  /// to the vehicle's reserve does not rewrite history.
  final double levelL;
  const FuelEvent({
    required this.id,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.vehicleId,
    required this.at,
    required this.kind,
    required this.levelL,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['sync_status'] = Variable<int>(
        $FuelEventsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['at'] = Variable<DateTime>(at);
    {
      map['kind'] = Variable<int>($FuelEventsTable.$converterkind.toSql(kind));
    }
    map['level_l'] = Variable<double>(levelL);
    return map;
  }

  FuelEventsCompanion toCompanion(bool nullToAbsent) {
    return FuelEventsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      vehicleId: Value(vehicleId),
      at: Value(at),
      kind: Value(kind),
      levelL: Value(levelL),
    );
  }

  factory FuelEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelEvent(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: $FuelEventsTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      at: serializer.fromJson<DateTime>(json['at']),
      kind: $FuelEventsTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      levelL: serializer.fromJson<double>(json['levelL']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<int>(
        $FuelEventsTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'at': serializer.toJson<DateTime>(at),
      'kind': serializer.toJson<int>(
        $FuelEventsTable.$converterkind.toJson(kind),
      ),
      'levelL': serializer.toJson<double>(levelL),
    };
  }

  FuelEvent copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    String? vehicleId,
    DateTime? at,
    FuelEventKind? kind,
    double? levelL,
  }) => FuelEvent(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    vehicleId: vehicleId ?? this.vehicleId,
    at: at ?? this.at,
    kind: kind ?? this.kind,
    levelL: levelL ?? this.levelL,
  );
  FuelEvent copyWithCompanion(FuelEventsCompanion data) {
    return FuelEvent(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      at: data.at.present ? data.at.value : this.at,
      kind: data.kind.present ? data.kind.value : this.kind,
      levelL: data.levelL.present ? data.levelL.value : this.levelL,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelEvent(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('at: $at, ')
          ..write('kind: $kind, ')
          ..write('levelL: $levelL')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    at,
    kind,
    levelL,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelEvent &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.vehicleId == this.vehicleId &&
          other.at == this.at &&
          other.kind == this.kind &&
          other.levelL == this.levelL);
}

class FuelEventsCompanion extends UpdateCompanion<FuelEvent> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<String> vehicleId;
  final Value<DateTime> at;
  final Value<FuelEventKind> kind;
  final Value<double> levelL;
  final Value<int> rowid;
  const FuelEventsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.at = const Value.absent(),
    this.kind = const Value.absent(),
    this.levelL = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FuelEventsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required String vehicleId,
    required DateTime at,
    required FuelEventKind kind,
    required double levelL,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       vehicleId = Value(vehicleId),
       at = Value(at),
       kind = Value(kind),
       levelL = Value(levelL);
  static Insertable<FuelEvent> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? syncStatus,
    Expression<String>? vehicleId,
    Expression<DateTime>? at,
    Expression<int>? kind,
    Expression<double>? levelL,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (at != null) 'at': at,
      if (kind != null) 'kind': kind,
      if (levelL != null) 'level_l': levelL,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FuelEventsCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<String>? vehicleId,
    Value<DateTime>? at,
    Value<FuelEventKind>? kind,
    Value<double>? levelL,
    Value<int>? rowid,
  }) {
    return FuelEventsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      vehicleId: vehicleId ?? this.vehicleId,
      at: at ?? this.at,
      kind: kind ?? this.kind,
      levelL: levelL ?? this.levelL,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $FuelEventsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $FuelEventsTable.$converterkind.toSql(kind.value),
      );
    }
    if (levelL.present) {
      map['level_l'] = Variable<double>(levelL.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelEventsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('at: $at, ')
          ..write('kind: $kind, ')
          ..write('levelL: $levelL, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TripsTable extends Trips with TableInfo<$TripsTable, Trip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SyncStatus>($TripsTable.$convertersyncStatus);
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TripStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TripStatus>($TripsTable.$converterstatus);
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawDistanceKmMeta = const VerificationMeta(
    'rawDistanceKm',
  );
  @override
  late final GeneratedColumn<double> rawDistanceKm = GeneratedColumn<double>(
    'raw_distance_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _durationSMeta = const VerificationMeta(
    'durationS',
  );
  @override
  late final GeneratedColumn<int> durationS = GeneratedColumn<int>(
    'duration_s',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _movingSMeta = const VerificationMeta(
    'movingS',
  );
  @override
  late final GeneratedColumn<int> movingS = GeneratedColumn<int>(
    'moving_s',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _idleSMeta = const VerificationMeta('idleS');
  @override
  late final GeneratedColumn<int> idleS = GeneratedColumn<int>(
    'idle_s',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avgSpeedKmhMeta = const VerificationMeta(
    'avgSpeedKmh',
  );
  @override
  late final GeneratedColumn<double> avgSpeedKmh = GeneratedColumn<double>(
    'avg_speed_kmh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _maxSpeedKmhMeta = const VerificationMeta(
    'maxSpeedKmh',
  );
  @override
  late final GeneratedColumn<double> maxSpeedKmh = GeneratedColumn<double>(
    'max_speed_kmh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _elevationGainMMeta = const VerificationMeta(
    'elevationGainM',
  );
  @override
  late final GeneratedColumn<double> elevationGainM = GeneratedColumn<double>(
    'elevation_gain_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startLatMeta = const VerificationMeta(
    'startLat',
  );
  @override
  late final GeneratedColumn<double> startLat = GeneratedColumn<double>(
    'start_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startLngMeta = const VerificationMeta(
    'startLng',
  );
  @override
  late final GeneratedColumn<double> startLng = GeneratedColumn<double>(
    'start_lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endLatMeta = const VerificationMeta('endLat');
  @override
  late final GeneratedColumn<double> endLat = GeneratedColumn<double>(
    'end_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endLngMeta = const VerificationMeta('endLng');
  @override
  late final GeneratedColumn<double> endLng = GeneratedColumn<double>(
    'end_lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routeGzMeta = const VerificationMeta(
    'routeGz',
  );
  @override
  late final GeneratedColumn<Uint8List> routeGz = GeneratedColumn<Uint8List>(
    'route_gz',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    status,
    startedAt,
    endedAt,
    rawDistanceKm,
    durationS,
    movingS,
    idleS,
    avgSpeedKmh,
    maxSpeedKmh,
    elevationGainM,
    startLat,
    startLng,
    endLat,
    endLng,
    title,
    notes,
    routeGz,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trip> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('raw_distance_km')) {
      context.handle(
        _rawDistanceKmMeta,
        rawDistanceKm.isAcceptableOrUnknown(
          data['raw_distance_km']!,
          _rawDistanceKmMeta,
        ),
      );
    }
    if (data.containsKey('duration_s')) {
      context.handle(
        _durationSMeta,
        durationS.isAcceptableOrUnknown(data['duration_s']!, _durationSMeta),
      );
    }
    if (data.containsKey('moving_s')) {
      context.handle(
        _movingSMeta,
        movingS.isAcceptableOrUnknown(data['moving_s']!, _movingSMeta),
      );
    }
    if (data.containsKey('idle_s')) {
      context.handle(
        _idleSMeta,
        idleS.isAcceptableOrUnknown(data['idle_s']!, _idleSMeta),
      );
    }
    if (data.containsKey('avg_speed_kmh')) {
      context.handle(
        _avgSpeedKmhMeta,
        avgSpeedKmh.isAcceptableOrUnknown(
          data['avg_speed_kmh']!,
          _avgSpeedKmhMeta,
        ),
      );
    }
    if (data.containsKey('max_speed_kmh')) {
      context.handle(
        _maxSpeedKmhMeta,
        maxSpeedKmh.isAcceptableOrUnknown(
          data['max_speed_kmh']!,
          _maxSpeedKmhMeta,
        ),
      );
    }
    if (data.containsKey('elevation_gain_m')) {
      context.handle(
        _elevationGainMMeta,
        elevationGainM.isAcceptableOrUnknown(
          data['elevation_gain_m']!,
          _elevationGainMMeta,
        ),
      );
    }
    if (data.containsKey('start_lat')) {
      context.handle(
        _startLatMeta,
        startLat.isAcceptableOrUnknown(data['start_lat']!, _startLatMeta),
      );
    }
    if (data.containsKey('start_lng')) {
      context.handle(
        _startLngMeta,
        startLng.isAcceptableOrUnknown(data['start_lng']!, _startLngMeta),
      );
    }
    if (data.containsKey('end_lat')) {
      context.handle(
        _endLatMeta,
        endLat.isAcceptableOrUnknown(data['end_lat']!, _endLatMeta),
      );
    }
    if (data.containsKey('end_lng')) {
      context.handle(
        _endLngMeta,
        endLng.isAcceptableOrUnknown(data['end_lng']!, _endLngMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('route_gz')) {
      context.handle(
        _routeGzMeta,
        routeGz.isAcceptableOrUnknown(data['route_gz']!, _routeGzMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trip(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $TripsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      status: $TripsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      rawDistanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_distance_km'],
      )!,
      durationS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_s'],
      )!,
      movingS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}moving_s'],
      )!,
      idleS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}idle_s'],
      )!,
      avgSpeedKmh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_speed_kmh'],
      )!,
      maxSpeedKmh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_speed_kmh'],
      )!,
      elevationGainM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elevation_gain_m'],
      ),
      startLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_lat'],
      ),
      startLng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_lng'],
      ),
      endLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_lat'],
      ),
      endLng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_lng'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      routeGz: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}route_gz'],
      ),
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const EnumIndexConverter<SyncStatus>(SyncStatus.values);
  static JsonTypeConverter2<TripStatus, int, int> $converterstatus =
      const EnumIndexConverter<TripStatus>(TripStatus.values);
}

class Trip extends DataClass implements Insertable<Trip> {
  /// Client-generated UUID v4. Safe to retry, so a push can be replayed.
  final String id;

  /// Null until the rider signs in with Google, then stamped on every row.
  final String? userId;
  final DateTime createdAt;

  /// UTC, moved on every local change. A push only marks a row synced when this
  /// value is unchanged by the time the server confirms.
  final DateTime updatedAt;

  /// Soft delete. Nothing is ever removed from the local database, so an offline
  /// delete still syncs as a delete.
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final String vehicleId;

  /// `recording` while live, `completed` once saved, `interrupted` if the
  /// process died mid-ride.
  final TripStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
  final double rawDistanceKm;
  final int durationS;
  final int movingS;
  final int idleS;
  final double avgSpeedKmh;
  final double maxSpeedKmh;

  /// Informational only. GPS altitude is too noisy to be load-bearing.
  final double? elevationGainM;
  final double? startLat;
  final double? startLng;
  final double? endLat;
  final double? endLng;
  final String? title;
  final String? notes;

  /// Gzipped JSON polyline, built when the trip completes. This is what goes to
  /// the server: the `trip_points` rows stay on the phone.
  final Uint8List? routeGz;
  const Trip({
    required this.id,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.vehicleId,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required this.rawDistanceKm,
    required this.durationS,
    required this.movingS,
    required this.idleS,
    required this.avgSpeedKmh,
    required this.maxSpeedKmh,
    this.elevationGainM,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    this.title,
    this.notes,
    this.routeGz,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['sync_status'] = Variable<int>(
        $TripsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['vehicle_id'] = Variable<String>(vehicleId);
    {
      map['status'] = Variable<int>($TripsTable.$converterstatus.toSql(status));
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['raw_distance_km'] = Variable<double>(rawDistanceKm);
    map['duration_s'] = Variable<int>(durationS);
    map['moving_s'] = Variable<int>(movingS);
    map['idle_s'] = Variable<int>(idleS);
    map['avg_speed_kmh'] = Variable<double>(avgSpeedKmh);
    map['max_speed_kmh'] = Variable<double>(maxSpeedKmh);
    if (!nullToAbsent || elevationGainM != null) {
      map['elevation_gain_m'] = Variable<double>(elevationGainM);
    }
    if (!nullToAbsent || startLat != null) {
      map['start_lat'] = Variable<double>(startLat);
    }
    if (!nullToAbsent || startLng != null) {
      map['start_lng'] = Variable<double>(startLng);
    }
    if (!nullToAbsent || endLat != null) {
      map['end_lat'] = Variable<double>(endLat);
    }
    if (!nullToAbsent || endLng != null) {
      map['end_lng'] = Variable<double>(endLng);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || routeGz != null) {
      map['route_gz'] = Variable<Uint8List>(routeGz);
    }
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      vehicleId: Value(vehicleId),
      status: Value(status),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      rawDistanceKm: Value(rawDistanceKm),
      durationS: Value(durationS),
      movingS: Value(movingS),
      idleS: Value(idleS),
      avgSpeedKmh: Value(avgSpeedKmh),
      maxSpeedKmh: Value(maxSpeedKmh),
      elevationGainM: elevationGainM == null && nullToAbsent
          ? const Value.absent()
          : Value(elevationGainM),
      startLat: startLat == null && nullToAbsent
          ? const Value.absent()
          : Value(startLat),
      startLng: startLng == null && nullToAbsent
          ? const Value.absent()
          : Value(startLng),
      endLat: endLat == null && nullToAbsent
          ? const Value.absent()
          : Value(endLat),
      endLng: endLng == null && nullToAbsent
          ? const Value.absent()
          : Value(endLng),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      routeGz: routeGz == null && nullToAbsent
          ? const Value.absent()
          : Value(routeGz),
    );
  }

  factory Trip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: $TripsTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      status: $TripsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      rawDistanceKm: serializer.fromJson<double>(json['rawDistanceKm']),
      durationS: serializer.fromJson<int>(json['durationS']),
      movingS: serializer.fromJson<int>(json['movingS']),
      idleS: serializer.fromJson<int>(json['idleS']),
      avgSpeedKmh: serializer.fromJson<double>(json['avgSpeedKmh']),
      maxSpeedKmh: serializer.fromJson<double>(json['maxSpeedKmh']),
      elevationGainM: serializer.fromJson<double?>(json['elevationGainM']),
      startLat: serializer.fromJson<double?>(json['startLat']),
      startLng: serializer.fromJson<double?>(json['startLng']),
      endLat: serializer.fromJson<double?>(json['endLat']),
      endLng: serializer.fromJson<double?>(json['endLng']),
      title: serializer.fromJson<String?>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      routeGz: serializer.fromJson<Uint8List?>(json['routeGz']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<int>(
        $TripsTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'status': serializer.toJson<int>(
        $TripsTable.$converterstatus.toJson(status),
      ),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'rawDistanceKm': serializer.toJson<double>(rawDistanceKm),
      'durationS': serializer.toJson<int>(durationS),
      'movingS': serializer.toJson<int>(movingS),
      'idleS': serializer.toJson<int>(idleS),
      'avgSpeedKmh': serializer.toJson<double>(avgSpeedKmh),
      'maxSpeedKmh': serializer.toJson<double>(maxSpeedKmh),
      'elevationGainM': serializer.toJson<double?>(elevationGainM),
      'startLat': serializer.toJson<double?>(startLat),
      'startLng': serializer.toJson<double?>(startLng),
      'endLat': serializer.toJson<double?>(endLat),
      'endLng': serializer.toJson<double?>(endLng),
      'title': serializer.toJson<String?>(title),
      'notes': serializer.toJson<String?>(notes),
      'routeGz': serializer.toJson<Uint8List?>(routeGz),
    };
  }

  Trip copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    String? vehicleId,
    TripStatus? status,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    double? rawDistanceKm,
    int? durationS,
    int? movingS,
    int? idleS,
    double? avgSpeedKmh,
    double? maxSpeedKmh,
    Value<double?> elevationGainM = const Value.absent(),
    Value<double?> startLat = const Value.absent(),
    Value<double?> startLng = const Value.absent(),
    Value<double?> endLat = const Value.absent(),
    Value<double?> endLng = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<Uint8List?> routeGz = const Value.absent(),
  }) => Trip(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    vehicleId: vehicleId ?? this.vehicleId,
    status: status ?? this.status,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    rawDistanceKm: rawDistanceKm ?? this.rawDistanceKm,
    durationS: durationS ?? this.durationS,
    movingS: movingS ?? this.movingS,
    idleS: idleS ?? this.idleS,
    avgSpeedKmh: avgSpeedKmh ?? this.avgSpeedKmh,
    maxSpeedKmh: maxSpeedKmh ?? this.maxSpeedKmh,
    elevationGainM: elevationGainM.present
        ? elevationGainM.value
        : this.elevationGainM,
    startLat: startLat.present ? startLat.value : this.startLat,
    startLng: startLng.present ? startLng.value : this.startLng,
    endLat: endLat.present ? endLat.value : this.endLat,
    endLng: endLng.present ? endLng.value : this.endLng,
    title: title.present ? title.value : this.title,
    notes: notes.present ? notes.value : this.notes,
    routeGz: routeGz.present ? routeGz.value : this.routeGz,
  );
  Trip copyWithCompanion(TripsCompanion data) {
    return Trip(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      rawDistanceKm: data.rawDistanceKm.present
          ? data.rawDistanceKm.value
          : this.rawDistanceKm,
      durationS: data.durationS.present ? data.durationS.value : this.durationS,
      movingS: data.movingS.present ? data.movingS.value : this.movingS,
      idleS: data.idleS.present ? data.idleS.value : this.idleS,
      avgSpeedKmh: data.avgSpeedKmh.present
          ? data.avgSpeedKmh.value
          : this.avgSpeedKmh,
      maxSpeedKmh: data.maxSpeedKmh.present
          ? data.maxSpeedKmh.value
          : this.maxSpeedKmh,
      elevationGainM: data.elevationGainM.present
          ? data.elevationGainM.value
          : this.elevationGainM,
      startLat: data.startLat.present ? data.startLat.value : this.startLat,
      startLng: data.startLng.present ? data.startLng.value : this.startLng,
      endLat: data.endLat.present ? data.endLat.value : this.endLat,
      endLng: data.endLng.present ? data.endLng.value : this.endLng,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      routeGz: data.routeGz.present ? data.routeGz.value : this.routeGz,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rawDistanceKm: $rawDistanceKm, ')
          ..write('durationS: $durationS, ')
          ..write('movingS: $movingS, ')
          ..write('idleS: $idleS, ')
          ..write('avgSpeedKmh: $avgSpeedKmh, ')
          ..write('maxSpeedKmh: $maxSpeedKmh, ')
          ..write('elevationGainM: $elevationGainM, ')
          ..write('startLat: $startLat, ')
          ..write('startLng: $startLng, ')
          ..write('endLat: $endLat, ')
          ..write('endLng: $endLng, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('routeGz: $routeGz')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    status,
    startedAt,
    endedAt,
    rawDistanceKm,
    durationS,
    movingS,
    idleS,
    avgSpeedKmh,
    maxSpeedKmh,
    elevationGainM,
    startLat,
    startLng,
    endLat,
    endLng,
    title,
    notes,
    $driftBlobEquality.hash(routeGz),
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trip &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.vehicleId == this.vehicleId &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.rawDistanceKm == this.rawDistanceKm &&
          other.durationS == this.durationS &&
          other.movingS == this.movingS &&
          other.idleS == this.idleS &&
          other.avgSpeedKmh == this.avgSpeedKmh &&
          other.maxSpeedKmh == this.maxSpeedKmh &&
          other.elevationGainM == this.elevationGainM &&
          other.startLat == this.startLat &&
          other.startLng == this.startLng &&
          other.endLat == this.endLat &&
          other.endLng == this.endLng &&
          other.title == this.title &&
          other.notes == this.notes &&
          $driftBlobEquality.equals(other.routeGz, this.routeGz));
}

class TripsCompanion extends UpdateCompanion<Trip> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<String> vehicleId;
  final Value<TripStatus> status;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<double> rawDistanceKm;
  final Value<int> durationS;
  final Value<int> movingS;
  final Value<int> idleS;
  final Value<double> avgSpeedKmh;
  final Value<double> maxSpeedKmh;
  final Value<double?> elevationGainM;
  final Value<double?> startLat;
  final Value<double?> startLng;
  final Value<double?> endLat;
  final Value<double?> endLng;
  final Value<String?> title;
  final Value<String?> notes;
  final Value<Uint8List?> routeGz;
  final Value<int> rowid;
  const TripsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.rawDistanceKm = const Value.absent(),
    this.durationS = const Value.absent(),
    this.movingS = const Value.absent(),
    this.idleS = const Value.absent(),
    this.avgSpeedKmh = const Value.absent(),
    this.maxSpeedKmh = const Value.absent(),
    this.elevationGainM = const Value.absent(),
    this.startLat = const Value.absent(),
    this.startLng = const Value.absent(),
    this.endLat = const Value.absent(),
    this.endLng = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.routeGz = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TripsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required String vehicleId,
    required TripStatus status,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.rawDistanceKm = const Value.absent(),
    this.durationS = const Value.absent(),
    this.movingS = const Value.absent(),
    this.idleS = const Value.absent(),
    this.avgSpeedKmh = const Value.absent(),
    this.maxSpeedKmh = const Value.absent(),
    this.elevationGainM = const Value.absent(),
    this.startLat = const Value.absent(),
    this.startLng = const Value.absent(),
    this.endLat = const Value.absent(),
    this.endLng = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.routeGz = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       vehicleId = Value(vehicleId),
       status = Value(status),
       startedAt = Value(startedAt);
  static Insertable<Trip> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? syncStatus,
    Expression<String>? vehicleId,
    Expression<int>? status,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<double>? rawDistanceKm,
    Expression<int>? durationS,
    Expression<int>? movingS,
    Expression<int>? idleS,
    Expression<double>? avgSpeedKmh,
    Expression<double>? maxSpeedKmh,
    Expression<double>? elevationGainM,
    Expression<double>? startLat,
    Expression<double>? startLng,
    Expression<double>? endLat,
    Expression<double>? endLng,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<Uint8List>? routeGz,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (rawDistanceKm != null) 'raw_distance_km': rawDistanceKm,
      if (durationS != null) 'duration_s': durationS,
      if (movingS != null) 'moving_s': movingS,
      if (idleS != null) 'idle_s': idleS,
      if (avgSpeedKmh != null) 'avg_speed_kmh': avgSpeedKmh,
      if (maxSpeedKmh != null) 'max_speed_kmh': maxSpeedKmh,
      if (elevationGainM != null) 'elevation_gain_m': elevationGainM,
      if (startLat != null) 'start_lat': startLat,
      if (startLng != null) 'start_lng': startLng,
      if (endLat != null) 'end_lat': endLat,
      if (endLng != null) 'end_lng': endLng,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (routeGz != null) 'route_gz': routeGz,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripsCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<String>? vehicleId,
    Value<TripStatus>? status,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<double>? rawDistanceKm,
    Value<int>? durationS,
    Value<int>? movingS,
    Value<int>? idleS,
    Value<double>? avgSpeedKmh,
    Value<double>? maxSpeedKmh,
    Value<double?>? elevationGainM,
    Value<double?>? startLat,
    Value<double?>? startLng,
    Value<double?>? endLat,
    Value<double?>? endLng,
    Value<String?>? title,
    Value<String?>? notes,
    Value<Uint8List?>? routeGz,
    Value<int>? rowid,
  }) {
    return TripsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      vehicleId: vehicleId ?? this.vehicleId,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      rawDistanceKm: rawDistanceKm ?? this.rawDistanceKm,
      durationS: durationS ?? this.durationS,
      movingS: movingS ?? this.movingS,
      idleS: idleS ?? this.idleS,
      avgSpeedKmh: avgSpeedKmh ?? this.avgSpeedKmh,
      maxSpeedKmh: maxSpeedKmh ?? this.maxSpeedKmh,
      elevationGainM: elevationGainM ?? this.elevationGainM,
      startLat: startLat ?? this.startLat,
      startLng: startLng ?? this.startLng,
      endLat: endLat ?? this.endLat,
      endLng: endLng ?? this.endLng,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      routeGz: routeGz ?? this.routeGz,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $TripsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $TripsTable.$converterstatus.toSql(status.value),
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (rawDistanceKm.present) {
      map['raw_distance_km'] = Variable<double>(rawDistanceKm.value);
    }
    if (durationS.present) {
      map['duration_s'] = Variable<int>(durationS.value);
    }
    if (movingS.present) {
      map['moving_s'] = Variable<int>(movingS.value);
    }
    if (idleS.present) {
      map['idle_s'] = Variable<int>(idleS.value);
    }
    if (avgSpeedKmh.present) {
      map['avg_speed_kmh'] = Variable<double>(avgSpeedKmh.value);
    }
    if (maxSpeedKmh.present) {
      map['max_speed_kmh'] = Variable<double>(maxSpeedKmh.value);
    }
    if (elevationGainM.present) {
      map['elevation_gain_m'] = Variable<double>(elevationGainM.value);
    }
    if (startLat.present) {
      map['start_lat'] = Variable<double>(startLat.value);
    }
    if (startLng.present) {
      map['start_lng'] = Variable<double>(startLng.value);
    }
    if (endLat.present) {
      map['end_lat'] = Variable<double>(endLat.value);
    }
    if (endLng.present) {
      map['end_lng'] = Variable<double>(endLng.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (routeGz.present) {
      map['route_gz'] = Variable<Uint8List>(routeGz.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rawDistanceKm: $rawDistanceKm, ')
          ..write('durationS: $durationS, ')
          ..write('movingS: $movingS, ')
          ..write('idleS: $idleS, ')
          ..write('avgSpeedKmh: $avgSpeedKmh, ')
          ..write('maxSpeedKmh: $maxSpeedKmh, ')
          ..write('elevationGainM: $elevationGainM, ')
          ..write('startLat: $startLat, ')
          ..write('startLng: $startLng, ')
          ..write('endLat: $endLat, ')
          ..write('endLng: $endLng, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('routeGz: $routeGz, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TripPointsTable extends TripPoints
    with TableInfo<$TripPointsTable, TripPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id)',
    ),
  );
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tsMeta = const VerificationMeta('ts');
  @override
  late final GeneratedColumn<DateTime> ts = GeneratedColumn<DateTime>(
    'ts',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMMeta = const VerificationMeta(
    'altitudeM',
  );
  @override
  late final GeneratedColumn<double> altitudeM = GeneratedColumn<double>(
    'altitude_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speedMpsMeta = const VerificationMeta(
    'speedMps',
  );
  @override
  late final GeneratedColumn<double> speedMps = GeneratedColumn<double>(
    'speed_mps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _accuracyMMeta = const VerificationMeta(
    'accuracyM',
  );
  @override
  late final GeneratedColumn<double> accuracyM = GeneratedColumn<double>(
    'accuracy_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isMovingMeta = const VerificationMeta(
    'isMoving',
  );
  @override
  late final GeneratedColumn<bool> isMoving = GeneratedColumn<bool>(
    'is_moving',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_moving" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    seq,
    ts,
    lat,
    lng,
    altitudeM,
    speedMps,
    accuracyM,
    isMoving,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trip_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<TripPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('ts')) {
      context.handle(_tsMeta, ts.isAcceptableOrUnknown(data['ts']!, _tsMeta));
    } else if (isInserting) {
      context.missing(_tsMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('altitude_m')) {
      context.handle(
        _altitudeMMeta,
        altitudeM.isAcceptableOrUnknown(data['altitude_m']!, _altitudeMMeta),
      );
    }
    if (data.containsKey('speed_mps')) {
      context.handle(
        _speedMpsMeta,
        speedMps.isAcceptableOrUnknown(data['speed_mps']!, _speedMpsMeta),
      );
    }
    if (data.containsKey('accuracy_m')) {
      context.handle(
        _accuracyMMeta,
        accuracyM.isAcceptableOrUnknown(data['accuracy_m']!, _accuracyMMeta),
      );
    }
    if (data.containsKey('is_moving')) {
      context.handle(
        _isMovingMeta,
        isMoving.isAcceptableOrUnknown(data['is_moving']!, _isMovingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TripPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      )!,
      ts: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ts'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      )!,
      altitudeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_m'],
      ),
      speedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_mps'],
      )!,
      accuracyM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_m'],
      )!,
      isMoving: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_moving'],
      )!,
    );
  }

  @override
  $TripPointsTable createAlias(String alias) {
    return $TripPointsTable(attachedDatabase, alias);
  }
}

class TripPoint extends DataClass implements Insertable<TripPoint> {
  final int id;
  final String tripId;

  /// Position within the track, so ordering survives a delete/re-insert.
  final int seq;
  final DateTime ts;
  final double lat;
  final double lng;
  final double? altitudeM;
  final double speedMps;
  final double accuracyM;
  final bool isMoving;
  const TripPoint({
    required this.id,
    required this.tripId,
    required this.seq,
    required this.ts,
    required this.lat,
    required this.lng,
    this.altitudeM,
    required this.speedMps,
    required this.accuracyM,
    required this.isMoving,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<String>(tripId);
    map['seq'] = Variable<int>(seq);
    map['ts'] = Variable<DateTime>(ts);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    if (!nullToAbsent || altitudeM != null) {
      map['altitude_m'] = Variable<double>(altitudeM);
    }
    map['speed_mps'] = Variable<double>(speedMps);
    map['accuracy_m'] = Variable<double>(accuracyM);
    map['is_moving'] = Variable<bool>(isMoving);
    return map;
  }

  TripPointsCompanion toCompanion(bool nullToAbsent) {
    return TripPointsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      seq: Value(seq),
      ts: Value(ts),
      lat: Value(lat),
      lng: Value(lng),
      altitudeM: altitudeM == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeM),
      speedMps: Value(speedMps),
      accuracyM: Value(accuracyM),
      isMoving: Value(isMoving),
    );
  }

  factory TripPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripPoint(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      seq: serializer.fromJson<int>(json['seq']),
      ts: serializer.fromJson<DateTime>(json['ts']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      altitudeM: serializer.fromJson<double?>(json['altitudeM']),
      speedMps: serializer.fromJson<double>(json['speedMps']),
      accuracyM: serializer.fromJson<double>(json['accuracyM']),
      isMoving: serializer.fromJson<bool>(json['isMoving']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<String>(tripId),
      'seq': serializer.toJson<int>(seq),
      'ts': serializer.toJson<DateTime>(ts),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'altitudeM': serializer.toJson<double?>(altitudeM),
      'speedMps': serializer.toJson<double>(speedMps),
      'accuracyM': serializer.toJson<double>(accuracyM),
      'isMoving': serializer.toJson<bool>(isMoving),
    };
  }

  TripPoint copyWith({
    int? id,
    String? tripId,
    int? seq,
    DateTime? ts,
    double? lat,
    double? lng,
    Value<double?> altitudeM = const Value.absent(),
    double? speedMps,
    double? accuracyM,
    bool? isMoving,
  }) => TripPoint(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    seq: seq ?? this.seq,
    ts: ts ?? this.ts,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    altitudeM: altitudeM.present ? altitudeM.value : this.altitudeM,
    speedMps: speedMps ?? this.speedMps,
    accuracyM: accuracyM ?? this.accuracyM,
    isMoving: isMoving ?? this.isMoving,
  );
  TripPoint copyWithCompanion(TripPointsCompanion data) {
    return TripPoint(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      seq: data.seq.present ? data.seq.value : this.seq,
      ts: data.ts.present ? data.ts.value : this.ts,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      altitudeM: data.altitudeM.present ? data.altitudeM.value : this.altitudeM,
      speedMps: data.speedMps.present ? data.speedMps.value : this.speedMps,
      accuracyM: data.accuracyM.present ? data.accuracyM.value : this.accuracyM,
      isMoving: data.isMoving.present ? data.isMoving.value : this.isMoving,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripPoint(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('seq: $seq, ')
          ..write('ts: $ts, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('speedMps: $speedMps, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('isMoving: $isMoving')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    seq,
    ts,
    lat,
    lng,
    altitudeM,
    speedMps,
    accuracyM,
    isMoving,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripPoint &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.seq == this.seq &&
          other.ts == this.ts &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.altitudeM == this.altitudeM &&
          other.speedMps == this.speedMps &&
          other.accuracyM == this.accuracyM &&
          other.isMoving == this.isMoving);
}

class TripPointsCompanion extends UpdateCompanion<TripPoint> {
  final Value<int> id;
  final Value<String> tripId;
  final Value<int> seq;
  final Value<DateTime> ts;
  final Value<double> lat;
  final Value<double> lng;
  final Value<double?> altitudeM;
  final Value<double> speedMps;
  final Value<double> accuracyM;
  final Value<bool> isMoving;
  const TripPointsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.seq = const Value.absent(),
    this.ts = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.speedMps = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.isMoving = const Value.absent(),
  });
  TripPointsCompanion.insert({
    this.id = const Value.absent(),
    required String tripId,
    required int seq,
    required DateTime ts,
    required double lat,
    required double lng,
    this.altitudeM = const Value.absent(),
    this.speedMps = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.isMoving = const Value.absent(),
  }) : tripId = Value(tripId),
       seq = Value(seq),
       ts = Value(ts),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<TripPoint> custom({
    Expression<int>? id,
    Expression<String>? tripId,
    Expression<int>? seq,
    Expression<DateTime>? ts,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<double>? altitudeM,
    Expression<double>? speedMps,
    Expression<double>? accuracyM,
    Expression<bool>? isMoving,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (seq != null) 'seq': seq,
      if (ts != null) 'ts': ts,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (altitudeM != null) 'altitude_m': altitudeM,
      if (speedMps != null) 'speed_mps': speedMps,
      if (accuracyM != null) 'accuracy_m': accuracyM,
      if (isMoving != null) 'is_moving': isMoving,
    });
  }

  TripPointsCompanion copyWith({
    Value<int>? id,
    Value<String>? tripId,
    Value<int>? seq,
    Value<DateTime>? ts,
    Value<double>? lat,
    Value<double>? lng,
    Value<double?>? altitudeM,
    Value<double>? speedMps,
    Value<double>? accuracyM,
    Value<bool>? isMoving,
  }) {
    return TripPointsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      seq: seq ?? this.seq,
      ts: ts ?? this.ts,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      altitudeM: altitudeM ?? this.altitudeM,
      speedMps: speedMps ?? this.speedMps,
      accuracyM: accuracyM ?? this.accuracyM,
      isMoving: isMoving ?? this.isMoving,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (ts.present) {
      map['ts'] = Variable<DateTime>(ts.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (altitudeM.present) {
      map['altitude_m'] = Variable<double>(altitudeM.value);
    }
    if (speedMps.present) {
      map['speed_mps'] = Variable<double>(speedMps.value);
    }
    if (accuracyM.present) {
      map['accuracy_m'] = Variable<double>(accuracyM.value);
    }
    if (isMoving.present) {
      map['is_moving'] = Variable<bool>(isMoving.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripPointsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('seq: $seq, ')
          ..write('ts: $ts, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('speedMps: $speedMps, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('isMoving: $isMoving')
          ..write(')'))
        .toString();
  }
}

class $OdometerChecksTable extends OdometerChecks
    with TableInfo<$OdometerChecksTable, OdometerCheck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OdometerChecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SyncStatus>($OdometerChecksTable.$convertersyncStatus);
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<double> odometerKm = GeneratedColumn<double>(
    'odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpsKmSinceLastMeta = const VerificationMeta(
    'gpsKmSinceLast',
  );
  @override
  late final GeneratedColumn<double> gpsKmSinceLast = GeneratedColumn<double>(
    'gps_km_since_last',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _factorSampleMeta = const VerificationMeta(
    'factorSample',
  );
  @override
  late final GeneratedColumn<double> factorSample = GeneratedColumn<double>(
    'factor_sample',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    at,
    odometerKm,
    gpsKmSinceLast,
    factorSample,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'odometer_checks';
  @override
  VerificationContext validateIntegrity(
    Insertable<OdometerCheck> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('gps_km_since_last')) {
      context.handle(
        _gpsKmSinceLastMeta,
        gpsKmSinceLast.isAcceptableOrUnknown(
          data['gps_km_since_last']!,
          _gpsKmSinceLastMeta,
        ),
      );
    }
    if (data.containsKey('factor_sample')) {
      context.handle(
        _factorSampleMeta,
        factorSample.isAcceptableOrUnknown(
          data['factor_sample']!,
          _factorSampleMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OdometerCheck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OdometerCheck(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $OdometerChecksTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_km'],
      )!,
      gpsKmSinceLast: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_km_since_last'],
      ),
      factorSample: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}factor_sample'],
      ),
    );
  }

  @override
  $OdometerChecksTable createAlias(String alias) {
    return $OdometerChecksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const EnumIndexConverter<SyncStatus>(SyncStatus.values);
}

class OdometerCheck extends DataClass implements Insertable<OdometerCheck> {
  /// Client-generated UUID v4. Safe to retry, so a push can be replayed.
  final String id;

  /// Null until the rider signs in with Google, then stamped on every row.
  final String? userId;
  final DateTime createdAt;

  /// UTC, moved on every local change. A push only marks a row synced when this
  /// value is unchanged by the time the server confirms.
  final DateTime updatedAt;

  /// Soft delete. Nothing is ever removed from the local database, so an offline
  /// delete still syncs as a delete.
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final String vehicleId;
  final DateTime at;
  final double odometerKm;

  /// Raw GPS distance since the previous check. Null for the very first check.
  final double? gpsKmSinceLast;

  /// `real / gps` at the time of the check. Null when there was too little GPS to
  /// compare against.
  final double? factorSample;
  const OdometerCheck({
    required this.id,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.vehicleId,
    required this.at,
    required this.odometerKm,
    this.gpsKmSinceLast,
    this.factorSample,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['sync_status'] = Variable<int>(
        $OdometerChecksTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['at'] = Variable<DateTime>(at);
    map['odometer_km'] = Variable<double>(odometerKm);
    if (!nullToAbsent || gpsKmSinceLast != null) {
      map['gps_km_since_last'] = Variable<double>(gpsKmSinceLast);
    }
    if (!nullToAbsent || factorSample != null) {
      map['factor_sample'] = Variable<double>(factorSample);
    }
    return map;
  }

  OdometerChecksCompanion toCompanion(bool nullToAbsent) {
    return OdometerChecksCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      vehicleId: Value(vehicleId),
      at: Value(at),
      odometerKm: Value(odometerKm),
      gpsKmSinceLast: gpsKmSinceLast == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsKmSinceLast),
      factorSample: factorSample == null && nullToAbsent
          ? const Value.absent()
          : Value(factorSample),
    );
  }

  factory OdometerCheck.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OdometerCheck(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: $OdometerChecksTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      at: serializer.fromJson<DateTime>(json['at']),
      odometerKm: serializer.fromJson<double>(json['odometerKm']),
      gpsKmSinceLast: serializer.fromJson<double?>(json['gpsKmSinceLast']),
      factorSample: serializer.fromJson<double?>(json['factorSample']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<int>(
        $OdometerChecksTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'at': serializer.toJson<DateTime>(at),
      'odometerKm': serializer.toJson<double>(odometerKm),
      'gpsKmSinceLast': serializer.toJson<double?>(gpsKmSinceLast),
      'factorSample': serializer.toJson<double?>(factorSample),
    };
  }

  OdometerCheck copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    String? vehicleId,
    DateTime? at,
    double? odometerKm,
    Value<double?> gpsKmSinceLast = const Value.absent(),
    Value<double?> factorSample = const Value.absent(),
  }) => OdometerCheck(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    vehicleId: vehicleId ?? this.vehicleId,
    at: at ?? this.at,
    odometerKm: odometerKm ?? this.odometerKm,
    gpsKmSinceLast: gpsKmSinceLast.present
        ? gpsKmSinceLast.value
        : this.gpsKmSinceLast,
    factorSample: factorSample.present ? factorSample.value : this.factorSample,
  );
  OdometerCheck copyWithCompanion(OdometerChecksCompanion data) {
    return OdometerCheck(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      at: data.at.present ? data.at.value : this.at,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      gpsKmSinceLast: data.gpsKmSinceLast.present
          ? data.gpsKmSinceLast.value
          : this.gpsKmSinceLast,
      factorSample: data.factorSample.present
          ? data.factorSample.value
          : this.factorSample,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OdometerCheck(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('at: $at, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('gpsKmSinceLast: $gpsKmSinceLast, ')
          ..write('factorSample: $factorSample')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    at,
    odometerKm,
    gpsKmSinceLast,
    factorSample,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OdometerCheck &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.vehicleId == this.vehicleId &&
          other.at == this.at &&
          other.odometerKm == this.odometerKm &&
          other.gpsKmSinceLast == this.gpsKmSinceLast &&
          other.factorSample == this.factorSample);
}

class OdometerChecksCompanion extends UpdateCompanion<OdometerCheck> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<String> vehicleId;
  final Value<DateTime> at;
  final Value<double> odometerKm;
  final Value<double?> gpsKmSinceLast;
  final Value<double?> factorSample;
  final Value<int> rowid;
  const OdometerChecksCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.at = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.gpsKmSinceLast = const Value.absent(),
    this.factorSample = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OdometerChecksCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required String vehicleId,
    required DateTime at,
    required double odometerKm,
    this.gpsKmSinceLast = const Value.absent(),
    this.factorSample = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       vehicleId = Value(vehicleId),
       at = Value(at),
       odometerKm = Value(odometerKm);
  static Insertable<OdometerCheck> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? syncStatus,
    Expression<String>? vehicleId,
    Expression<DateTime>? at,
    Expression<double>? odometerKm,
    Expression<double>? gpsKmSinceLast,
    Expression<double>? factorSample,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (at != null) 'at': at,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (gpsKmSinceLast != null) 'gps_km_since_last': gpsKmSinceLast,
      if (factorSample != null) 'factor_sample': factorSample,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OdometerChecksCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<String>? vehicleId,
    Value<DateTime>? at,
    Value<double>? odometerKm,
    Value<double?>? gpsKmSinceLast,
    Value<double?>? factorSample,
    Value<int>? rowid,
  }) {
    return OdometerChecksCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      vehicleId: vehicleId ?? this.vehicleId,
      at: at ?? this.at,
      odometerKm: odometerKm ?? this.odometerKm,
      gpsKmSinceLast: gpsKmSinceLast ?? this.gpsKmSinceLast,
      factorSample: factorSample ?? this.factorSample,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $OdometerChecksTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<double>(odometerKm.value);
    }
    if (gpsKmSinceLast.present) {
      map['gps_km_since_last'] = Variable<double>(gpsKmSinceLast.value);
    }
    if (factorSample.present) {
      map['factor_sample'] = Variable<double>(factorSample.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OdometerChecksCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('at: $at, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('gpsKmSinceLast: $gpsKmSinceLast, ')
          ..write('factorSample: $factorSample, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SyncStatus>($RemindersTable.$convertersyncStatus);
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReminderKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ReminderKind>($RemindersTable.$converterkind);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueKmMeta = const VerificationMeta('dueKm');
  @override
  late final GeneratedColumn<double> dueKm = GeneratedColumn<double>(
    'due_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalKmMeta = const VerificationMeta(
    'intervalKm',
  );
  @override
  late final GeneratedColumn<double> intervalKm = GeneratedColumn<double>(
    'interval_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastDoneKmMeta = const VerificationMeta(
    'lastDoneKm',
  );
  @override
  late final GeneratedColumn<double> lastDoneKm = GeneratedColumn<double>(
    'last_done_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastDoneDateMeta = const VerificationMeta(
    'lastDoneDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastDoneDate = GeneratedColumn<DateTime>(
    'last_done_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notifyBeforeKmMeta = const VerificationMeta(
    'notifyBeforeKm',
  );
  @override
  late final GeneratedColumn<double> notifyBeforeKm = GeneratedColumn<double>(
    'notify_before_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notifyBeforeDaysMeta = const VerificationMeta(
    'notifyBeforeDays',
  );
  @override
  late final GeneratedColumn<int> notifyBeforeDays = GeneratedColumn<int>(
    'notify_before_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    kind,
    title,
    dueKm,
    dueDate,
    intervalKm,
    intervalDays,
    lastDoneKm,
    lastDoneDate,
    notifyBeforeKm,
    notifyBeforeDays,
    notes,
    iconCodePoint,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_km')) {
      context.handle(
        _dueKmMeta,
        dueKm.isAcceptableOrUnknown(data['due_km']!, _dueKmMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('interval_km')) {
      context.handle(
        _intervalKmMeta,
        intervalKm.isAcceptableOrUnknown(data['interval_km']!, _intervalKmMeta),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('last_done_km')) {
      context.handle(
        _lastDoneKmMeta,
        lastDoneKm.isAcceptableOrUnknown(
          data['last_done_km']!,
          _lastDoneKmMeta,
        ),
      );
    }
    if (data.containsKey('last_done_date')) {
      context.handle(
        _lastDoneDateMeta,
        lastDoneDate.isAcceptableOrUnknown(
          data['last_done_date']!,
          _lastDoneDateMeta,
        ),
      );
    }
    if (data.containsKey('notify_before_km')) {
      context.handle(
        _notifyBeforeKmMeta,
        notifyBeforeKm.isAcceptableOrUnknown(
          data['notify_before_km']!,
          _notifyBeforeKmMeta,
        ),
      );
    }
    if (data.containsKey('notify_before_days')) {
      context.handle(
        _notifyBeforeDaysMeta,
        notifyBeforeDays.isAcceptableOrUnknown(
          data['notify_before_days']!,
          _notifyBeforeDaysMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $RemindersTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      kind: $RemindersTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      dueKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}due_km'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      intervalKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interval_km'],
      ),
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      ),
      lastDoneKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_done_km'],
      ),
      lastDoneDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_done_date'],
      ),
      notifyBeforeKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}notify_before_km'],
      ),
      notifyBeforeDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notify_before_days'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      ),
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const EnumIndexConverter<SyncStatus>(SyncStatus.values);
  static JsonTypeConverter2<ReminderKind, int, int> $converterkind =
      const EnumIndexConverter<ReminderKind>(ReminderKind.values);
}

class Reminder extends DataClass implements Insertable<Reminder> {
  /// Client-generated UUID v4. Safe to retry, so a push can be replayed.
  final String id;

  /// Null until the rider signs in with Google, then stamped on every row.
  final String? userId;
  final DateTime createdAt;

  /// UTC, moved on every local change. A push only marks a row synced when this
  /// value is unchanged by the time the server confirms.
  final DateTime updatedAt;

  /// Soft delete. Nothing is ever removed from the local database, so an offline
  /// delete still syncs as a delete.
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final String vehicleId;
  final ReminderKind kind;
  final String title;

  /// Service only: absolute odometer at which this falls due.
  final double? dueKm;

  /// Document only.
  final DateTime? dueDate;

  /// Auto-reschedule interval after being marked done.
  final double? intervalKm;
  final int? intervalDays;
  final double? lastDoneKm;
  final DateTime? lastDoneDate;

  /// How early to warn. A service defaults to 500 km, a document to 7 days.
  final double? notifyBeforeKm;
  final int? notifyBeforeDays;
  final String? notes;
  final int? iconCodePoint;
  const Reminder({
    required this.id,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.vehicleId,
    required this.kind,
    required this.title,
    this.dueKm,
    this.dueDate,
    this.intervalKm,
    this.intervalDays,
    this.lastDoneKm,
    this.lastDoneDate,
    this.notifyBeforeKm,
    this.notifyBeforeDays,
    this.notes,
    this.iconCodePoint,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['sync_status'] = Variable<int>(
        $RemindersTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['vehicle_id'] = Variable<String>(vehicleId);
    {
      map['kind'] = Variable<int>($RemindersTable.$converterkind.toSql(kind));
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || dueKm != null) {
      map['due_km'] = Variable<double>(dueKm);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || intervalKm != null) {
      map['interval_km'] = Variable<double>(intervalKm);
    }
    if (!nullToAbsent || intervalDays != null) {
      map['interval_days'] = Variable<int>(intervalDays);
    }
    if (!nullToAbsent || lastDoneKm != null) {
      map['last_done_km'] = Variable<double>(lastDoneKm);
    }
    if (!nullToAbsent || lastDoneDate != null) {
      map['last_done_date'] = Variable<DateTime>(lastDoneDate);
    }
    if (!nullToAbsent || notifyBeforeKm != null) {
      map['notify_before_km'] = Variable<double>(notifyBeforeKm);
    }
    if (!nullToAbsent || notifyBeforeDays != null) {
      map['notify_before_days'] = Variable<int>(notifyBeforeDays);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || iconCodePoint != null) {
      map['icon_code_point'] = Variable<int>(iconCodePoint);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      vehicleId: Value(vehicleId),
      kind: Value(kind),
      title: Value(title),
      dueKm: dueKm == null && nullToAbsent
          ? const Value.absent()
          : Value(dueKm),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      intervalKm: intervalKm == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalKm),
      intervalDays: intervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalDays),
      lastDoneKm: lastDoneKm == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDoneKm),
      lastDoneDate: lastDoneDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDoneDate),
      notifyBeforeKm: notifyBeforeKm == null && nullToAbsent
          ? const Value.absent()
          : Value(notifyBeforeKm),
      notifyBeforeDays: notifyBeforeDays == null && nullToAbsent
          ? const Value.absent()
          : Value(notifyBeforeDays),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      iconCodePoint: iconCodePoint == null && nullToAbsent
          ? const Value.absent()
          : Value(iconCodePoint),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: $RemindersTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      kind: $RemindersTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      title: serializer.fromJson<String>(json['title']),
      dueKm: serializer.fromJson<double?>(json['dueKm']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      intervalKm: serializer.fromJson<double?>(json['intervalKm']),
      intervalDays: serializer.fromJson<int?>(json['intervalDays']),
      lastDoneKm: serializer.fromJson<double?>(json['lastDoneKm']),
      lastDoneDate: serializer.fromJson<DateTime?>(json['lastDoneDate']),
      notifyBeforeKm: serializer.fromJson<double?>(json['notifyBeforeKm']),
      notifyBeforeDays: serializer.fromJson<int?>(json['notifyBeforeDays']),
      notes: serializer.fromJson<String?>(json['notes']),
      iconCodePoint: serializer.fromJson<int?>(json['iconCodePoint']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<int>(
        $RemindersTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'kind': serializer.toJson<int>(
        $RemindersTable.$converterkind.toJson(kind),
      ),
      'title': serializer.toJson<String>(title),
      'dueKm': serializer.toJson<double?>(dueKm),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'intervalKm': serializer.toJson<double?>(intervalKm),
      'intervalDays': serializer.toJson<int?>(intervalDays),
      'lastDoneKm': serializer.toJson<double?>(lastDoneKm),
      'lastDoneDate': serializer.toJson<DateTime?>(lastDoneDate),
      'notifyBeforeKm': serializer.toJson<double?>(notifyBeforeKm),
      'notifyBeforeDays': serializer.toJson<int?>(notifyBeforeDays),
      'notes': serializer.toJson<String?>(notes),
      'iconCodePoint': serializer.toJson<int?>(iconCodePoint),
    };
  }

  Reminder copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    String? vehicleId,
    ReminderKind? kind,
    String? title,
    Value<double?> dueKm = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    Value<double?> intervalKm = const Value.absent(),
    Value<int?> intervalDays = const Value.absent(),
    Value<double?> lastDoneKm = const Value.absent(),
    Value<DateTime?> lastDoneDate = const Value.absent(),
    Value<double?> notifyBeforeKm = const Value.absent(),
    Value<int?> notifyBeforeDays = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<int?> iconCodePoint = const Value.absent(),
  }) => Reminder(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    vehicleId: vehicleId ?? this.vehicleId,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    dueKm: dueKm.present ? dueKm.value : this.dueKm,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    intervalKm: intervalKm.present ? intervalKm.value : this.intervalKm,
    intervalDays: intervalDays.present ? intervalDays.value : this.intervalDays,
    lastDoneKm: lastDoneKm.present ? lastDoneKm.value : this.lastDoneKm,
    lastDoneDate: lastDoneDate.present ? lastDoneDate.value : this.lastDoneDate,
    notifyBeforeKm: notifyBeforeKm.present
        ? notifyBeforeKm.value
        : this.notifyBeforeKm,
    notifyBeforeDays: notifyBeforeDays.present
        ? notifyBeforeDays.value
        : this.notifyBeforeDays,
    notes: notes.present ? notes.value : this.notes,
    iconCodePoint: iconCodePoint.present
        ? iconCodePoint.value
        : this.iconCodePoint,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      dueKm: data.dueKm.present ? data.dueKm.value : this.dueKm,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      intervalKm: data.intervalKm.present
          ? data.intervalKm.value
          : this.intervalKm,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      lastDoneKm: data.lastDoneKm.present
          ? data.lastDoneKm.value
          : this.lastDoneKm,
      lastDoneDate: data.lastDoneDate.present
          ? data.lastDoneDate.value
          : this.lastDoneDate,
      notifyBeforeKm: data.notifyBeforeKm.present
          ? data.notifyBeforeKm.value
          : this.notifyBeforeKm,
      notifyBeforeDays: data.notifyBeforeDays.present
          ? data.notifyBeforeDays.value
          : this.notifyBeforeDays,
      notes: data.notes.present ? data.notes.value : this.notes,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('dueKm: $dueKm, ')
          ..write('dueDate: $dueDate, ')
          ..write('intervalKm: $intervalKm, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('lastDoneKm: $lastDoneKm, ')
          ..write('lastDoneDate: $lastDoneDate, ')
          ..write('notifyBeforeKm: $notifyBeforeKm, ')
          ..write('notifyBeforeDays: $notifyBeforeDays, ')
          ..write('notes: $notes, ')
          ..write('iconCodePoint: $iconCodePoint')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    vehicleId,
    kind,
    title,
    dueKm,
    dueDate,
    intervalKm,
    intervalDays,
    lastDoneKm,
    lastDoneDate,
    notifyBeforeKm,
    notifyBeforeDays,
    notes,
    iconCodePoint,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.vehicleId == this.vehicleId &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.dueKm == this.dueKm &&
          other.dueDate == this.dueDate &&
          other.intervalKm == this.intervalKm &&
          other.intervalDays == this.intervalDays &&
          other.lastDoneKm == this.lastDoneKm &&
          other.lastDoneDate == this.lastDoneDate &&
          other.notifyBeforeKm == this.notifyBeforeKm &&
          other.notifyBeforeDays == this.notifyBeforeDays &&
          other.notes == this.notes &&
          other.iconCodePoint == this.iconCodePoint);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<String> vehicleId;
  final Value<ReminderKind> kind;
  final Value<String> title;
  final Value<double?> dueKm;
  final Value<DateTime?> dueDate;
  final Value<double?> intervalKm;
  final Value<int?> intervalDays;
  final Value<double?> lastDoneKm;
  final Value<DateTime?> lastDoneDate;
  final Value<double?> notifyBeforeKm;
  final Value<int?> notifyBeforeDays;
  final Value<String?> notes;
  final Value<int?> iconCodePoint;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.dueKm = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.intervalKm = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.lastDoneKm = const Value.absent(),
    this.lastDoneDate = const Value.absent(),
    this.notifyBeforeKm = const Value.absent(),
    this.notifyBeforeDays = const Value.absent(),
    this.notes = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required String vehicleId,
    required ReminderKind kind,
    required String title,
    this.dueKm = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.intervalKm = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.lastDoneKm = const Value.absent(),
    this.lastDoneDate = const Value.absent(),
    this.notifyBeforeKm = const Value.absent(),
    this.notifyBeforeDays = const Value.absent(),
    this.notes = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       vehicleId = Value(vehicleId),
       kind = Value(kind),
       title = Value(title);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? syncStatus,
    Expression<String>? vehicleId,
    Expression<int>? kind,
    Expression<String>? title,
    Expression<double>? dueKm,
    Expression<DateTime>? dueDate,
    Expression<double>? intervalKm,
    Expression<int>? intervalDays,
    Expression<double>? lastDoneKm,
    Expression<DateTime>? lastDoneDate,
    Expression<double>? notifyBeforeKm,
    Expression<int>? notifyBeforeDays,
    Expression<String>? notes,
    Expression<int>? iconCodePoint,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (dueKm != null) 'due_km': dueKm,
      if (dueDate != null) 'due_date': dueDate,
      if (intervalKm != null) 'interval_km': intervalKm,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (lastDoneKm != null) 'last_done_km': lastDoneKm,
      if (lastDoneDate != null) 'last_done_date': lastDoneDate,
      if (notifyBeforeKm != null) 'notify_before_km': notifyBeforeKm,
      if (notifyBeforeDays != null) 'notify_before_days': notifyBeforeDays,
      if (notes != null) 'notes': notes,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<String>? vehicleId,
    Value<ReminderKind>? kind,
    Value<String>? title,
    Value<double?>? dueKm,
    Value<DateTime?>? dueDate,
    Value<double?>? intervalKm,
    Value<int?>? intervalDays,
    Value<double?>? lastDoneKm,
    Value<DateTime?>? lastDoneDate,
    Value<double?>? notifyBeforeKm,
    Value<int?>? notifyBeforeDays,
    Value<String?>? notes,
    Value<int?>? iconCodePoint,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      vehicleId: vehicleId ?? this.vehicleId,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      dueKm: dueKm ?? this.dueKm,
      dueDate: dueDate ?? this.dueDate,
      intervalKm: intervalKm ?? this.intervalKm,
      intervalDays: intervalDays ?? this.intervalDays,
      lastDoneKm: lastDoneKm ?? this.lastDoneKm,
      lastDoneDate: lastDoneDate ?? this.lastDoneDate,
      notifyBeforeKm: notifyBeforeKm ?? this.notifyBeforeKm,
      notifyBeforeDays: notifyBeforeDays ?? this.notifyBeforeDays,
      notes: notes ?? this.notes,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $RemindersTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $RemindersTable.$converterkind.toSql(kind.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueKm.present) {
      map['due_km'] = Variable<double>(dueKm.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (intervalKm.present) {
      map['interval_km'] = Variable<double>(intervalKm.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (lastDoneKm.present) {
      map['last_done_km'] = Variable<double>(lastDoneKm.value);
    }
    if (lastDoneDate.present) {
      map['last_done_date'] = Variable<DateTime>(lastDoneDate.value);
    }
    if (notifyBeforeKm.present) {
      map['notify_before_km'] = Variable<double>(notifyBeforeKm.value);
    }
    if (notifyBeforeDays.present) {
      map['notify_before_days'] = Variable<int>(notifyBeforeDays.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('dueKm: $dueKm, ')
          ..write('dueDate: $dueDate, ')
          ..write('intervalKm: $intervalKm, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('lastDoneKm: $lastDoneKm, ')
          ..write('lastDoneDate: $lastDoneDate, ')
          ..write('notifyBeforeKm: $notifyBeforeKm, ')
          ..write('notifyBeforeDays: $notifyBeforeDays, ')
          ..write('notes: $notes, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStatesTable extends SyncStates
    with TableInfo<$SyncStatesTable, SyncState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastPulledAtMeta = const VerificationMeta(
    'lastPulledAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPulledAt = GeneratedColumn<DateTime>(
    'last_pulled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastPushAtMeta = const VerificationMeta(
    'lastPushAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPushAt = GeneratedColumn<DateTime>(
    'last_push_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorAtMeta = const VerificationMeta(
    'lastErrorAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastErrorAt = GeneratedColumn<DateTime>(
    'last_error_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lastPulledAt,
    lastPushAt,
    lastError,
    lastErrorAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_pulled_at')) {
      context.handle(
        _lastPulledAtMeta,
        lastPulledAt.isAcceptableOrUnknown(
          data['last_pulled_at']!,
          _lastPulledAtMeta,
        ),
      );
    }
    if (data.containsKey('last_push_at')) {
      context.handle(
        _lastPushAtMeta,
        lastPushAt.isAcceptableOrUnknown(
          data['last_push_at']!,
          _lastPushAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('last_error_at')) {
      context.handle(
        _lastErrorAtMeta,
        lastErrorAt.isAcceptableOrUnknown(
          data['last_error_at']!,
          _lastErrorAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SyncState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastPulledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_pulled_at'],
      ),
      lastPushAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_push_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      lastErrorAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_error_at'],
      ),
    );
  }

  @override
  $SyncStatesTable createAlias(String alias) {
    return $SyncStatesTable(attachedDatabase, alias);
  }
}

class SyncState extends DataClass implements Insertable<SyncState> {
  final int id;
  final DateTime? lastPulledAt;
  final DateTime? lastPushAt;

  /// Last failure, so the settings screen can say why sync stopped instead of
  /// showing a silent spinner forever.
  final String? lastError;
  final DateTime? lastErrorAt;
  const SyncState({
    required this.id,
    this.lastPulledAt,
    this.lastPushAt,
    this.lastError,
    this.lastErrorAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastPulledAt != null) {
      map['last_pulled_at'] = Variable<DateTime>(lastPulledAt);
    }
    if (!nullToAbsent || lastPushAt != null) {
      map['last_push_at'] = Variable<DateTime>(lastPushAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || lastErrorAt != null) {
      map['last_error_at'] = Variable<DateTime>(lastErrorAt);
    }
    return map;
  }

  SyncStatesCompanion toCompanion(bool nullToAbsent) {
    return SyncStatesCompanion(
      id: Value(id),
      lastPulledAt: lastPulledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPulledAt),
      lastPushAt: lastPushAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPushAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      lastErrorAt: lastErrorAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorAt),
    );
  }

  factory SyncState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncState(
      id: serializer.fromJson<int>(json['id']),
      lastPulledAt: serializer.fromJson<DateTime?>(json['lastPulledAt']),
      lastPushAt: serializer.fromJson<DateTime?>(json['lastPushAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      lastErrorAt: serializer.fromJson<DateTime?>(json['lastErrorAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastPulledAt': serializer.toJson<DateTime?>(lastPulledAt),
      'lastPushAt': serializer.toJson<DateTime?>(lastPushAt),
      'lastError': serializer.toJson<String?>(lastError),
      'lastErrorAt': serializer.toJson<DateTime?>(lastErrorAt),
    };
  }

  SyncState copyWith({
    int? id,
    Value<DateTime?> lastPulledAt = const Value.absent(),
    Value<DateTime?> lastPushAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> lastErrorAt = const Value.absent(),
  }) => SyncState(
    id: id ?? this.id,
    lastPulledAt: lastPulledAt.present ? lastPulledAt.value : this.lastPulledAt,
    lastPushAt: lastPushAt.present ? lastPushAt.value : this.lastPushAt,
    lastError: lastError.present ? lastError.value : this.lastError,
    lastErrorAt: lastErrorAt.present ? lastErrorAt.value : this.lastErrorAt,
  );
  SyncState copyWithCompanion(SyncStatesCompanion data) {
    return SyncState(
      id: data.id.present ? data.id.value : this.id,
      lastPulledAt: data.lastPulledAt.present
          ? data.lastPulledAt.value
          : this.lastPulledAt,
      lastPushAt: data.lastPushAt.present
          ? data.lastPushAt.value
          : this.lastPushAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      lastErrorAt: data.lastErrorAt.present
          ? data.lastErrorAt.value
          : this.lastErrorAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncState(')
          ..write('id: $id, ')
          ..write('lastPulledAt: $lastPulledAt, ')
          ..write('lastPushAt: $lastPushAt, ')
          ..write('lastError: $lastError, ')
          ..write('lastErrorAt: $lastErrorAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, lastPulledAt, lastPushAt, lastError, lastErrorAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncState &&
          other.id == this.id &&
          other.lastPulledAt == this.lastPulledAt &&
          other.lastPushAt == this.lastPushAt &&
          other.lastError == this.lastError &&
          other.lastErrorAt == this.lastErrorAt);
}

class SyncStatesCompanion extends UpdateCompanion<SyncState> {
  final Value<int> id;
  final Value<DateTime?> lastPulledAt;
  final Value<DateTime?> lastPushAt;
  final Value<String?> lastError;
  final Value<DateTime?> lastErrorAt;
  final Value<int> rowid;
  const SyncStatesCompanion({
    this.id = const Value.absent(),
    this.lastPulledAt = const Value.absent(),
    this.lastPushAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastErrorAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStatesCompanion.insert({
    this.id = const Value.absent(),
    this.lastPulledAt = const Value.absent(),
    this.lastPushAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastErrorAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<SyncState> custom({
    Expression<int>? id,
    Expression<DateTime>? lastPulledAt,
    Expression<DateTime>? lastPushAt,
    Expression<String>? lastError,
    Expression<DateTime>? lastErrorAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastPulledAt != null) 'last_pulled_at': lastPulledAt,
      if (lastPushAt != null) 'last_push_at': lastPushAt,
      if (lastError != null) 'last_error': lastError,
      if (lastErrorAt != null) 'last_error_at': lastErrorAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStatesCompanion copyWith({
    Value<int>? id,
    Value<DateTime?>? lastPulledAt,
    Value<DateTime?>? lastPushAt,
    Value<String?>? lastError,
    Value<DateTime?>? lastErrorAt,
    Value<int>? rowid,
  }) {
    return SyncStatesCompanion(
      id: id ?? this.id,
      lastPulledAt: lastPulledAt ?? this.lastPulledAt,
      lastPushAt: lastPushAt ?? this.lastPushAt,
      lastError: lastError ?? this.lastError,
      lastErrorAt: lastErrorAt ?? this.lastErrorAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastPulledAt.present) {
      map['last_pulled_at'] = Variable<DateTime>(lastPulledAt.value);
    }
    if (lastPushAt.present) {
      map['last_push_at'] = Variable<DateTime>(lastPushAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (lastErrorAt.present) {
      map['last_error_at'] = Variable<DateTime>(lastErrorAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatesCompanion(')
          ..write('id: $id, ')
          ..write('lastPulledAt: $lastPulledAt, ')
          ..write('lastPushAt: $lastPushAt, ')
          ..write('lastError: $lastError, ')
          ..write('lastErrorAt: $lastErrorAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  /// The setting name, e.g. `distance_unit` or `onboarding_complete`.
  final String key;

  /// Value as JSON text, so a bool, number and list all fit one column.
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $RefuelsTable refuels = $RefuelsTable(this);
  late final $FuelEventsTable fuelEvents = $FuelEventsTable(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $TripPointsTable tripPoints = $TripPointsTable(this);
  late final $OdometerChecksTable odometerChecks = $OdometerChecksTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $SyncStatesTable syncStates = $SyncStatesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vehicles,
    refuels,
    fuelEvents,
    trips,
    tripPoints,
    odometerChecks,
    reminders,
    syncStates,
    appSettings,
  ];
}

typedef $$VehiclesTableCreateCompanionBuilder =
    VehiclesCompanion Function({
      required String id,
      Value<String?> userId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      required String name,
      Value<double> tankCapacityL,
      Value<double> reserveL,
      Value<double> defaultMileageKmpl,
      Value<double?> learnedMileageKmpl,
      Value<double> distanceFactor,
      Value<double> safetyFactor,
      Value<double> lowFuelThresholdL,
      Value<double> odometerStartKm,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$VehiclesTableUpdateCompanionBuilder =
    VehiclesCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<String> name,
      Value<double> tankCapacityL,
      Value<double> reserveL,
      Value<double> defaultMileageKmpl,
      Value<double?> learnedMileageKmpl,
      Value<double> distanceFactor,
      Value<double> safetyFactor,
      Value<double> lowFuelThresholdL,
      Value<double> odometerStartKm,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RefuelsTable, List<Refuel>> _refuelsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.refuels,
    aliasName: 'vehicles__id__refuels__vehicle_id',
  );

  $$RefuelsTableProcessedTableManager get refuelsRefs {
    final manager = $$RefuelsTableTableManager(
      $_db,
      $_db.refuels,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_refuelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FuelEventsTable, List<FuelEvent>>
  _fuelEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelEvents,
    aliasName: 'vehicles__id__fuel_events__vehicle_id',
  );

  $$FuelEventsTableProcessedTableManager get fuelEventsRefs {
    final manager = $$FuelEventsTableTableManager(
      $_db,
      $_db.fuelEvents,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TripsTable, List<Trip>> _tripsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.trips,
    aliasName: 'vehicles__id__trips__vehicle_id',
  );

  $$TripsTableProcessedTableManager get tripsRefs {
    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tripsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OdometerChecksTable, List<OdometerCheck>>
  _odometerChecksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.odometerChecks,
    aliasName: 'vehicles__id__odometer_checks__vehicle_id',
  );

  $$OdometerChecksTableProcessedTableManager get odometerChecksRefs {
    final manager = $$OdometerChecksTableTableManager(
      $_db,
      $_db.odometerChecks,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_odometerChecksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<Reminder>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'vehicles__id__reminders__vehicle_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tankCapacityL => $composableBuilder(
    column: $table.tankCapacityL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reserveL => $composableBuilder(
    column: $table.reserveL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultMileageKmpl => $composableBuilder(
    column: $table.defaultMileageKmpl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get learnedMileageKmpl => $composableBuilder(
    column: $table.learnedMileageKmpl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceFactor => $composableBuilder(
    column: $table.distanceFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get safetyFactor => $composableBuilder(
    column: $table.safetyFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lowFuelThresholdL => $composableBuilder(
    column: $table.lowFuelThresholdL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerStartKm => $composableBuilder(
    column: $table.odometerStartKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> refuelsRefs(
    Expression<bool> Function($$RefuelsTableFilterComposer f) f,
  ) {
    final $$RefuelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.refuels,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RefuelsTableFilterComposer(
            $db: $db,
            $table: $db.refuels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fuelEventsRefs(
    Expression<bool> Function($$FuelEventsTableFilterComposer f) f,
  ) {
    final $$FuelEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEvents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEventsTableFilterComposer(
            $db: $db,
            $table: $db.fuelEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tripsRefs(
    Expression<bool> Function($$TripsTableFilterComposer f) f,
  ) {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> odometerChecksRefs(
    Expression<bool> Function($$OdometerChecksTableFilterComposer f) f,
  ) {
    final $$OdometerChecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.odometerChecks,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OdometerChecksTableFilterComposer(
            $db: $db,
            $table: $db.odometerChecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tankCapacityL => $composableBuilder(
    column: $table.tankCapacityL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reserveL => $composableBuilder(
    column: $table.reserveL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultMileageKmpl => $composableBuilder(
    column: $table.defaultMileageKmpl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get learnedMileageKmpl => $composableBuilder(
    column: $table.learnedMileageKmpl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceFactor => $composableBuilder(
    column: $table.distanceFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get safetyFactor => $composableBuilder(
    column: $table.safetyFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lowFuelThresholdL => $composableBuilder(
    column: $table.lowFuelThresholdL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerStartKm => $composableBuilder(
    column: $table.odometerStartKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get tankCapacityL => $composableBuilder(
    column: $table.tankCapacityL,
    builder: (column) => column,
  );

  GeneratedColumn<double> get reserveL =>
      $composableBuilder(column: $table.reserveL, builder: (column) => column);

  GeneratedColumn<double> get defaultMileageKmpl => $composableBuilder(
    column: $table.defaultMileageKmpl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get learnedMileageKmpl => $composableBuilder(
    column: $table.learnedMileageKmpl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceFactor => $composableBuilder(
    column: $table.distanceFactor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get safetyFactor => $composableBuilder(
    column: $table.safetyFactor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lowFuelThresholdL => $composableBuilder(
    column: $table.lowFuelThresholdL,
    builder: (column) => column,
  );

  GeneratedColumn<double> get odometerStartKm => $composableBuilder(
    column: $table.odometerStartKm,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> refuelsRefs<T extends Object>(
    Expression<T> Function($$RefuelsTableAnnotationComposer a) f,
  ) {
    final $$RefuelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.refuels,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RefuelsTableAnnotationComposer(
            $db: $db,
            $table: $db.refuels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fuelEventsRefs<T extends Object>(
    Expression<T> Function($$FuelEventsTableAnnotationComposer a) f,
  ) {
    final $$FuelEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEvents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tripsRefs<T extends Object>(
    Expression<T> Function($$TripsTableAnnotationComposer a) f,
  ) {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> odometerChecksRefs<T extends Object>(
    Expression<T> Function($$OdometerChecksTableAnnotationComposer a) f,
  ) {
    final $$OdometerChecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.odometerChecks,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OdometerChecksTableAnnotationComposer(
            $db: $db,
            $table: $db.odometerChecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, $$VehiclesTableReferences),
          Vehicle,
          PrefetchHooks Function({
            bool refuelsRefs,
            bool fuelEventsRefs,
            bool tripsRefs,
            bool odometerChecksRefs,
            bool remindersRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> tankCapacityL = const Value.absent(),
                Value<double> reserveL = const Value.absent(),
                Value<double> defaultMileageKmpl = const Value.absent(),
                Value<double?> learnedMileageKmpl = const Value.absent(),
                Value<double> distanceFactor = const Value.absent(),
                Value<double> safetyFactor = const Value.absent(),
                Value<double> lowFuelThresholdL = const Value.absent(),
                Value<double> odometerStartKm = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                name: name,
                tankCapacityL: tankCapacityL,
                reserveL: reserveL,
                defaultMileageKmpl: defaultMileageKmpl,
                learnedMileageKmpl: learnedMileageKmpl,
                distanceFactor: distanceFactor,
                safetyFactor: safetyFactor,
                lowFuelThresholdL: lowFuelThresholdL,
                odometerStartKm: odometerStartKm,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                required String name,
                Value<double> tankCapacityL = const Value.absent(),
                Value<double> reserveL = const Value.absent(),
                Value<double> defaultMileageKmpl = const Value.absent(),
                Value<double?> learnedMileageKmpl = const Value.absent(),
                Value<double> distanceFactor = const Value.absent(),
                Value<double> safetyFactor = const Value.absent(),
                Value<double> lowFuelThresholdL = const Value.absent(),
                Value<double> odometerStartKm = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                name: name,
                tankCapacityL: tankCapacityL,
                reserveL: reserveL,
                defaultMileageKmpl: defaultMileageKmpl,
                learnedMileageKmpl: learnedMileageKmpl,
                distanceFactor: distanceFactor,
                safetyFactor: safetyFactor,
                lowFuelThresholdL: lowFuelThresholdL,
                odometerStartKm: odometerStartKm,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiclesTable, Vehicle>(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                refuelsRefs = false,
                fuelEventsRefs = false,
                tripsRefs = false,
                odometerChecksRefs = false,
                remindersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (refuelsRefs) db.refuels,
                    if (fuelEventsRefs) db.fuelEvents,
                    if (tripsRefs) db.trips,
                    if (odometerChecksRefs) db.odometerChecks,
                    if (remindersRefs) db.reminders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (refuelsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Refuel
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._refuelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).refuelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fuelEventsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          FuelEvent
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tripsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Trip
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._tripsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).tripsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (odometerChecksRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          OdometerCheck
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._odometerChecksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).odometerChecksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Reminder
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, $$VehiclesTableReferences),
      Vehicle,
      PrefetchHooks Function({
        bool refuelsRefs,
        bool fuelEventsRefs,
        bool tripsRefs,
        bool odometerChecksRefs,
        bool remindersRefs,
      })
    >;
typedef $$RefuelsTableCreateCompanionBuilder =
    RefuelsCompanion Function({
      required String id,
      Value<String?> userId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      required String vehicleId,
      required DateTime at,
      required double litres,
      required double priceTotal,
      Value<double?> pricePerL,
      Value<double?> odometerKm,
      Value<bool> isFull,
      Value<AnchorMode> anchorMode,
      Value<double> assumedLeftoverL,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$RefuelsTableUpdateCompanionBuilder =
    RefuelsCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<String> vehicleId,
      Value<DateTime> at,
      Value<double> litres,
      Value<double> priceTotal,
      Value<double?> pricePerL,
      Value<double?> odometerKm,
      Value<bool> isFull,
      Value<AnchorMode> anchorMode,
      Value<double> assumedLeftoverL,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$RefuelsTableReferences
    extends BaseReferences<_$AppDatabase, $RefuelsTable, Refuel> {
  $$RefuelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('refuels__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RefuelsTableFilterComposer
    extends Composer<_$AppDatabase, $RefuelsTable> {
  $$RefuelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get litres => $composableBuilder(
    column: $table.litres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceTotal => $composableBuilder(
    column: $table.priceTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerL => $composableBuilder(
    column: $table.pricePerL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFull => $composableBuilder(
    column: $table.isFull,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AnchorMode, AnchorMode, int> get anchorMode =>
      $composableBuilder(
        column: $table.anchorMode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get assumedLeftoverL => $composableBuilder(
    column: $table.assumedLeftoverL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RefuelsTableOrderingComposer
    extends Composer<_$AppDatabase, $RefuelsTable> {
  $$RefuelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get litres => $composableBuilder(
    column: $table.litres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceTotal => $composableBuilder(
    column: $table.priceTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerL => $composableBuilder(
    column: $table.pricePerL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFull => $composableBuilder(
    column: $table.isFull,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anchorMode => $composableBuilder(
    column: $table.anchorMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get assumedLeftoverL => $composableBuilder(
    column: $table.assumedLeftoverL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RefuelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RefuelsTable> {
  $$RefuelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<double> get litres =>
      $composableBuilder(column: $table.litres, builder: (column) => column);

  GeneratedColumn<double> get priceTotal => $composableBuilder(
    column: $table.priceTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pricePerL =>
      $composableBuilder(column: $table.pricePerL, builder: (column) => column);

  GeneratedColumn<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFull =>
      $composableBuilder(column: $table.isFull, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AnchorMode, int> get anchorMode =>
      $composableBuilder(
        column: $table.anchorMode,
        builder: (column) => column,
      );

  GeneratedColumn<double> get assumedLeftoverL => $composableBuilder(
    column: $table.assumedLeftoverL,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RefuelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RefuelsTable,
          Refuel,
          $$RefuelsTableFilterComposer,
          $$RefuelsTableOrderingComposer,
          $$RefuelsTableAnnotationComposer,
          $$RefuelsTableCreateCompanionBuilder,
          $$RefuelsTableUpdateCompanionBuilder,
          (Refuel, $$RefuelsTableReferences),
          Refuel,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$RefuelsTableTableManager(_$AppDatabase db, $RefuelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RefuelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RefuelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RefuelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<double> litres = const Value.absent(),
                Value<double> priceTotal = const Value.absent(),
                Value<double?> pricePerL = const Value.absent(),
                Value<double?> odometerKm = const Value.absent(),
                Value<bool> isFull = const Value.absent(),
                Value<AnchorMode> anchorMode = const Value.absent(),
                Value<double> assumedLeftoverL = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RefuelsCompanion(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                at: at,
                litres: litres,
                priceTotal: priceTotal,
                pricePerL: pricePerL,
                odometerKm: odometerKm,
                isFull: isFull,
                anchorMode: anchorMode,
                assumedLeftoverL: assumedLeftoverL,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                required String vehicleId,
                required DateTime at,
                required double litres,
                required double priceTotal,
                Value<double?> pricePerL = const Value.absent(),
                Value<double?> odometerKm = const Value.absent(),
                Value<bool> isFull = const Value.absent(),
                Value<AnchorMode> anchorMode = const Value.absent(),
                Value<double> assumedLeftoverL = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RefuelsCompanion.insert(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                at: at,
                litres: litres,
                priceTotal: priceTotal,
                pricePerL: pricePerL,
                odometerKm: odometerKm,
                isFull: isFull,
                anchorMode: anchorMode,
                assumedLeftoverL: assumedLeftoverL,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RefuelsTable, Refuel>(table),
                  $$RefuelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$RefuelsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$RefuelsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RefuelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RefuelsTable,
      Refuel,
      $$RefuelsTableFilterComposer,
      $$RefuelsTableOrderingComposer,
      $$RefuelsTableAnnotationComposer,
      $$RefuelsTableCreateCompanionBuilder,
      $$RefuelsTableUpdateCompanionBuilder,
      (Refuel, $$RefuelsTableReferences),
      Refuel,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$FuelEventsTableCreateCompanionBuilder =
    FuelEventsCompanion Function({
      required String id,
      Value<String?> userId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      required String vehicleId,
      required DateTime at,
      required FuelEventKind kind,
      required double levelL,
      Value<int> rowid,
    });
typedef $$FuelEventsTableUpdateCompanionBuilder =
    FuelEventsCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<String> vehicleId,
      Value<DateTime> at,
      Value<FuelEventKind> kind,
      Value<double> levelL,
      Value<int> rowid,
    });

final class $$FuelEventsTableReferences
    extends BaseReferences<_$AppDatabase, $FuelEventsTable, FuelEvent> {
  $$FuelEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('fuel_events__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelEventsTableFilterComposer
    extends Composer<_$AppDatabase, $FuelEventsTable> {
  $$FuelEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FuelEventKind, FuelEventKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get levelL => $composableBuilder(
    column: $table.levelL,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelEventsTable> {
  $$FuelEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get levelL => $composableBuilder(
    column: $table.levelL,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelEventsTable> {
  $$FuelEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FuelEventKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get levelL =>
      $composableBuilder(column: $table.levelL, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelEventsTable,
          FuelEvent,
          $$FuelEventsTableFilterComposer,
          $$FuelEventsTableOrderingComposer,
          $$FuelEventsTableAnnotationComposer,
          $$FuelEventsTableCreateCompanionBuilder,
          $$FuelEventsTableUpdateCompanionBuilder,
          (FuelEvent, $$FuelEventsTableReferences),
          FuelEvent,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$FuelEventsTableTableManager(_$AppDatabase db, $FuelEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<FuelEventKind> kind = const Value.absent(),
                Value<double> levelL = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FuelEventsCompanion(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                at: at,
                kind: kind,
                levelL: levelL,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                required String vehicleId,
                required DateTime at,
                required FuelEventKind kind,
                required double levelL,
                Value<int> rowid = const Value.absent(),
              }) => FuelEventsCompanion.insert(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                at: at,
                kind: kind,
                levelL: levelL,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FuelEventsTable, FuelEvent>(table),
                  $$FuelEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$FuelEventsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$FuelEventsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelEventsTable,
      FuelEvent,
      $$FuelEventsTableFilterComposer,
      $$FuelEventsTableOrderingComposer,
      $$FuelEventsTableAnnotationComposer,
      $$FuelEventsTableCreateCompanionBuilder,
      $$FuelEventsTableUpdateCompanionBuilder,
      (FuelEvent, $$FuelEventsTableReferences),
      FuelEvent,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$TripsTableCreateCompanionBuilder =
    TripsCompanion Function({
      required String id,
      Value<String?> userId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      required String vehicleId,
      required TripStatus status,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<double> rawDistanceKm,
      Value<int> durationS,
      Value<int> movingS,
      Value<int> idleS,
      Value<double> avgSpeedKmh,
      Value<double> maxSpeedKmh,
      Value<double?> elevationGainM,
      Value<double?> startLat,
      Value<double?> startLng,
      Value<double?> endLat,
      Value<double?> endLng,
      Value<String?> title,
      Value<String?> notes,
      Value<Uint8List?> routeGz,
      Value<int> rowid,
    });
typedef $$TripsTableUpdateCompanionBuilder =
    TripsCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<String> vehicleId,
      Value<TripStatus> status,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<double> rawDistanceKm,
      Value<int> durationS,
      Value<int> movingS,
      Value<int> idleS,
      Value<double> avgSpeedKmh,
      Value<double> maxSpeedKmh,
      Value<double?> elevationGainM,
      Value<double?> startLat,
      Value<double?> startLng,
      Value<double?> endLat,
      Value<double?> endLng,
      Value<String?> title,
      Value<String?> notes,
      Value<Uint8List?> routeGz,
      Value<int> rowid,
    });

final class $$TripsTableReferences
    extends BaseReferences<_$AppDatabase, $TripsTable, Trip> {
  $$TripsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('trips__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TripPointsTable, List<TripPoint>>
  _tripPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tripPoints,
    aliasName: 'trips__id__trip_points__trip_id',
  );

  $$TripPointsTableProcessedTableManager get tripPointsRefs {
    final manager = $$TripPointsTableTableManager(
      $_db,
      $_db.tripPoints,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tripPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TripsTableFilterComposer extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TripStatus, TripStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rawDistanceKm => $composableBuilder(
    column: $table.rawDistanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get movingS => $composableBuilder(
    column: $table.movingS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idleS => $composableBuilder(
    column: $table.idleS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgSpeedKmh => $composableBuilder(
    column: $table.avgSpeedKmh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSpeedKmh => $composableBuilder(
    column: $table.maxSpeedKmh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get elevationGainM => $composableBuilder(
    column: $table.elevationGainM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startLat => $composableBuilder(
    column: $table.startLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startLng => $composableBuilder(
    column: $table.startLng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endLat => $composableBuilder(
    column: $table.endLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endLng => $composableBuilder(
    column: $table.endLng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get routeGz => $composableBuilder(
    column: $table.routeGz,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tripPointsRefs(
    Expression<bool> Function($$TripPointsTableFilterComposer f) f,
  ) {
    final $$TripPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tripPoints,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripPointsTableFilterComposer(
            $db: $db,
            $table: $db.tripPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rawDistanceKm => $composableBuilder(
    column: $table.rawDistanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get movingS => $composableBuilder(
    column: $table.movingS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idleS => $composableBuilder(
    column: $table.idleS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgSpeedKmh => $composableBuilder(
    column: $table.avgSpeedKmh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSpeedKmh => $composableBuilder(
    column: $table.maxSpeedKmh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get elevationGainM => $composableBuilder(
    column: $table.elevationGainM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startLat => $composableBuilder(
    column: $table.startLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startLng => $composableBuilder(
    column: $table.startLng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endLat => $composableBuilder(
    column: $table.endLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endLng => $composableBuilder(
    column: $table.endLng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get routeGz => $composableBuilder(
    column: $table.routeGz,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<TripStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<double> get rawDistanceKm => $composableBuilder(
    column: $table.rawDistanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationS =>
      $composableBuilder(column: $table.durationS, builder: (column) => column);

  GeneratedColumn<int> get movingS =>
      $composableBuilder(column: $table.movingS, builder: (column) => column);

  GeneratedColumn<int> get idleS =>
      $composableBuilder(column: $table.idleS, builder: (column) => column);

  GeneratedColumn<double> get avgSpeedKmh => $composableBuilder(
    column: $table.avgSpeedKmh,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSpeedKmh => $composableBuilder(
    column: $table.maxSpeedKmh,
    builder: (column) => column,
  );

  GeneratedColumn<double> get elevationGainM => $composableBuilder(
    column: $table.elevationGainM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get startLat =>
      $composableBuilder(column: $table.startLat, builder: (column) => column);

  GeneratedColumn<double> get startLng =>
      $composableBuilder(column: $table.startLng, builder: (column) => column);

  GeneratedColumn<double> get endLat =>
      $composableBuilder(column: $table.endLat, builder: (column) => column);

  GeneratedColumn<double> get endLng =>
      $composableBuilder(column: $table.endLng, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<Uint8List> get routeGz =>
      $composableBuilder(column: $table.routeGz, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> tripPointsRefs<T extends Object>(
    Expression<T> Function($$TripPointsTableAnnotationComposer a) f,
  ) {
    final $$TripPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tripPoints,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.tripPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripsTable,
          Trip,
          $$TripsTableFilterComposer,
          $$TripsTableOrderingComposer,
          $$TripsTableAnnotationComposer,
          $$TripsTableCreateCompanionBuilder,
          $$TripsTableUpdateCompanionBuilder,
          (Trip, $$TripsTableReferences),
          Trip,
          PrefetchHooks Function({bool vehicleId, bool tripPointsRefs})
        > {
  $$TripsTableTableManager(_$AppDatabase db, $TripsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<TripStatus> status = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<double> rawDistanceKm = const Value.absent(),
                Value<int> durationS = const Value.absent(),
                Value<int> movingS = const Value.absent(),
                Value<int> idleS = const Value.absent(),
                Value<double> avgSpeedKmh = const Value.absent(),
                Value<double> maxSpeedKmh = const Value.absent(),
                Value<double?> elevationGainM = const Value.absent(),
                Value<double?> startLat = const Value.absent(),
                Value<double?> startLng = const Value.absent(),
                Value<double?> endLat = const Value.absent(),
                Value<double?> endLng = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<Uint8List?> routeGz = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripsCompanion(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                status: status,
                startedAt: startedAt,
                endedAt: endedAt,
                rawDistanceKm: rawDistanceKm,
                durationS: durationS,
                movingS: movingS,
                idleS: idleS,
                avgSpeedKmh: avgSpeedKmh,
                maxSpeedKmh: maxSpeedKmh,
                elevationGainM: elevationGainM,
                startLat: startLat,
                startLng: startLng,
                endLat: endLat,
                endLng: endLng,
                title: title,
                notes: notes,
                routeGz: routeGz,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                required String vehicleId,
                required TripStatus status,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<double> rawDistanceKm = const Value.absent(),
                Value<int> durationS = const Value.absent(),
                Value<int> movingS = const Value.absent(),
                Value<int> idleS = const Value.absent(),
                Value<double> avgSpeedKmh = const Value.absent(),
                Value<double> maxSpeedKmh = const Value.absent(),
                Value<double?> elevationGainM = const Value.absent(),
                Value<double?> startLat = const Value.absent(),
                Value<double?> startLng = const Value.absent(),
                Value<double?> endLat = const Value.absent(),
                Value<double?> endLng = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<Uint8List?> routeGz = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripsCompanion.insert(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                status: status,
                startedAt: startedAt,
                endedAt: endedAt,
                rawDistanceKm: rawDistanceKm,
                durationS: durationS,
                movingS: movingS,
                idleS: idleS,
                avgSpeedKmh: avgSpeedKmh,
                maxSpeedKmh: maxSpeedKmh,
                elevationGainM: elevationGainM,
                startLat: startLat,
                startLng: startLng,
                endLat: endLat,
                endLng: endLng,
                title: title,
                notes: notes,
                routeGz: routeGz,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TripsTable, Trip>(table),
                  $$TripsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false, tripPointsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tripPointsRefs) db.tripPoints],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$TripsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$TripsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tripPointsRefs)
                    await $_getPrefetchedData<Trip, $TripsTable, TripPoint>(
                      currentTable: table,
                      referencedTable: $$TripsTableReferences
                          ._tripPointsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TripsTableReferences(db, table, p0).tripPointsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tripId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TripsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripsTable,
      Trip,
      $$TripsTableFilterComposer,
      $$TripsTableOrderingComposer,
      $$TripsTableAnnotationComposer,
      $$TripsTableCreateCompanionBuilder,
      $$TripsTableUpdateCompanionBuilder,
      (Trip, $$TripsTableReferences),
      Trip,
      PrefetchHooks Function({bool vehicleId, bool tripPointsRefs})
    >;
typedef $$TripPointsTableCreateCompanionBuilder =
    TripPointsCompanion Function({
      Value<int> id,
      required String tripId,
      required int seq,
      required DateTime ts,
      required double lat,
      required double lng,
      Value<double?> altitudeM,
      Value<double> speedMps,
      Value<double> accuracyM,
      Value<bool> isMoving,
    });
typedef $$TripPointsTableUpdateCompanionBuilder =
    TripPointsCompanion Function({
      Value<int> id,
      Value<String> tripId,
      Value<int> seq,
      Value<DateTime> ts,
      Value<double> lat,
      Value<double> lng,
      Value<double?> altitudeM,
      Value<double> speedMps,
      Value<double> accuracyM,
      Value<bool> isMoving,
    });

final class $$TripPointsTableReferences
    extends BaseReferences<_$AppDatabase, $TripPointsTable, TripPoint> {
  $$TripPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('trip_points__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<String>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TripPointsTableFilterComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMoving => $composableBuilder(
    column: $table.isMoving,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMoving => $composableBuilder(
    column: $table.isMoving,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<DateTime> get ts =>
      $composableBuilder(column: $table.ts, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<double> get altitudeM =>
      $composableBuilder(column: $table.altitudeM, builder: (column) => column);

  GeneratedColumn<double> get speedMps =>
      $composableBuilder(column: $table.speedMps, builder: (column) => column);

  GeneratedColumn<double> get accuracyM =>
      $composableBuilder(column: $table.accuracyM, builder: (column) => column);

  GeneratedColumn<bool> get isMoving =>
      $composableBuilder(column: $table.isMoving, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripPointsTable,
          TripPoint,
          $$TripPointsTableFilterComposer,
          $$TripPointsTableOrderingComposer,
          $$TripPointsTableAnnotationComposer,
          $$TripPointsTableCreateCompanionBuilder,
          $$TripPointsTableUpdateCompanionBuilder,
          (TripPoint, $$TripPointsTableReferences),
          TripPoint,
          PrefetchHooks Function({bool tripId})
        > {
  $$TripPointsTableTableManager(_$AppDatabase db, $TripPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tripId = const Value.absent(),
                Value<int> seq = const Value.absent(),
                Value<DateTime> ts = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
                Value<double?> altitudeM = const Value.absent(),
                Value<double> speedMps = const Value.absent(),
                Value<double> accuracyM = const Value.absent(),
                Value<bool> isMoving = const Value.absent(),
              }) => TripPointsCompanion(
                id: id,
                tripId: tripId,
                seq: seq,
                ts: ts,
                lat: lat,
                lng: lng,
                altitudeM: altitudeM,
                speedMps: speedMps,
                accuracyM: accuracyM,
                isMoving: isMoving,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tripId,
                required int seq,
                required DateTime ts,
                required double lat,
                required double lng,
                Value<double?> altitudeM = const Value.absent(),
                Value<double> speedMps = const Value.absent(),
                Value<double> accuracyM = const Value.absent(),
                Value<bool> isMoving = const Value.absent(),
              }) => TripPointsCompanion.insert(
                id: id,
                tripId: tripId,
                seq: seq,
                ts: ts,
                lat: lat,
                lng: lng,
                altitudeM: altitudeM,
                speedMps: speedMps,
                accuracyM: accuracyM,
                isMoving: isMoving,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TripPointsTable, TripPoint>(table),
                  $$TripPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$TripPointsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$TripPointsTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TripPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripPointsTable,
      TripPoint,
      $$TripPointsTableFilterComposer,
      $$TripPointsTableOrderingComposer,
      $$TripPointsTableAnnotationComposer,
      $$TripPointsTableCreateCompanionBuilder,
      $$TripPointsTableUpdateCompanionBuilder,
      (TripPoint, $$TripPointsTableReferences),
      TripPoint,
      PrefetchHooks Function({bool tripId})
    >;
typedef $$OdometerChecksTableCreateCompanionBuilder =
    OdometerChecksCompanion Function({
      required String id,
      Value<String?> userId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      required String vehicleId,
      required DateTime at,
      required double odometerKm,
      Value<double?> gpsKmSinceLast,
      Value<double?> factorSample,
      Value<int> rowid,
    });
typedef $$OdometerChecksTableUpdateCompanionBuilder =
    OdometerChecksCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<String> vehicleId,
      Value<DateTime> at,
      Value<double> odometerKm,
      Value<double?> gpsKmSinceLast,
      Value<double?> factorSample,
      Value<int> rowid,
    });

final class $$OdometerChecksTableReferences
    extends BaseReferences<_$AppDatabase, $OdometerChecksTable, OdometerCheck> {
  $$OdometerChecksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('odometer_checks__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OdometerChecksTableFilterComposer
    extends Composer<_$AppDatabase, $OdometerChecksTable> {
  $$OdometerChecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsKmSinceLast => $composableBuilder(
    column: $table.gpsKmSinceLast,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get factorSample => $composableBuilder(
    column: $table.factorSample,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OdometerChecksTableOrderingComposer
    extends Composer<_$AppDatabase, $OdometerChecksTable> {
  $$OdometerChecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsKmSinceLast => $composableBuilder(
    column: $table.gpsKmSinceLast,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get factorSample => $composableBuilder(
    column: $table.factorSample,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OdometerChecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $OdometerChecksTable> {
  $$OdometerChecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gpsKmSinceLast => $composableBuilder(
    column: $table.gpsKmSinceLast,
    builder: (column) => column,
  );

  GeneratedColumn<double> get factorSample => $composableBuilder(
    column: $table.factorSample,
    builder: (column) => column,
  );

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OdometerChecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OdometerChecksTable,
          OdometerCheck,
          $$OdometerChecksTableFilterComposer,
          $$OdometerChecksTableOrderingComposer,
          $$OdometerChecksTableAnnotationComposer,
          $$OdometerChecksTableCreateCompanionBuilder,
          $$OdometerChecksTableUpdateCompanionBuilder,
          (OdometerCheck, $$OdometerChecksTableReferences),
          OdometerCheck,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$OdometerChecksTableTableManager(
    _$AppDatabase db,
    $OdometerChecksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OdometerChecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OdometerChecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OdometerChecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<double> odometerKm = const Value.absent(),
                Value<double?> gpsKmSinceLast = const Value.absent(),
                Value<double?> factorSample = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OdometerChecksCompanion(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                at: at,
                odometerKm: odometerKm,
                gpsKmSinceLast: gpsKmSinceLast,
                factorSample: factorSample,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                required String vehicleId,
                required DateTime at,
                required double odometerKm,
                Value<double?> gpsKmSinceLast = const Value.absent(),
                Value<double?> factorSample = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OdometerChecksCompanion.insert(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                at: at,
                odometerKm: odometerKm,
                gpsKmSinceLast: gpsKmSinceLast,
                factorSample: factorSample,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OdometerChecksTable, OdometerCheck>(table),
                  $$OdometerChecksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$OdometerChecksTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn:
                                    $$OdometerChecksTableReferences
                                        ._vehicleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OdometerChecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OdometerChecksTable,
      OdometerCheck,
      $$OdometerChecksTableFilterComposer,
      $$OdometerChecksTableOrderingComposer,
      $$OdometerChecksTableAnnotationComposer,
      $$OdometerChecksTableCreateCompanionBuilder,
      $$OdometerChecksTableUpdateCompanionBuilder,
      (OdometerCheck, $$OdometerChecksTableReferences),
      OdometerCheck,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      required String id,
      Value<String?> userId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      required String vehicleId,
      required ReminderKind kind,
      required String title,
      Value<double?> dueKm,
      Value<DateTime?> dueDate,
      Value<double?> intervalKm,
      Value<int?> intervalDays,
      Value<double?> lastDoneKm,
      Value<DateTime?> lastDoneDate,
      Value<double?> notifyBeforeKm,
      Value<int?> notifyBeforeDays,
      Value<String?> notes,
      Value<int?> iconCodePoint,
      Value<int> rowid,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<String> vehicleId,
      Value<ReminderKind> kind,
      Value<String> title,
      Value<double?> dueKm,
      Value<DateTime?> dueDate,
      Value<double?> intervalKm,
      Value<int?> intervalDays,
      Value<double?> lastDoneKm,
      Value<DateTime?> lastDoneDate,
      Value<double?> notifyBeforeKm,
      Value<int?> notifyBeforeDays,
      Value<String?> notes,
      Value<int?> iconCodePoint,
      Value<int> rowid,
    });

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, Reminder> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('reminders__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ReminderKind, ReminderKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dueKm => $composableBuilder(
    column: $table.dueKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastDoneKm => $composableBuilder(
    column: $table.lastDoneKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastDoneDate => $composableBuilder(
    column: $table.lastDoneDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get notifyBeforeKm => $composableBuilder(
    column: $table.notifyBeforeKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notifyBeforeDays => $composableBuilder(
    column: $table.notifyBeforeDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dueKm => $composableBuilder(
    column: $table.dueKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastDoneKm => $composableBuilder(
    column: $table.lastDoneKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastDoneDate => $composableBuilder(
    column: $table.lastDoneDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get notifyBeforeKm => $composableBuilder(
    column: $table.notifyBeforeKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notifyBeforeDays => $composableBuilder(
    column: $table.notifyBeforeDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<ReminderKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get dueKm =>
      $composableBuilder(column: $table.dueKm, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<double> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lastDoneKm => $composableBuilder(
    column: $table.lastDoneKm,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastDoneDate => $composableBuilder(
    column: $table.lastDoneDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get notifyBeforeKm => $composableBuilder(
    column: $table.notifyBeforeKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notifyBeforeDays => $composableBuilder(
    column: $table.notifyBeforeDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, $$RemindersTableReferences),
          Reminder,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<ReminderKind> kind = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double?> dueKm = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<double?> intervalKm = const Value.absent(),
                Value<int?> intervalDays = const Value.absent(),
                Value<double?> lastDoneKm = const Value.absent(),
                Value<DateTime?> lastDoneDate = const Value.absent(),
                Value<double?> notifyBeforeKm = const Value.absent(),
                Value<int?> notifyBeforeDays = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> iconCodePoint = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                kind: kind,
                title: title,
                dueKm: dueKm,
                dueDate: dueDate,
                intervalKm: intervalKm,
                intervalDays: intervalDays,
                lastDoneKm: lastDoneKm,
                lastDoneDate: lastDoneDate,
                notifyBeforeKm: notifyBeforeKm,
                notifyBeforeDays: notifyBeforeDays,
                notes: notes,
                iconCodePoint: iconCodePoint,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                required String vehicleId,
                required ReminderKind kind,
                required String title,
                Value<double?> dueKm = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<double?> intervalKm = const Value.absent(),
                Value<int?> intervalDays = const Value.absent(),
                Value<double?> lastDoneKm = const Value.absent(),
                Value<DateTime?> lastDoneDate = const Value.absent(),
                Value<double?> notifyBeforeKm = const Value.absent(),
                Value<int?> notifyBeforeDays = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> iconCodePoint = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                vehicleId: vehicleId,
                kind: kind,
                title: title,
                dueKm: dueKm,
                dueDate: dueDate,
                intervalKm: intervalKm,
                intervalDays: intervalDays,
                lastDoneKm: lastDoneKm,
                lastDoneDate: lastDoneDate,
                notifyBeforeKm: notifyBeforeKm,
                notifyBeforeDays: notifyBeforeDays,
                notes: notes,
                iconCodePoint: iconCodePoint,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, Reminder>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$RemindersTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$RemindersTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, $$RemindersTableReferences),
      Reminder,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$SyncStatesTableCreateCompanionBuilder =
    SyncStatesCompanion Function({
      Value<int> id,
      Value<DateTime?> lastPulledAt,
      Value<DateTime?> lastPushAt,
      Value<String?> lastError,
      Value<DateTime?> lastErrorAt,
      Value<int> rowid,
    });
typedef $$SyncStatesTableUpdateCompanionBuilder =
    SyncStatesCompanion Function({
      Value<int> id,
      Value<DateTime?> lastPulledAt,
      Value<DateTime?> lastPushAt,
      Value<String?> lastError,
      Value<DateTime?> lastErrorAt,
      Value<int> rowid,
    });

class $$SyncStatesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPulledAt => $composableBuilder(
    column: $table.lastPulledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPushAt => $composableBuilder(
    column: $table.lastPushAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastErrorAt => $composableBuilder(
    column: $table.lastErrorAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPulledAt => $composableBuilder(
    column: $table.lastPulledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPushAt => $composableBuilder(
    column: $table.lastPushAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastErrorAt => $composableBuilder(
    column: $table.lastErrorAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPulledAt => $composableBuilder(
    column: $table.lastPulledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPushAt => $composableBuilder(
    column: $table.lastPushAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastErrorAt => $composableBuilder(
    column: $table.lastErrorAt,
    builder: (column) => column,
  );
}

class $$SyncStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStatesTable,
          SyncState,
          $$SyncStatesTableFilterComposer,
          $$SyncStatesTableOrderingComposer,
          $$SyncStatesTableAnnotationComposer,
          $$SyncStatesTableCreateCompanionBuilder,
          $$SyncStatesTableUpdateCompanionBuilder,
          (
            SyncState,
            BaseReferences<_$AppDatabase, $SyncStatesTable, SyncState>,
          ),
          SyncState,
          PrefetchHooks Function()
        > {
  $$SyncStatesTableTableManager(_$AppDatabase db, $SyncStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastPulledAt = const Value.absent(),
                Value<DateTime?> lastPushAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastErrorAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion(
                id: id,
                lastPulledAt: lastPulledAt,
                lastPushAt: lastPushAt,
                lastError: lastError,
                lastErrorAt: lastErrorAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastPulledAt = const Value.absent(),
                Value<DateTime?> lastPushAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastErrorAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion.insert(
                id: id,
                lastPulledAt: lastPulledAt,
                lastPushAt: lastPushAt,
                lastError: lastError,
                lastErrorAt: lastErrorAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncStatesTable, SyncState>(table),
                  BaseReferences<_$AppDatabase, $SyncStatesTable, SyncState>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStatesTable,
      SyncState,
      $$SyncStatesTableFilterComposer,
      $$SyncStatesTableOrderingComposer,
      $$SyncStatesTableAnnotationComposer,
      $$SyncStatesTableCreateCompanionBuilder,
      $$SyncStatesTableUpdateCompanionBuilder,
      (SyncState, BaseReferences<_$AppDatabase, $SyncStatesTable, SyncState>),
      SyncState,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$RefuelsTableTableManager get refuels =>
      $$RefuelsTableTableManager(_db, _db.refuels);
  $$FuelEventsTableTableManager get fuelEvents =>
      $$FuelEventsTableTableManager(_db, _db.fuelEvents);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$TripPointsTableTableManager get tripPoints =>
      $$TripPointsTableTableManager(_db, _db.tripPoints);
  $$OdometerChecksTableTableManager get odometerChecks =>
      $$OdometerChecksTableTableManager(_db, _db.odometerChecks);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$SyncStatesTableTableManager get syncStates =>
      $$SyncStatesTableTableManager(_db, _db.syncStates);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
