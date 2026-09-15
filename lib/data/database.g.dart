// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AppUsersTable extends AppUsers with TableInfo<$AppUsersTable, AppUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
    'salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    passwordHash,
    salt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
        _saltMeta,
        salt.isAcceptableOrUnknown(data['salt']!, _saltMeta),
      );
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      salt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}salt'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AppUsersTable createAlias(String alias) {
    return $AppUsersTable(attachedDatabase, alias);
  }
}

class AppUser extends DataClass implements Insertable<AppUser> {
  final int id;
  final String username;
  final String passwordHash;
  final String salt;
  final DateTime createdAt;
  const AppUser({
    required this.id,
    required this.username,
    required this.passwordHash,
    required this.salt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password_hash'] = Variable<String>(passwordHash);
    map['salt'] = Variable<String>(salt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AppUsersCompanion toCompanion(bool nullToAbsent) {
    return AppUsersCompanion(
      id: Value(id),
      username: Value(username),
      passwordHash: Value(passwordHash),
      salt: Value(salt),
      createdAt: Value(createdAt),
    );
  }

  factory AppUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUser(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      salt: serializer.fromJson<String>(json['salt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'salt': serializer.toJson<String>(salt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AppUser copyWith({
    int? id,
    String? username,
    String? passwordHash,
    String? salt,
    DateTime? createdAt,
  }) => AppUser(
    id: id ?? this.id,
    username: username ?? this.username,
    passwordHash: passwordHash ?? this.passwordHash,
    salt: salt ?? this.salt,
    createdAt: createdAt ?? this.createdAt,
  );
  AppUser copyWithCompanion(AppUsersCompanion data) {
    return AppUser(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      salt: data.salt.present ? data.salt.value : this.salt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUser(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, passwordHash, salt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          other.id == this.id &&
          other.username == this.username &&
          other.passwordHash == this.passwordHash &&
          other.salt == this.salt &&
          other.createdAt == this.createdAt);
}

class AppUsersCompanion extends UpdateCompanion<AppUser> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> passwordHash;
  final Value<String> salt;
  final Value<DateTime> createdAt;
  const AppUsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.salt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AppUsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String passwordHash,
    required String salt,
    required DateTime createdAt,
  }) : username = Value(username),
       passwordHash = Value(passwordHash),
       salt = Value(salt),
       createdAt = Value(createdAt);
  static Insertable<AppUser> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? passwordHash,
    Expression<String>? salt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (salt != null) 'salt': salt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AppUsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? passwordHash,
    Value<String>? salt,
    Value<DateTime>? createdAt,
  }) {
    return AppUsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      salt: salt ?? this.salt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ObservationProtocolsTable extends ObservationProtocols
    with TableInfo<$ObservationProtocolsTable, ObservationProtocol> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservationProtocolsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _useManualMeta = const VerificationMeta(
    'useManual',
  );
  @override
  late final GeneratedColumn<bool> useManual = GeneratedColumn<bool>(
    'use_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _useReachZonesMeta = const VerificationMeta(
    'useReachZones',
  );
  @override
  late final GeneratedColumn<bool> useReachZones = GeneratedColumn<bool>(
    'use_reach_zones',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_reach_zones" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _useActivityMeta = const VerificationMeta(
    'useActivity',
  );
  @override
  late final GeneratedColumn<bool> useActivity = GeneratedColumn<bool>(
    'use_activity',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_activity" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _activityEngineMeta = const VerificationMeta(
    'activityEngine',
  );
  @override
  late final GeneratedColumn<String> activityEngine = GeneratedColumn<String>(
    'activity_engine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('observer'),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    useManual,
    useReachZones,
    useActivity,
    activityEngine,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observation_protocols';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObservationProtocol> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('use_manual')) {
      context.handle(
        _useManualMeta,
        useManual.isAcceptableOrUnknown(data['use_manual']!, _useManualMeta),
      );
    }
    if (data.containsKey('use_reach_zones')) {
      context.handle(
        _useReachZonesMeta,
        useReachZones.isAcceptableOrUnknown(
          data['use_reach_zones']!,
          _useReachZonesMeta,
        ),
      );
    }
    if (data.containsKey('use_activity')) {
      context.handle(
        _useActivityMeta,
        useActivity.isAcceptableOrUnknown(
          data['use_activity']!,
          _useActivityMeta,
        ),
      );
    }
    if (data.containsKey('activity_engine')) {
      context.handle(
        _activityEngineMeta,
        activityEngine.isAcceptableOrUnknown(
          data['activity_engine']!,
          _activityEngineMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObservationProtocol map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObservationProtocol(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      useManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_manual'],
      )!,
      useReachZones: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_reach_zones'],
      )!,
      useActivity: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_activity'],
      )!,
      activityEngine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_engine'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ObservationProtocolsTable createAlias(String alias) {
    return $ObservationProtocolsTable(attachedDatabase, alias);
  }
}

class ObservationProtocol extends DataClass
    implements Insertable<ObservationProtocol> {
  final int id;
  final int userId;
  final String name;
  final bool useManual;
  final bool useReachZones;
  final bool useActivity;
  final String activityEngine;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ObservationProtocol({
    required this.id,
    required this.userId,
    required this.name,
    required this.useManual,
    required this.useReachZones,
    required this.useActivity,
    required this.activityEngine,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    map['use_manual'] = Variable<bool>(useManual);
    map['use_reach_zones'] = Variable<bool>(useReachZones);
    map['use_activity'] = Variable<bool>(useActivity);
    map['activity_engine'] = Variable<String>(activityEngine);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ObservationProtocolsCompanion toCompanion(bool nullToAbsent) {
    return ObservationProtocolsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      useManual: Value(useManual),
      useReachZones: Value(useReachZones),
      useActivity: Value(useActivity),
      activityEngine: Value(activityEngine),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ObservationProtocol.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObservationProtocol(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      useManual: serializer.fromJson<bool>(json['useManual']),
      useReachZones: serializer.fromJson<bool>(json['useReachZones']),
      useActivity: serializer.fromJson<bool>(json['useActivity']),
      activityEngine: serializer.fromJson<String>(json['activityEngine']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
      'useManual': serializer.toJson<bool>(useManual),
      'useReachZones': serializer.toJson<bool>(useReachZones),
      'useActivity': serializer.toJson<bool>(useActivity),
      'activityEngine': serializer.toJson<String>(activityEngine),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ObservationProtocol copyWith({
    int? id,
    int? userId,
    String? name,
    bool? useManual,
    bool? useReachZones,
    bool? useActivity,
    String? activityEngine,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ObservationProtocol(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    useManual: useManual ?? this.useManual,
    useReachZones: useReachZones ?? this.useReachZones,
    useActivity: useActivity ?? this.useActivity,
    activityEngine: activityEngine ?? this.activityEngine,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ObservationProtocol copyWithCompanion(ObservationProtocolsCompanion data) {
    return ObservationProtocol(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      useManual: data.useManual.present ? data.useManual.value : this.useManual,
      useReachZones: data.useReachZones.present
          ? data.useReachZones.value
          : this.useReachZones,
      useActivity: data.useActivity.present
          ? data.useActivity.value
          : this.useActivity,
      activityEngine: data.activityEngine.present
          ? data.activityEngine.value
          : this.activityEngine,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObservationProtocol(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('useManual: $useManual, ')
          ..write('useReachZones: $useReachZones, ')
          ..write('useActivity: $useActivity, ')
          ..write('activityEngine: $activityEngine, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    useManual,
    useReachZones,
    useActivity,
    activityEngine,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObservationProtocol &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.useManual == this.useManual &&
          other.useReachZones == this.useReachZones &&
          other.useActivity == this.useActivity &&
          other.activityEngine == this.activityEngine &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ObservationProtocolsCompanion
    extends UpdateCompanion<ObservationProtocol> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> name;
  final Value<bool> useManual;
  final Value<bool> useReachZones;
  final Value<bool> useActivity;
  final Value<String> activityEngine;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ObservationProtocolsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.useManual = const Value.absent(),
    this.useReachZones = const Value.absent(),
    this.useActivity = const Value.absent(),
    this.activityEngine = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ObservationProtocolsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String name,
    this.useManual = const Value.absent(),
    this.useReachZones = const Value.absent(),
    this.useActivity = const Value.absent(),
    this.activityEngine = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ObservationProtocol> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<bool>? useManual,
    Expression<bool>? useReachZones,
    Expression<bool>? useActivity,
    Expression<String>? activityEngine,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (useManual != null) 'use_manual': useManual,
      if (useReachZones != null) 'use_reach_zones': useReachZones,
      if (useActivity != null) 'use_activity': useActivity,
      if (activityEngine != null) 'activity_engine': activityEngine,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ObservationProtocolsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? name,
    Value<bool>? useManual,
    Value<bool>? useReachZones,
    Value<bool>? useActivity,
    Value<String>? activityEngine,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ObservationProtocolsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      useManual: useManual ?? this.useManual,
      useReachZones: useReachZones ?? this.useReachZones,
      useActivity: useActivity ?? this.useActivity,
      activityEngine: activityEngine ?? this.activityEngine,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (useManual.present) {
      map['use_manual'] = Variable<bool>(useManual.value);
    }
    if (useReachZones.present) {
      map['use_reach_zones'] = Variable<bool>(useReachZones.value);
    }
    if (useActivity.present) {
      map['use_activity'] = Variable<bool>(useActivity.value);
    }
    if (activityEngine.present) {
      map['activity_engine'] = Variable<String>(activityEngine.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservationProtocolsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('useManual: $useManual, ')
          ..write('useReachZones: $useReachZones, ')
          ..write('useActivity: $useActivity, ')
          ..write('activityEngine: $activityEngine, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ObservableClassesTable extends ObservableClasses
    with TableInfo<$ObservableClassesTable, ObservableClassesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservableClassesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _protocolIdMeta = const VerificationMeta(
    'protocolId',
  );
  @override
  late final GeneratedColumn<int> protocolId = GeneratedColumn<int>(
    'protocol_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_protocols (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    protocolId,
    name,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observable_classes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObservableClassesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('protocol_id')) {
      context.handle(
        _protocolIdMeta,
        protocolId.isAcceptableOrUnknown(data['protocol_id']!, _protocolIdMeta),
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
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObservableClassesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObservableClassesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      protocolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protocol_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ObservableClassesTable createAlias(String alias) {
    return $ObservableClassesTable(attachedDatabase, alias);
  }
}

class ObservableClassesData extends DataClass
    implements Insertable<ObservableClassesData> {
  final int id;
  final int? protocolId;
  final String name;
  final int sortOrder;
  final DateTime createdAt;
  const ObservableClassesData({
    required this.id,
    this.protocolId,
    required this.name,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || protocolId != null) {
      map['protocol_id'] = Variable<int>(protocolId);
    }
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ObservableClassesCompanion toCompanion(bool nullToAbsent) {
    return ObservableClassesCompanion(
      id: Value(id),
      protocolId: protocolId == null && nullToAbsent
          ? const Value.absent()
          : Value(protocolId),
      name: Value(name),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory ObservableClassesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObservableClassesData(
      id: serializer.fromJson<int>(json['id']),
      protocolId: serializer.fromJson<int?>(json['protocolId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'protocolId': serializer.toJson<int?>(protocolId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ObservableClassesData copyWith({
    int? id,
    Value<int?> protocolId = const Value.absent(),
    String? name,
    int? sortOrder,
    DateTime? createdAt,
  }) => ObservableClassesData(
    id: id ?? this.id,
    protocolId: protocolId.present ? protocolId.value : this.protocolId,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  ObservableClassesData copyWithCompanion(ObservableClassesCompanion data) {
    return ObservableClassesData(
      id: data.id.present ? data.id.value : this.id,
      protocolId: data.protocolId.present
          ? data.protocolId.value
          : this.protocolId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObservableClassesData(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, protocolId, name, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObservableClassesData &&
          other.id == this.id &&
          other.protocolId == this.protocolId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class ObservableClassesCompanion
    extends UpdateCompanion<ObservableClassesData> {
  final Value<int> id;
  final Value<int?> protocolId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const ObservableClassesCompanion({
    this.id = const Value.absent(),
    this.protocolId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ObservableClassesCompanion.insert({
    this.id = const Value.absent(),
    this.protocolId = const Value.absent(),
    required String name,
    required int sortOrder,
    required DateTime createdAt,
  }) : name = Value(name),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt);
  static Insertable<ObservableClassesData> custom({
    Expression<int>? id,
    Expression<int>? protocolId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (protocolId != null) 'protocol_id': protocolId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ObservableClassesCompanion copyWith({
    Value<int>? id,
    Value<int?>? protocolId,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return ObservableClassesCompanion(
      id: id ?? this.id,
      protocolId: protocolId ?? this.protocolId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (protocolId.present) {
      map['protocol_id'] = Variable<int>(protocolId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservableClassesCompanion(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ObservableSubclassesTable extends ObservableSubclasses
    with TableInfo<$ObservableSubclassesTable, ObservableSubclassesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservableSubclassesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observable_classes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricTypeMeta = const VerificationMeta(
    'metricType',
  );
  @override
  late final GeneratedColumn<String> metricType = GeneratedColumn<String>(
    'metric_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    classId,
    name,
    metricType,
    colorValue,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observable_subclasses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObservableSubclassesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('metric_type')) {
      context.handle(
        _metricTypeMeta,
        metricType.isAcceptableOrUnknown(data['metric_type']!, _metricTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_metricTypeMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObservableSubclassesData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObservableSubclassesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      metricType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric_type'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ObservableSubclassesTable createAlias(String alias) {
    return $ObservableSubclassesTable(attachedDatabase, alias);
  }
}

class ObservableSubclassesData extends DataClass
    implements Insertable<ObservableSubclassesData> {
  final int id;
  final int classId;
  final String name;
  final String metricType;
  final int colorValue;
  final int sortOrder;
  const ObservableSubclassesData({
    required this.id,
    required this.classId,
    required this.name,
    required this.metricType,
    required this.colorValue,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['class_id'] = Variable<int>(classId);
    map['name'] = Variable<String>(name);
    map['metric_type'] = Variable<String>(metricType);
    map['color_value'] = Variable<int>(colorValue);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ObservableSubclassesCompanion toCompanion(bool nullToAbsent) {
    return ObservableSubclassesCompanion(
      id: Value(id),
      classId: Value(classId),
      name: Value(name),
      metricType: Value(metricType),
      colorValue: Value(colorValue),
      sortOrder: Value(sortOrder),
    );
  }

  factory ObservableSubclassesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObservableSubclassesData(
      id: serializer.fromJson<int>(json['id']),
      classId: serializer.fromJson<int>(json['classId']),
      name: serializer.fromJson<String>(json['name']),
      metricType: serializer.fromJson<String>(json['metricType']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classId': serializer.toJson<int>(classId),
      'name': serializer.toJson<String>(name),
      'metricType': serializer.toJson<String>(metricType),
      'colorValue': serializer.toJson<int>(colorValue),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ObservableSubclassesData copyWith({
    int? id,
    int? classId,
    String? name,
    String? metricType,
    int? colorValue,
    int? sortOrder,
  }) => ObservableSubclassesData(
    id: id ?? this.id,
    classId: classId ?? this.classId,
    name: name ?? this.name,
    metricType: metricType ?? this.metricType,
    colorValue: colorValue ?? this.colorValue,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ObservableSubclassesData copyWithCompanion(
    ObservableSubclassesCompanion data,
  ) {
    return ObservableSubclassesData(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      name: data.name.present ? data.name.value : this.name,
      metricType: data.metricType.present
          ? data.metricType.value
          : this.metricType,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObservableSubclassesData(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('metricType: $metricType, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, classId, name, metricType, colorValue, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObservableSubclassesData &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.name == this.name &&
          other.metricType == this.metricType &&
          other.colorValue == this.colorValue &&
          other.sortOrder == this.sortOrder);
}

class ObservableSubclassesCompanion
    extends UpdateCompanion<ObservableSubclassesData> {
  final Value<int> id;
  final Value<int> classId;
  final Value<String> name;
  final Value<String> metricType;
  final Value<int> colorValue;
  final Value<int> sortOrder;
  const ObservableSubclassesCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.name = const Value.absent(),
    this.metricType = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ObservableSubclassesCompanion.insert({
    this.id = const Value.absent(),
    required int classId,
    required String name,
    required String metricType,
    required int colorValue,
    required int sortOrder,
  }) : classId = Value(classId),
       name = Value(name),
       metricType = Value(metricType),
       colorValue = Value(colorValue),
       sortOrder = Value(sortOrder);
  static Insertable<ObservableSubclassesData> custom({
    Expression<int>? id,
    Expression<int>? classId,
    Expression<String>? name,
    Expression<String>? metricType,
    Expression<int>? colorValue,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (name != null) 'name': name,
      if (metricType != null) 'metric_type': metricType,
      if (colorValue != null) 'color_value': colorValue,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ObservableSubclassesCompanion copyWith({
    Value<int>? id,
    Value<int>? classId,
    Value<String>? name,
    Value<String>? metricType,
    Value<int>? colorValue,
    Value<int>? sortOrder,
  }) {
    return ObservableSubclassesCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      metricType: metricType ?? this.metricType,
      colorValue: colorValue ?? this.colorValue,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (metricType.present) {
      map['metric_type'] = Variable<String>(metricType.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservableSubclassesCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('metricType: $metricType, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ObservationSessionsTable extends ObservationSessions
    with TableInfo<$ObservationSessionsTable, ObservationSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservationSessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _useManualMeta = const VerificationMeta(
    'useManual',
  );
  @override
  late final GeneratedColumn<bool> useManual = GeneratedColumn<bool>(
    'use_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_manual" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _useReachZonesMeta = const VerificationMeta(
    'useReachZones',
  );
  @override
  late final GeneratedColumn<bool> useReachZones = GeneratedColumn<bool>(
    'use_reach_zones',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_reach_zones" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _useActivityMeta = const VerificationMeta(
    'useActivity',
  );
  @override
  late final GeneratedColumn<bool> useActivity = GeneratedColumn<bool>(
    'use_activity',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_activity" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _activityEngineMeta = const VerificationMeta(
    'activityEngine',
  );
  @override
  late final GeneratedColumn<String> activityEngine = GeneratedColumn<String>(
    'activity_engine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('observer'),
  );
  static const VerificationMeta _protocolIdMeta = const VerificationMeta(
    'protocolId',
  );
  @override
  late final GeneratedColumn<int> protocolId = GeneratedColumn<int>(
    'protocol_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_protocols (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_users (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    useManual,
    useReachZones,
    useActivity,
    activityEngine,
    protocolId,
    userId,
    name,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observation_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObservationSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('use_manual')) {
      context.handle(
        _useManualMeta,
        useManual.isAcceptableOrUnknown(data['use_manual']!, _useManualMeta),
      );
    }
    if (data.containsKey('use_reach_zones')) {
      context.handle(
        _useReachZonesMeta,
        useReachZones.isAcceptableOrUnknown(
          data['use_reach_zones']!,
          _useReachZonesMeta,
        ),
      );
    }
    if (data.containsKey('use_activity')) {
      context.handle(
        _useActivityMeta,
        useActivity.isAcceptableOrUnknown(
          data['use_activity']!,
          _useActivityMeta,
        ),
      );
    }
    if (data.containsKey('activity_engine')) {
      context.handle(
        _activityEngineMeta,
        activityEngine.isAcceptableOrUnknown(
          data['activity_engine']!,
          _activityEngineMeta,
        ),
      );
    }
    if (data.containsKey('protocol_id')) {
      context.handle(
        _protocolIdMeta,
        protocolId.isAcceptableOrUnknown(data['protocol_id']!, _protocolIdMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObservationSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObservationSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      useManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_manual'],
      )!,
      useReachZones: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_reach_zones'],
      )!,
      useActivity: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_activity'],
      )!,
      activityEngine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_engine'],
      )!,
      protocolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protocol_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ObservationSessionsTable createAlias(String alias) {
    return $ObservationSessionsTable(attachedDatabase, alias);
  }
}

class ObservationSession extends DataClass
    implements Insertable<ObservationSession> {
  final int id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final bool useManual;
  final bool useReachZones;
  final bool useActivity;
  final String activityEngine;
  final int? protocolId;
  final int? userId;
  final String name;
  const ObservationSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.useManual,
    required this.useReachZones,
    required this.useActivity,
    required this.activityEngine,
    this.protocolId,
    this.userId,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['use_manual'] = Variable<bool>(useManual);
    map['use_reach_zones'] = Variable<bool>(useReachZones);
    map['use_activity'] = Variable<bool>(useActivity);
    map['activity_engine'] = Variable<String>(activityEngine);
    if (!nullToAbsent || protocolId != null) {
      map['protocol_id'] = Variable<int>(protocolId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['name'] = Variable<String>(name);
    return map;
  }

  ObservationSessionsCompanion toCompanion(bool nullToAbsent) {
    return ObservationSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      useManual: Value(useManual),
      useReachZones: Value(useReachZones),
      useActivity: Value(useActivity),
      activityEngine: Value(activityEngine),
      protocolId: protocolId == null && nullToAbsent
          ? const Value.absent()
          : Value(protocolId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      name: Value(name),
    );
  }

  factory ObservationSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObservationSession(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      useManual: serializer.fromJson<bool>(json['useManual']),
      useReachZones: serializer.fromJson<bool>(json['useReachZones']),
      useActivity: serializer.fromJson<bool>(json['useActivity']),
      activityEngine: serializer.fromJson<String>(json['activityEngine']),
      protocolId: serializer.fromJson<int?>(json['protocolId']),
      userId: serializer.fromJson<int?>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'useManual': serializer.toJson<bool>(useManual),
      'useReachZones': serializer.toJson<bool>(useReachZones),
      'useActivity': serializer.toJson<bool>(useActivity),
      'activityEngine': serializer.toJson<String>(activityEngine),
      'protocolId': serializer.toJson<int?>(protocolId),
      'userId': serializer.toJson<int?>(userId),
      'name': serializer.toJson<String>(name),
    };
  }

  ObservationSession copyWith({
    int? id,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    bool? useManual,
    bool? useReachZones,
    bool? useActivity,
    String? activityEngine,
    Value<int?> protocolId = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    String? name,
  }) => ObservationSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    useManual: useManual ?? this.useManual,
    useReachZones: useReachZones ?? this.useReachZones,
    useActivity: useActivity ?? this.useActivity,
    activityEngine: activityEngine ?? this.activityEngine,
    protocolId: protocolId.present ? protocolId.value : this.protocolId,
    userId: userId.present ? userId.value : this.userId,
    name: name ?? this.name,
  );
  ObservationSession copyWithCompanion(ObservationSessionsCompanion data) {
    return ObservationSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      useManual: data.useManual.present ? data.useManual.value : this.useManual,
      useReachZones: data.useReachZones.present
          ? data.useReachZones.value
          : this.useReachZones,
      useActivity: data.useActivity.present
          ? data.useActivity.value
          : this.useActivity,
      activityEngine: data.activityEngine.present
          ? data.activityEngine.value
          : this.activityEngine,
      protocolId: data.protocolId.present
          ? data.protocolId.value
          : this.protocolId,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObservationSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('useManual: $useManual, ')
          ..write('useReachZones: $useReachZones, ')
          ..write('useActivity: $useActivity, ')
          ..write('activityEngine: $activityEngine, ')
          ..write('protocolId: $protocolId, ')
          ..write('userId: $userId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    endedAt,
    useManual,
    useReachZones,
    useActivity,
    activityEngine,
    protocolId,
    userId,
    name,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObservationSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.useManual == this.useManual &&
          other.useReachZones == this.useReachZones &&
          other.useActivity == this.useActivity &&
          other.activityEngine == this.activityEngine &&
          other.protocolId == this.protocolId &&
          other.userId == this.userId &&
          other.name == this.name);
}

class ObservationSessionsCompanion extends UpdateCompanion<ObservationSession> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<bool> useManual;
  final Value<bool> useReachZones;
  final Value<bool> useActivity;
  final Value<String> activityEngine;
  final Value<int?> protocolId;
  final Value<int?> userId;
  final Value<String> name;
  const ObservationSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.useManual = const Value.absent(),
    this.useReachZones = const Value.absent(),
    this.useActivity = const Value.absent(),
    this.activityEngine = const Value.absent(),
    this.protocolId = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
  });
  ObservationSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.useManual = const Value.absent(),
    this.useReachZones = const Value.absent(),
    this.useActivity = const Value.absent(),
    this.activityEngine = const Value.absent(),
    this.protocolId = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
  }) : startedAt = Value(startedAt);
  static Insertable<ObservationSession> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<bool>? useManual,
    Expression<bool>? useReachZones,
    Expression<bool>? useActivity,
    Expression<String>? activityEngine,
    Expression<int>? protocolId,
    Expression<int>? userId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (useManual != null) 'use_manual': useManual,
      if (useReachZones != null) 'use_reach_zones': useReachZones,
      if (useActivity != null) 'use_activity': useActivity,
      if (activityEngine != null) 'activity_engine': activityEngine,
      if (protocolId != null) 'protocol_id': protocolId,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
    });
  }

  ObservationSessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<bool>? useManual,
    Value<bool>? useReachZones,
    Value<bool>? useActivity,
    Value<String>? activityEngine,
    Value<int?>? protocolId,
    Value<int?>? userId,
    Value<String>? name,
  }) {
    return ObservationSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      useManual: useManual ?? this.useManual,
      useReachZones: useReachZones ?? this.useReachZones,
      useActivity: useActivity ?? this.useActivity,
      activityEngine: activityEngine ?? this.activityEngine,
      protocolId: protocolId ?? this.protocolId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (useManual.present) {
      map['use_manual'] = Variable<bool>(useManual.value);
    }
    if (useReachZones.present) {
      map['use_reach_zones'] = Variable<bool>(useReachZones.value);
    }
    if (useActivity.present) {
      map['use_activity'] = Variable<bool>(useActivity.value);
    }
    if (activityEngine.present) {
      map['activity_engine'] = Variable<String>(activityEngine.value);
    }
    if (protocolId.present) {
      map['protocol_id'] = Variable<int>(protocolId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservationSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('useManual: $useManual, ')
          ..write('useReachZones: $useReachZones, ')
          ..write('useActivity: $useActivity, ')
          ..write('activityEngine: $activityEngine, ')
          ..write('protocolId: $protocolId, ')
          ..write('userId: $userId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CountEventsTable extends CountEvents
    with TableInfo<$CountEventsTable, CountEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subclassIdMeta = const VerificationMeta(
    'subclassId',
  );
  @override
  late final GeneratedColumn<int> subclassId = GeneratedColumn<int>(
    'subclass_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observable_subclasses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, subclassId, occurredAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'count_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<CountEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('subclass_id')) {
      context.handle(
        _subclassIdMeta,
        subclassId.isAcceptableOrUnknown(data['subclass_id']!, _subclassIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subclassIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CountEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CountEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      subclassId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subclass_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $CountEventsTable createAlias(String alias) {
    return $CountEventsTable(attachedDatabase, alias);
  }
}

class CountEvent extends DataClass implements Insertable<CountEvent> {
  final int id;
  final int sessionId;
  final int subclassId;
  final DateTime occurredAt;
  const CountEvent({
    required this.id,
    required this.sessionId,
    required this.subclassId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['subclass_id'] = Variable<int>(subclassId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  CountEventsCompanion toCompanion(bool nullToAbsent) {
    return CountEventsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      subclassId: Value(subclassId),
      occurredAt: Value(occurredAt),
    );
  }

  factory CountEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CountEvent(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      subclassId: serializer.fromJson<int>(json['subclassId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'subclassId': serializer.toJson<int>(subclassId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  CountEvent copyWith({
    int? id,
    int? sessionId,
    int? subclassId,
    DateTime? occurredAt,
  }) => CountEvent(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    subclassId: subclassId ?? this.subclassId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  CountEvent copyWithCompanion(CountEventsCompanion data) {
    return CountEvent(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      subclassId: data.subclassId.present
          ? data.subclassId.value
          : this.subclassId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CountEvent(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('subclassId: $subclassId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, subclassId, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountEvent &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.subclassId == this.subclassId &&
          other.occurredAt == this.occurredAt);
}

class CountEventsCompanion extends UpdateCompanion<CountEvent> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> subclassId;
  final Value<DateTime> occurredAt;
  const CountEventsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.subclassId = const Value.absent(),
    this.occurredAt = const Value.absent(),
  });
  CountEventsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int subclassId,
    required DateTime occurredAt,
  }) : sessionId = Value(sessionId),
       subclassId = Value(subclassId),
       occurredAt = Value(occurredAt);
  static Insertable<CountEvent> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? subclassId,
    Expression<DateTime>? occurredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (subclassId != null) 'subclass_id': subclassId,
      if (occurredAt != null) 'occurred_at': occurredAt,
    });
  }

  CountEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? subclassId,
    Value<DateTime>? occurredAt,
  }) {
    return CountEventsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      subclassId: subclassId ?? this.subclassId,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (subclassId.present) {
      map['subclass_id'] = Variable<int>(subclassId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountEventsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('subclassId: $subclassId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }
}

class $DurationIntervalsTable extends DurationIntervals
    with TableInfo<$DurationIntervalsTable, DurationInterval> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DurationIntervalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subclassIdMeta = const VerificationMeta(
    'subclassId',
  );
  @override
  late final GeneratedColumn<int> subclassId = GeneratedColumn<int>(
    'subclass_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observable_subclasses (id) ON DELETE CASCADE',
    ),
  );
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    subclassId,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'duration_intervals';
  @override
  VerificationContext validateIntegrity(
    Insertable<DurationInterval> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('subclass_id')) {
      context.handle(
        _subclassIdMeta,
        subclassId.isAcceptableOrUnknown(data['subclass_id']!, _subclassIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subclassIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DurationInterval map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DurationInterval(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      subclassId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subclass_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $DurationIntervalsTable createAlias(String alias) {
    return $DurationIntervalsTable(attachedDatabase, alias);
  }
}

class DurationInterval extends DataClass
    implements Insertable<DurationInterval> {
  final int id;
  final int sessionId;
  final int subclassId;
  final DateTime startedAt;
  final DateTime? endedAt;
  const DurationInterval({
    required this.id,
    required this.sessionId,
    required this.subclassId,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['subclass_id'] = Variable<int>(subclassId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  DurationIntervalsCompanion toCompanion(bool nullToAbsent) {
    return DurationIntervalsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      subclassId: Value(subclassId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory DurationInterval.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DurationInterval(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      subclassId: serializer.fromJson<int>(json['subclassId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'subclassId': serializer.toJson<int>(subclassId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  DurationInterval copyWith({
    int? id,
    int? sessionId,
    int? subclassId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => DurationInterval(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    subclassId: subclassId ?? this.subclassId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  DurationInterval copyWithCompanion(DurationIntervalsCompanion data) {
    return DurationInterval(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      subclassId: data.subclassId.present
          ? data.subclassId.value
          : this.subclassId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DurationInterval(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('subclassId: $subclassId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, subclassId, startedAt, endedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DurationInterval &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.subclassId == this.subclassId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class DurationIntervalsCompanion extends UpdateCompanion<DurationInterval> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> subclassId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  const DurationIntervalsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.subclassId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  });
  DurationIntervalsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int subclassId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
  }) : sessionId = Value(sessionId),
       subclassId = Value(subclassId),
       startedAt = Value(startedAt);
  static Insertable<DurationInterval> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? subclassId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (subclassId != null) 'subclass_id': subclassId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
    });
  }

  DurationIntervalsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? subclassId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
  }) {
    return DurationIntervalsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      subclassId: subclassId ?? this.subclassId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (subclassId.present) {
      map['subclass_id'] = Variable<int>(subclassId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DurationIntervalsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('subclassId: $subclassId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }
}

class $LearnedActivitiesTable extends LearnedActivities
    with TableInfo<$LearnedActivitiesTable, LearnedActivity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearnedActivitiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _protocolIdMeta = const VerificationMeta(
    'protocolId',
  );
  @override
  late final GeneratedColumn<int> protocolId = GeneratedColumn<int>(
    'protocol_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_protocols (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clipPathMeta = const VerificationMeta(
    'clipPath',
  );
  @override
  late final GeneratedColumn<String> clipPath = GeneratedColumn<String>(
    'clip_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('visual'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    protocolId,
    name,
    clipPath,
    colorValue,
    sortOrder,
    createdAt,
    kind,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learned_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearnedActivity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('protocol_id')) {
      context.handle(
        _protocolIdMeta,
        protocolId.isAcceptableOrUnknown(data['protocol_id']!, _protocolIdMeta),
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
    if (data.containsKey('clip_path')) {
      context.handle(
        _clipPathMeta,
        clipPath.isAcceptableOrUnknown(data['clip_path']!, _clipPathMeta),
      );
    } else if (isInserting) {
      context.missing(_clipPathMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearnedActivity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearnedActivity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      protocolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protocol_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      clipPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clip_path'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
    );
  }

  @override
  $LearnedActivitiesTable createAlias(String alias) {
    return $LearnedActivitiesTable(attachedDatabase, alias);
  }
}

class LearnedActivity extends DataClass implements Insertable<LearnedActivity> {
  final int id;
  final int? protocolId;
  final String name;
  final String clipPath;
  final int colorValue;
  final int sortOrder;
  final DateTime createdAt;
  final String kind;
  const LearnedActivity({
    required this.id,
    this.protocolId,
    required this.name,
    required this.clipPath,
    required this.colorValue,
    required this.sortOrder,
    required this.createdAt,
    required this.kind,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || protocolId != null) {
      map['protocol_id'] = Variable<int>(protocolId);
    }
    map['name'] = Variable<String>(name);
    map['clip_path'] = Variable<String>(clipPath);
    map['color_value'] = Variable<int>(colorValue);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['kind'] = Variable<String>(kind);
    return map;
  }

  LearnedActivitiesCompanion toCompanion(bool nullToAbsent) {
    return LearnedActivitiesCompanion(
      id: Value(id),
      protocolId: protocolId == null && nullToAbsent
          ? const Value.absent()
          : Value(protocolId),
      name: Value(name),
      clipPath: Value(clipPath),
      colorValue: Value(colorValue),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      kind: Value(kind),
    );
  }

  factory LearnedActivity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearnedActivity(
      id: serializer.fromJson<int>(json['id']),
      protocolId: serializer.fromJson<int?>(json['protocolId']),
      name: serializer.fromJson<String>(json['name']),
      clipPath: serializer.fromJson<String>(json['clipPath']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      kind: serializer.fromJson<String>(json['kind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'protocolId': serializer.toJson<int?>(protocolId),
      'name': serializer.toJson<String>(name),
      'clipPath': serializer.toJson<String>(clipPath),
      'colorValue': serializer.toJson<int>(colorValue),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'kind': serializer.toJson<String>(kind),
    };
  }

  LearnedActivity copyWith({
    int? id,
    Value<int?> protocolId = const Value.absent(),
    String? name,
    String? clipPath,
    int? colorValue,
    int? sortOrder,
    DateTime? createdAt,
    String? kind,
  }) => LearnedActivity(
    id: id ?? this.id,
    protocolId: protocolId.present ? protocolId.value : this.protocolId,
    name: name ?? this.name,
    clipPath: clipPath ?? this.clipPath,
    colorValue: colorValue ?? this.colorValue,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    kind: kind ?? this.kind,
  );
  LearnedActivity copyWithCompanion(LearnedActivitiesCompanion data) {
    return LearnedActivity(
      id: data.id.present ? data.id.value : this.id,
      protocolId: data.protocolId.present
          ? data.protocolId.value
          : this.protocolId,
      name: data.name.present ? data.name.value : this.name,
      clipPath: data.clipPath.present ? data.clipPath.value : this.clipPath,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearnedActivity(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('name: $name, ')
          ..write('clipPath: $clipPath, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    protocolId,
    name,
    clipPath,
    colorValue,
    sortOrder,
    createdAt,
    kind,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearnedActivity &&
          other.id == this.id &&
          other.protocolId == this.protocolId &&
          other.name == this.name &&
          other.clipPath == this.clipPath &&
          other.colorValue == this.colorValue &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.kind == this.kind);
}

class LearnedActivitiesCompanion extends UpdateCompanion<LearnedActivity> {
  final Value<int> id;
  final Value<int?> protocolId;
  final Value<String> name;
  final Value<String> clipPath;
  final Value<int> colorValue;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<String> kind;
  const LearnedActivitiesCompanion({
    this.id = const Value.absent(),
    this.protocolId = const Value.absent(),
    this.name = const Value.absent(),
    this.clipPath = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.kind = const Value.absent(),
  });
  LearnedActivitiesCompanion.insert({
    this.id = const Value.absent(),
    this.protocolId = const Value.absent(),
    required String name,
    required String clipPath,
    required int colorValue,
    required int sortOrder,
    required DateTime createdAt,
    this.kind = const Value.absent(),
  }) : name = Value(name),
       clipPath = Value(clipPath),
       colorValue = Value(colorValue),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt);
  static Insertable<LearnedActivity> custom({
    Expression<int>? id,
    Expression<int>? protocolId,
    Expression<String>? name,
    Expression<String>? clipPath,
    Expression<int>? colorValue,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<String>? kind,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (protocolId != null) 'protocol_id': protocolId,
      if (name != null) 'name': name,
      if (clipPath != null) 'clip_path': clipPath,
      if (colorValue != null) 'color_value': colorValue,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (kind != null) 'kind': kind,
    });
  }

  LearnedActivitiesCompanion copyWith({
    Value<int>? id,
    Value<int?>? protocolId,
    Value<String>? name,
    Value<String>? clipPath,
    Value<int>? colorValue,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<String>? kind,
  }) {
    return LearnedActivitiesCompanion(
      id: id ?? this.id,
      protocolId: protocolId ?? this.protocolId,
      name: name ?? this.name,
      clipPath: clipPath ?? this.clipPath,
      colorValue: colorValue ?? this.colorValue,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      kind: kind ?? this.kind,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (protocolId.present) {
      map['protocol_id'] = Variable<int>(protocolId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (clipPath.present) {
      map['clip_path'] = Variable<String>(clipPath.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearnedActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('name: $name, ')
          ..write('clipPath: $clipPath, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }
}

class $ActivityEventsTable extends ActivityEvents
    with TableInfo<$ActivityEventsTable, ActivityEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learned_activities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, activityId, occurredAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activity_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $ActivityEventsTable createAlias(String alias) {
    return $ActivityEventsTable(attachedDatabase, alias);
  }
}

class ActivityEvent extends DataClass implements Insertable<ActivityEvent> {
  final int id;
  final int sessionId;
  final int activityId;
  final DateTime occurredAt;
  const ActivityEvent({
    required this.id,
    required this.sessionId,
    required this.activityId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['activity_id'] = Variable<int>(activityId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  ActivityEventsCompanion toCompanion(bool nullToAbsent) {
    return ActivityEventsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      activityId: Value(activityId),
      occurredAt: Value(occurredAt),
    );
  }

  factory ActivityEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityEvent(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      activityId: serializer.fromJson<int>(json['activityId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'activityId': serializer.toJson<int>(activityId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  ActivityEvent copyWith({
    int? id,
    int? sessionId,
    int? activityId,
    DateTime? occurredAt,
  }) => ActivityEvent(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    activityId: activityId ?? this.activityId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  ActivityEvent copyWithCompanion(ActivityEventsCompanion data) {
    return ActivityEvent(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEvent(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('activityId: $activityId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, activityId, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityEvent &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.activityId == this.activityId &&
          other.occurredAt == this.occurredAt);
}

class ActivityEventsCompanion extends UpdateCompanion<ActivityEvent> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> activityId;
  final Value<DateTime> occurredAt;
  const ActivityEventsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.occurredAt = const Value.absent(),
  });
  ActivityEventsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int activityId,
    required DateTime occurredAt,
  }) : sessionId = Value(sessionId),
       activityId = Value(activityId),
       occurredAt = Value(occurredAt);
  static Insertable<ActivityEvent> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? activityId,
    Expression<DateTime>? occurredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (activityId != null) 'activity_id': activityId,
      if (occurredAt != null) 'occurred_at': occurredAt,
    });
  }

  ActivityEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? activityId,
    Value<DateTime>? occurredAt,
  }) {
    return ActivityEventsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      activityId: activityId ?? this.activityId,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEventsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('activityId: $activityId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }
}

class $ActivityIntervalsTable extends ActivityIntervals
    with TableInfo<$ActivityIntervalsTable, ActivityInterval> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityIntervalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learned_activities (id) ON DELETE CASCADE',
    ),
  );
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    activityId,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_intervals';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityInterval> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityInterval map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityInterval(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activity_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $ActivityIntervalsTable createAlias(String alias) {
    return $ActivityIntervalsTable(attachedDatabase, alias);
  }
}

class ActivityInterval extends DataClass
    implements Insertable<ActivityInterval> {
  final int id;
  final int sessionId;
  final int activityId;
  final DateTime startedAt;
  final DateTime? endedAt;
  const ActivityInterval({
    required this.id,
    required this.sessionId,
    required this.activityId,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['activity_id'] = Variable<int>(activityId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  ActivityIntervalsCompanion toCompanion(bool nullToAbsent) {
    return ActivityIntervalsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      activityId: Value(activityId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory ActivityInterval.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityInterval(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      activityId: serializer.fromJson<int>(json['activityId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'activityId': serializer.toJson<int>(activityId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  ActivityInterval copyWith({
    int? id,
    int? sessionId,
    int? activityId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => ActivityInterval(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    activityId: activityId ?? this.activityId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  ActivityInterval copyWithCompanion(ActivityIntervalsCompanion data) {
    return ActivityInterval(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityInterval(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('activityId: $activityId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, activityId, startedAt, endedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityInterval &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.activityId == this.activityId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class ActivityIntervalsCompanion extends UpdateCompanion<ActivityInterval> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> activityId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  const ActivityIntervalsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  });
  ActivityIntervalsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int activityId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
  }) : sessionId = Value(sessionId),
       activityId = Value(activityId),
       startedAt = Value(startedAt);
  static Insertable<ActivityInterval> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? activityId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (activityId != null) 'activity_id': activityId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
    });
  }

  ActivityIntervalsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? activityId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
  }) {
    return ActivityIntervalsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      activityId: activityId ?? this.activityId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityIntervalsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('activityId: $activityId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }
}

class $ActivityEmbeddingsTable extends ActivityEmbeddings
    with TableInfo<$ActivityEmbeddingsTable, ActivityEmbedding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityEmbeddingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learned_activities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _vectorMeta = const VerificationMeta('vector');
  @override
  late final GeneratedColumn<Uint8List> vector = GeneratedColumn<Uint8List>(
    'vector',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, activityId, vector];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_embeddings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityEmbedding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('vector')) {
      context.handle(
        _vectorMeta,
        vector.isAcceptableOrUnknown(data['vector']!, _vectorMeta),
      );
    } else if (isInserting) {
      context.missing(_vectorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityEmbedding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityEmbedding(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activity_id'],
      )!,
      vector: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}vector'],
      )!,
    );
  }

  @override
  $ActivityEmbeddingsTable createAlias(String alias) {
    return $ActivityEmbeddingsTable(attachedDatabase, alias);
  }
}

class ActivityEmbedding extends DataClass
    implements Insertable<ActivityEmbedding> {
  final int id;
  final int activityId;
  final Uint8List vector;
  const ActivityEmbedding({
    required this.id,
    required this.activityId,
    required this.vector,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['activity_id'] = Variable<int>(activityId);
    map['vector'] = Variable<Uint8List>(vector);
    return map;
  }

  ActivityEmbeddingsCompanion toCompanion(bool nullToAbsent) {
    return ActivityEmbeddingsCompanion(
      id: Value(id),
      activityId: Value(activityId),
      vector: Value(vector),
    );
  }

  factory ActivityEmbedding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityEmbedding(
      id: serializer.fromJson<int>(json['id']),
      activityId: serializer.fromJson<int>(json['activityId']),
      vector: serializer.fromJson<Uint8List>(json['vector']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'activityId': serializer.toJson<int>(activityId),
      'vector': serializer.toJson<Uint8List>(vector),
    };
  }

  ActivityEmbedding copyWith({int? id, int? activityId, Uint8List? vector}) =>
      ActivityEmbedding(
        id: id ?? this.id,
        activityId: activityId ?? this.activityId,
        vector: vector ?? this.vector,
      );
  ActivityEmbedding copyWithCompanion(ActivityEmbeddingsCompanion data) {
    return ActivityEmbedding(
      id: data.id.present ? data.id.value : this.id,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      vector: data.vector.present ? data.vector.value : this.vector,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEmbedding(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('vector: $vector')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, activityId, $driftBlobEquality.hash(vector));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityEmbedding &&
          other.id == this.id &&
          other.activityId == this.activityId &&
          $driftBlobEquality.equals(other.vector, this.vector));
}

class ActivityEmbeddingsCompanion extends UpdateCompanion<ActivityEmbedding> {
  final Value<int> id;
  final Value<int> activityId;
  final Value<Uint8List> vector;
  const ActivityEmbeddingsCompanion({
    this.id = const Value.absent(),
    this.activityId = const Value.absent(),
    this.vector = const Value.absent(),
  });
  ActivityEmbeddingsCompanion.insert({
    this.id = const Value.absent(),
    required int activityId,
    required Uint8List vector,
  }) : activityId = Value(activityId),
       vector = Value(vector);
  static Insertable<ActivityEmbedding> custom({
    Expression<int>? id,
    Expression<int>? activityId,
    Expression<Uint8List>? vector,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityId != null) 'activity_id': activityId,
      if (vector != null) 'vector': vector,
    });
  }

  ActivityEmbeddingsCompanion copyWith({
    Value<int>? id,
    Value<int>? activityId,
    Value<Uint8List>? vector,
  }) {
    return ActivityEmbeddingsCompanion(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      vector: vector ?? this.vector,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (vector.present) {
      map['vector'] = Variable<Uint8List>(vector.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEmbeddingsCompanion(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('vector: $vector')
          ..write(')'))
        .toString();
  }
}

class $ReachZoneRecipesTable extends ReachZoneRecipes
    with TableInfo<$ReachZoneRecipesTable, ReachZoneRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReachZoneRecipesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _protocolIdMeta = const VerificationMeta(
    'protocolId',
  );
  @override
  late final GeneratedColumn<int> protocolId = GeneratedColumn<int>(
    'protocol_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_protocols (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _jointMeta = const VerificationMeta('joint');
  @override
  late final GeneratedColumn<String> joint = GeneratedColumn<String>(
    'joint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _validateAngleMeta = const VerificationMeta(
    'validateAngle',
  );
  @override
  late final GeneratedColumn<double> validateAngle = GeneratedColumn<double>(
    'validate_angle',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(90),
  );
  static const VerificationMeta _zoneMinMeta = const VerificationMeta(
    'zoneMin',
  );
  @override
  late final GeneratedColumn<double> zoneMin = GeneratedColumn<double>(
    'zone_min',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _zoneMaxMeta = const VerificationMeta(
    'zoneMax',
  );
  @override
  late final GeneratedColumn<double> zoneMax = GeneratedColumn<double>(
    'zone_max',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    protocolId,
    joint,
    kind,
    validateAngle,
    zoneMin,
    zoneMax,
    colorValue,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reach_zone_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReachZoneRecipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('protocol_id')) {
      context.handle(
        _protocolIdMeta,
        protocolId.isAcceptableOrUnknown(data['protocol_id']!, _protocolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_protocolIdMeta);
    }
    if (data.containsKey('joint')) {
      context.handle(
        _jointMeta,
        joint.isAcceptableOrUnknown(data['joint']!, _jointMeta),
      );
    } else if (isInserting) {
      context.missing(_jointMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('validate_angle')) {
      context.handle(
        _validateAngleMeta,
        validateAngle.isAcceptableOrUnknown(
          data['validate_angle']!,
          _validateAngleMeta,
        ),
      );
    }
    if (data.containsKey('zone_min')) {
      context.handle(
        _zoneMinMeta,
        zoneMin.isAcceptableOrUnknown(data['zone_min']!, _zoneMinMeta),
      );
    }
    if (data.containsKey('zone_max')) {
      context.handle(
        _zoneMaxMeta,
        zoneMax.isAcceptableOrUnknown(data['zone_max']!, _zoneMaxMeta),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReachZoneRecipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReachZoneRecipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      protocolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protocol_id'],
      )!,
      joint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}joint'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      validateAngle: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}validate_angle'],
      )!,
      zoneMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}zone_min'],
      ),
      zoneMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}zone_max'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ReachZoneRecipesTable createAlias(String alias) {
    return $ReachZoneRecipesTable(attachedDatabase, alias);
  }
}

class ReachZoneRecipe extends DataClass implements Insertable<ReachZoneRecipe> {
  final int id;
  final int protocolId;
  final String joint;
  final String kind;
  final double validateAngle;
  final double? zoneMin;
  final double? zoneMax;
  final int colorValue;
  final int sortOrder;
  const ReachZoneRecipe({
    required this.id,
    required this.protocolId,
    required this.joint,
    required this.kind,
    required this.validateAngle,
    this.zoneMin,
    this.zoneMax,
    required this.colorValue,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['protocol_id'] = Variable<int>(protocolId);
    map['joint'] = Variable<String>(joint);
    map['kind'] = Variable<String>(kind);
    map['validate_angle'] = Variable<double>(validateAngle);
    if (!nullToAbsent || zoneMin != null) {
      map['zone_min'] = Variable<double>(zoneMin);
    }
    if (!nullToAbsent || zoneMax != null) {
      map['zone_max'] = Variable<double>(zoneMax);
    }
    map['color_value'] = Variable<int>(colorValue);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ReachZoneRecipesCompanion toCompanion(bool nullToAbsent) {
    return ReachZoneRecipesCompanion(
      id: Value(id),
      protocolId: Value(protocolId),
      joint: Value(joint),
      kind: Value(kind),
      validateAngle: Value(validateAngle),
      zoneMin: zoneMin == null && nullToAbsent
          ? const Value.absent()
          : Value(zoneMin),
      zoneMax: zoneMax == null && nullToAbsent
          ? const Value.absent()
          : Value(zoneMax),
      colorValue: Value(colorValue),
      sortOrder: Value(sortOrder),
    );
  }

  factory ReachZoneRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReachZoneRecipe(
      id: serializer.fromJson<int>(json['id']),
      protocolId: serializer.fromJson<int>(json['protocolId']),
      joint: serializer.fromJson<String>(json['joint']),
      kind: serializer.fromJson<String>(json['kind']),
      validateAngle: serializer.fromJson<double>(json['validateAngle']),
      zoneMin: serializer.fromJson<double?>(json['zoneMin']),
      zoneMax: serializer.fromJson<double?>(json['zoneMax']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'protocolId': serializer.toJson<int>(protocolId),
      'joint': serializer.toJson<String>(joint),
      'kind': serializer.toJson<String>(kind),
      'validateAngle': serializer.toJson<double>(validateAngle),
      'zoneMin': serializer.toJson<double?>(zoneMin),
      'zoneMax': serializer.toJson<double?>(zoneMax),
      'colorValue': serializer.toJson<int>(colorValue),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ReachZoneRecipe copyWith({
    int? id,
    int? protocolId,
    String? joint,
    String? kind,
    double? validateAngle,
    Value<double?> zoneMin = const Value.absent(),
    Value<double?> zoneMax = const Value.absent(),
    int? colorValue,
    int? sortOrder,
  }) => ReachZoneRecipe(
    id: id ?? this.id,
    protocolId: protocolId ?? this.protocolId,
    joint: joint ?? this.joint,
    kind: kind ?? this.kind,
    validateAngle: validateAngle ?? this.validateAngle,
    zoneMin: zoneMin.present ? zoneMin.value : this.zoneMin,
    zoneMax: zoneMax.present ? zoneMax.value : this.zoneMax,
    colorValue: colorValue ?? this.colorValue,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ReachZoneRecipe copyWithCompanion(ReachZoneRecipesCompanion data) {
    return ReachZoneRecipe(
      id: data.id.present ? data.id.value : this.id,
      protocolId: data.protocolId.present
          ? data.protocolId.value
          : this.protocolId,
      joint: data.joint.present ? data.joint.value : this.joint,
      kind: data.kind.present ? data.kind.value : this.kind,
      validateAngle: data.validateAngle.present
          ? data.validateAngle.value
          : this.validateAngle,
      zoneMin: data.zoneMin.present ? data.zoneMin.value : this.zoneMin,
      zoneMax: data.zoneMax.present ? data.zoneMax.value : this.zoneMax,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReachZoneRecipe(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('joint: $joint, ')
          ..write('kind: $kind, ')
          ..write('validateAngle: $validateAngle, ')
          ..write('zoneMin: $zoneMin, ')
          ..write('zoneMax: $zoneMax, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    protocolId,
    joint,
    kind,
    validateAngle,
    zoneMin,
    zoneMax,
    colorValue,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReachZoneRecipe &&
          other.id == this.id &&
          other.protocolId == this.protocolId &&
          other.joint == this.joint &&
          other.kind == this.kind &&
          other.validateAngle == this.validateAngle &&
          other.zoneMin == this.zoneMin &&
          other.zoneMax == this.zoneMax &&
          other.colorValue == this.colorValue &&
          other.sortOrder == this.sortOrder);
}

class ReachZoneRecipesCompanion extends UpdateCompanion<ReachZoneRecipe> {
  final Value<int> id;
  final Value<int> protocolId;
  final Value<String> joint;
  final Value<String> kind;
  final Value<double> validateAngle;
  final Value<double?> zoneMin;
  final Value<double?> zoneMax;
  final Value<int> colorValue;
  final Value<int> sortOrder;
  const ReachZoneRecipesCompanion({
    this.id = const Value.absent(),
    this.protocolId = const Value.absent(),
    this.joint = const Value.absent(),
    this.kind = const Value.absent(),
    this.validateAngle = const Value.absent(),
    this.zoneMin = const Value.absent(),
    this.zoneMax = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ReachZoneRecipesCompanion.insert({
    this.id = const Value.absent(),
    required int protocolId,
    required String joint,
    required String kind,
    this.validateAngle = const Value.absent(),
    this.zoneMin = const Value.absent(),
    this.zoneMax = const Value.absent(),
    required int colorValue,
    required int sortOrder,
  }) : protocolId = Value(protocolId),
       joint = Value(joint),
       kind = Value(kind),
       colorValue = Value(colorValue),
       sortOrder = Value(sortOrder);
  static Insertable<ReachZoneRecipe> custom({
    Expression<int>? id,
    Expression<int>? protocolId,
    Expression<String>? joint,
    Expression<String>? kind,
    Expression<double>? validateAngle,
    Expression<double>? zoneMin,
    Expression<double>? zoneMax,
    Expression<int>? colorValue,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (protocolId != null) 'protocol_id': protocolId,
      if (joint != null) 'joint': joint,
      if (kind != null) 'kind': kind,
      if (validateAngle != null) 'validate_angle': validateAngle,
      if (zoneMin != null) 'zone_min': zoneMin,
      if (zoneMax != null) 'zone_max': zoneMax,
      if (colorValue != null) 'color_value': colorValue,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ReachZoneRecipesCompanion copyWith({
    Value<int>? id,
    Value<int>? protocolId,
    Value<String>? joint,
    Value<String>? kind,
    Value<double>? validateAngle,
    Value<double?>? zoneMin,
    Value<double?>? zoneMax,
    Value<int>? colorValue,
    Value<int>? sortOrder,
  }) {
    return ReachZoneRecipesCompanion(
      id: id ?? this.id,
      protocolId: protocolId ?? this.protocolId,
      joint: joint ?? this.joint,
      kind: kind ?? this.kind,
      validateAngle: validateAngle ?? this.validateAngle,
      zoneMin: zoneMin ?? this.zoneMin,
      zoneMax: zoneMax ?? this.zoneMax,
      colorValue: colorValue ?? this.colorValue,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (protocolId.present) {
      map['protocol_id'] = Variable<int>(protocolId.value);
    }
    if (joint.present) {
      map['joint'] = Variable<String>(joint.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (validateAngle.present) {
      map['validate_angle'] = Variable<double>(validateAngle.value);
    }
    if (zoneMin.present) {
      map['zone_min'] = Variable<double>(zoneMin.value);
    }
    if (zoneMax.present) {
      map['zone_max'] = Variable<double>(zoneMax.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReachZoneRecipesCompanion(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('joint: $joint, ')
          ..write('kind: $kind, ')
          ..write('validateAngle: $validateAngle, ')
          ..write('zoneMin: $zoneMin, ')
          ..write('zoneMax: $zoneMax, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ReachZoneIntervalsTable extends ReachZoneIntervals
    with TableInfo<$ReachZoneIntervalsTable, ReachZoneInterval> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReachZoneIntervalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES observation_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reach_zone_recipes (id) ON DELETE CASCADE',
    ),
  );
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    recipeId,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reach_zone_intervals';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReachZoneInterval> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReachZoneInterval map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReachZoneInterval(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $ReachZoneIntervalsTable createAlias(String alias) {
    return $ReachZoneIntervalsTable(attachedDatabase, alias);
  }
}

class ReachZoneInterval extends DataClass
    implements Insertable<ReachZoneInterval> {
  final int id;
  final int sessionId;
  final int recipeId;
  final DateTime startedAt;
  final DateTime? endedAt;
  const ReachZoneInterval({
    required this.id,
    required this.sessionId,
    required this.recipeId,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['recipe_id'] = Variable<int>(recipeId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  ReachZoneIntervalsCompanion toCompanion(bool nullToAbsent) {
    return ReachZoneIntervalsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      recipeId: Value(recipeId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory ReachZoneInterval.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReachZoneInterval(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'recipeId': serializer.toJson<int>(recipeId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  ReachZoneInterval copyWith({
    int? id,
    int? sessionId,
    int? recipeId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => ReachZoneInterval(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    recipeId: recipeId ?? this.recipeId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  ReachZoneInterval copyWithCompanion(ReachZoneIntervalsCompanion data) {
    return ReachZoneInterval(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReachZoneInterval(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('recipeId: $recipeId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, recipeId, startedAt, endedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReachZoneInterval &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.recipeId == this.recipeId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class ReachZoneIntervalsCompanion extends UpdateCompanion<ReachZoneInterval> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> recipeId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  const ReachZoneIntervalsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  });
  ReachZoneIntervalsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int recipeId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
  }) : sessionId = Value(sessionId),
       recipeId = Value(recipeId),
       startedAt = Value(startedAt);
  static Insertable<ReachZoneInterval> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? recipeId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (recipeId != null) 'recipe_id': recipeId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
    });
  }

  ReachZoneIntervalsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? recipeId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
  }) {
    return ReachZoneIntervalsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      recipeId: recipeId ?? this.recipeId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReachZoneIntervalsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('recipeId: $recipeId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppUsersTable appUsers = $AppUsersTable(this);
  late final $ObservationProtocolsTable observationProtocols =
      $ObservationProtocolsTable(this);
  late final $ObservableClassesTable observableClasses =
      $ObservableClassesTable(this);
  late final $ObservableSubclassesTable observableSubclasses =
      $ObservableSubclassesTable(this);
  late final $ObservationSessionsTable observationSessions =
      $ObservationSessionsTable(this);
  late final $CountEventsTable countEvents = $CountEventsTable(this);
  late final $DurationIntervalsTable durationIntervals =
      $DurationIntervalsTable(this);
  late final $LearnedActivitiesTable learnedActivities =
      $LearnedActivitiesTable(this);
  late final $ActivityEventsTable activityEvents = $ActivityEventsTable(this);
  late final $ActivityIntervalsTable activityIntervals =
      $ActivityIntervalsTable(this);
  late final $ActivityEmbeddingsTable activityEmbeddings =
      $ActivityEmbeddingsTable(this);
  late final $ReachZoneRecipesTable reachZoneRecipes = $ReachZoneRecipesTable(
    this,
  );
  late final $ReachZoneIntervalsTable reachZoneIntervals =
      $ReachZoneIntervalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appUsers,
    observationProtocols,
    observableClasses,
    observableSubclasses,
    observationSessions,
    countEvents,
    durationIntervals,
    learnedActivities,
    activityEvents,
    activityIntervals,
    activityEmbeddings,
    reachZoneRecipes,
    reachZoneIntervals,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'app_users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('observation_protocols', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_protocols',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('observable_classes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observable_classes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('observable_subclasses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_protocols',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('observation_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'app_users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('observation_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('count_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observable_subclasses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('count_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('duration_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observable_subclasses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('duration_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_protocols',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('learned_activities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activity_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learned_activities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activity_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activity_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learned_activities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activity_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learned_activities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activity_embeddings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_protocols',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reach_zone_recipes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'observation_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reach_zone_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reach_zone_recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reach_zone_intervals', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AppUsersTableCreateCompanionBuilder =
    AppUsersCompanion Function({
      Value<int> id,
      required String username,
      required String passwordHash,
      required String salt,
      required DateTime createdAt,
    });
typedef $$AppUsersTableUpdateCompanionBuilder =
    AppUsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> passwordHash,
      Value<String> salt,
      Value<DateTime> createdAt,
    });

final class $$AppUsersTableReferences
    extends BaseReferences<_$AppDatabase, $AppUsersTable, AppUser> {
  $$AppUsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ObservationProtocolsTable,
    List<ObservationProtocol>
  >
  _observationProtocolsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.observationProtocols,
        aliasName: 'app_users__id__observation_protocols__user_id',
      );

  $$ObservationProtocolsTableProcessedTableManager
  get observationProtocolsRefs {
    final manager = $$ObservationProtocolsTableTableManager(
      $_db,
      $_db.observationProtocols,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _observationProtocolsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ObservationSessionsTable,
    List<ObservationSession>
  >
  _observationSessionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.observationSessions,
        aliasName: 'app_users__id__observation_sessions__user_id',
      );

  $$ObservationSessionsTableProcessedTableManager get observationSessionsRefs {
    final manager = $$ObservationSessionsTableTableManager(
      $_db,
      $_db.observationSessions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _observationSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AppUsersTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableFilterComposer({
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

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> observationProtocolsRefs(
    Expression<bool> Function($$ObservationProtocolsTableFilterComposer f) f,
  ) {
    final $$ObservationProtocolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observationProtocols,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationProtocolsTableFilterComposer(
            $db: $db,
            $table: $db.observationProtocols,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> observationSessionsRefs(
    Expression<bool> Function($$ObservationSessionsTableFilterComposer f) f,
  ) {
    final $$ObservationSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observationSessions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationSessionsTableFilterComposer(
            $db: $db,
            $table: $db.observationSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableOrderingComposer({
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

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> observationProtocolsRefs<T extends Object>(
    Expression<T> Function($$ObservationProtocolsTableAnnotationComposer a) f,
  ) {
    final $$ObservationProtocolsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> observationSessionsRefs<T extends Object>(
    Expression<T> Function($$ObservationSessionsTableAnnotationComposer a) f,
  ) {
    final $$ObservationSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AppUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppUsersTable,
          AppUser,
          $$AppUsersTableFilterComposer,
          $$AppUsersTableOrderingComposer,
          $$AppUsersTableAnnotationComposer,
          $$AppUsersTableCreateCompanionBuilder,
          $$AppUsersTableUpdateCompanionBuilder,
          (AppUser, $$AppUsersTableReferences),
          AppUser,
          PrefetchHooks Function({
            bool observationProtocolsRefs,
            bool observationSessionsRefs,
          })
        > {
  $$AppUsersTableTableManager(_$AppDatabase db, $AppUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> salt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AppUsersCompanion(
                id: id,
                username: username,
                passwordHash: passwordHash,
                salt: salt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String passwordHash,
                required String salt,
                required DateTime createdAt,
              }) => AppUsersCompanion.insert(
                id: id,
                username: username,
                passwordHash: passwordHash,
                salt: salt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppUsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                observationProtocolsRefs = false,
                observationSessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (observationProtocolsRefs) db.observationProtocols,
                    if (observationSessionsRefs) db.observationSessions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (observationProtocolsRefs)
                        await $_getPrefetchedData<
                          AppUser,
                          $AppUsersTable,
                          ObservationProtocol
                        >(
                          currentTable: table,
                          referencedTable: $$AppUsersTableReferences
                              ._observationProtocolsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).observationProtocolsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (observationSessionsRefs)
                        await $_getPrefetchedData<
                          AppUser,
                          $AppUsersTable,
                          ObservationSession
                        >(
                          currentTable: table,
                          referencedTable: $$AppUsersTableReferences
                              ._observationSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).observationSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
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

typedef $$AppUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppUsersTable,
      AppUser,
      $$AppUsersTableFilterComposer,
      $$AppUsersTableOrderingComposer,
      $$AppUsersTableAnnotationComposer,
      $$AppUsersTableCreateCompanionBuilder,
      $$AppUsersTableUpdateCompanionBuilder,
      (AppUser, $$AppUsersTableReferences),
      AppUser,
      PrefetchHooks Function({
        bool observationProtocolsRefs,
        bool observationSessionsRefs,
      })
    >;
typedef $$ObservationProtocolsTableCreateCompanionBuilder =
    ObservationProtocolsCompanion Function({
      Value<int> id,
      required int userId,
      required String name,
      Value<bool> useManual,
      Value<bool> useReachZones,
      Value<bool> useActivity,
      Value<String> activityEngine,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ObservationProtocolsTableUpdateCompanionBuilder =
    ObservationProtocolsCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> name,
      Value<bool> useManual,
      Value<bool> useReachZones,
      Value<bool> useActivity,
      Value<String> activityEngine,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ObservationProtocolsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ObservationProtocolsTable,
          ObservationProtocol
        > {
  $$ObservationProtocolsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AppUsersTable _userIdTable(_$AppDatabase db) =>
      db.appUsers.createAlias('observation_protocols__user_id__app_users__id');

  $$AppUsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$AppUsersTableTableManager(
      $_db,
      $_db.appUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ObservableClassesTable,
    List<ObservableClassesData>
  >
  _observableClassesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.observableClasses,
        aliasName: 'observation_protocols__id__observable_classes__protocol_id',
      );

  $$ObservableClassesTableProcessedTableManager get observableClassesRefs {
    final manager = $$ObservableClassesTableTableManager(
      $_db,
      $_db.observableClasses,
    ).filter((f) => f.protocolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _observableClassesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ObservationSessionsTable,
    List<ObservationSession>
  >
  _observationSessionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.observationSessions,
        aliasName:
            'observation_protocols__id__observation_sessions__protocol_id',
      );

  $$ObservationSessionsTableProcessedTableManager get observationSessionsRefs {
    final manager = $$ObservationSessionsTableTableManager(
      $_db,
      $_db.observationSessions,
    ).filter((f) => f.protocolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _observationSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LearnedActivitiesTable, List<LearnedActivity>>
  _learnedActivitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.learnedActivities,
        aliasName: 'observation_protocols__id__learned_activities__protocol_id',
      );

  $$LearnedActivitiesTableProcessedTableManager get learnedActivitiesRefs {
    final manager = $$LearnedActivitiesTableTableManager(
      $_db,
      $_db.learnedActivities,
    ).filter((f) => f.protocolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learnedActivitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReachZoneRecipesTable, List<ReachZoneRecipe>>
  _reachZoneRecipesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reachZoneRecipes,
    aliasName: 'observation_protocols__id__reach_zone_recipes__protocol_id',
  );

  $$ReachZoneRecipesTableProcessedTableManager get reachZoneRecipesRefs {
    final manager = $$ReachZoneRecipesTableTableManager(
      $_db,
      $_db.reachZoneRecipes,
    ).filter((f) => f.protocolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reachZoneRecipesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ObservationProtocolsTableFilterComposer
    extends Composer<_$AppDatabase, $ObservationProtocolsTable> {
  $$ObservationProtocolsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useManual => $composableBuilder(
    column: $table.useManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useReachZones => $composableBuilder(
    column: $table.useReachZones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useActivity => $composableBuilder(
    column: $table.useActivity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityEngine => $composableBuilder(
    column: $table.activityEngine,
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

  $$AppUsersTableFilterComposer get userId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableFilterComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> observableClassesRefs(
    Expression<bool> Function($$ObservableClassesTableFilterComposer f) f,
  ) {
    final $$ObservableClassesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observableClasses,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservableClassesTableFilterComposer(
            $db: $db,
            $table: $db.observableClasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> observationSessionsRefs(
    Expression<bool> Function($$ObservationSessionsTableFilterComposer f) f,
  ) {
    final $$ObservationSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observationSessions,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationSessionsTableFilterComposer(
            $db: $db,
            $table: $db.observationSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> learnedActivitiesRefs(
    Expression<bool> Function($$LearnedActivitiesTableFilterComposer f) f,
  ) {
    final $$LearnedActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learnedActivities,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.learnedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reachZoneRecipesRefs(
    Expression<bool> Function($$ReachZoneRecipesTableFilterComposer f) f,
  ) {
    final $$ReachZoneRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reachZoneRecipes,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReachZoneRecipesTableFilterComposer(
            $db: $db,
            $table: $db.reachZoneRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ObservationProtocolsTableOrderingComposer
    extends Composer<_$AppDatabase, $ObservationProtocolsTable> {
  $$ObservationProtocolsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useManual => $composableBuilder(
    column: $table.useManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useReachZones => $composableBuilder(
    column: $table.useReachZones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useActivity => $composableBuilder(
    column: $table.useActivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityEngine => $composableBuilder(
    column: $table.activityEngine,
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

  $$AppUsersTableOrderingComposer get userId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableOrderingComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationProtocolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObservationProtocolsTable> {
  $$ObservationProtocolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get useManual =>
      $composableBuilder(column: $table.useManual, builder: (column) => column);

  GeneratedColumn<bool> get useReachZones => $composableBuilder(
    column: $table.useReachZones,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get useActivity => $composableBuilder(
    column: $table.useActivity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityEngine => $composableBuilder(
    column: $table.activityEngine,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AppUsersTableAnnotationComposer get userId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> observableClassesRefs<T extends Object>(
    Expression<T> Function($$ObservableClassesTableAnnotationComposer a) f,
  ) {
    final $$ObservableClassesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.observableClasses,
          getReferencedColumn: (t) => t.protocolId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservableClassesTableAnnotationComposer(
                $db: $db,
                $table: $db.observableClasses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> observationSessionsRefs<T extends Object>(
    Expression<T> Function($$ObservationSessionsTableAnnotationComposer a) f,
  ) {
    final $$ObservationSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.protocolId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> learnedActivitiesRefs<T extends Object>(
    Expression<T> Function($$LearnedActivitiesTableAnnotationComposer a) f,
  ) {
    final $$LearnedActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.learnedActivities,
          getReferencedColumn: (t) => t.protocolId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearnedActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.learnedActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> reachZoneRecipesRefs<T extends Object>(
    Expression<T> Function($$ReachZoneRecipesTableAnnotationComposer a) f,
  ) {
    final $$ReachZoneRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reachZoneRecipes,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReachZoneRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.reachZoneRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ObservationProtocolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObservationProtocolsTable,
          ObservationProtocol,
          $$ObservationProtocolsTableFilterComposer,
          $$ObservationProtocolsTableOrderingComposer,
          $$ObservationProtocolsTableAnnotationComposer,
          $$ObservationProtocolsTableCreateCompanionBuilder,
          $$ObservationProtocolsTableUpdateCompanionBuilder,
          (ObservationProtocol, $$ObservationProtocolsTableReferences),
          ObservationProtocol,
          PrefetchHooks Function({
            bool userId,
            bool observableClassesRefs,
            bool observationSessionsRefs,
            bool learnedActivitiesRefs,
            bool reachZoneRecipesRefs,
          })
        > {
  $$ObservationProtocolsTableTableManager(
    _$AppDatabase db,
    $ObservationProtocolsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObservationProtocolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObservationProtocolsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ObservationProtocolsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> useManual = const Value.absent(),
                Value<bool> useReachZones = const Value.absent(),
                Value<bool> useActivity = const Value.absent(),
                Value<String> activityEngine = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ObservationProtocolsCompanion(
                id: id,
                userId: userId,
                name: name,
                useManual: useManual,
                useReachZones: useReachZones,
                useActivity: useActivity,
                activityEngine: activityEngine,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String name,
                Value<bool> useManual = const Value.absent(),
                Value<bool> useReachZones = const Value.absent(),
                Value<bool> useActivity = const Value.absent(),
                Value<String> activityEngine = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ObservationProtocolsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                useManual: useManual,
                useReachZones: useReachZones,
                useActivity: useActivity,
                activityEngine: activityEngine,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ObservationProtocolsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                observableClassesRefs = false,
                observationSessionsRefs = false,
                learnedActivitiesRefs = false,
                reachZoneRecipesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (observableClassesRefs) db.observableClasses,
                    if (observationSessionsRefs) db.observationSessions,
                    if (learnedActivitiesRefs) db.learnedActivities,
                    if (reachZoneRecipesRefs) db.reachZoneRecipes,
                  ],
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
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable:
                                        $$ObservationProtocolsTableReferences
                                            ._userIdTable(db),
                                    referencedColumn:
                                        $$ObservationProtocolsTableReferences
                                            ._userIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (observableClassesRefs)
                        await $_getPrefetchedData<
                          ObservationProtocol,
                          $ObservationProtocolsTable,
                          ObservableClassesData
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationProtocolsTableReferences
                              ._observableClassesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationProtocolsTableReferences(
                                db,
                                table,
                                p0,
                              ).observableClassesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.protocolId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (observationSessionsRefs)
                        await $_getPrefetchedData<
                          ObservationProtocol,
                          $ObservationProtocolsTable,
                          ObservationSession
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationProtocolsTableReferences
                              ._observationSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationProtocolsTableReferences(
                                db,
                                table,
                                p0,
                              ).observationSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.protocolId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (learnedActivitiesRefs)
                        await $_getPrefetchedData<
                          ObservationProtocol,
                          $ObservationProtocolsTable,
                          LearnedActivity
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationProtocolsTableReferences
                              ._learnedActivitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationProtocolsTableReferences(
                                db,
                                table,
                                p0,
                              ).learnedActivitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.protocolId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reachZoneRecipesRefs)
                        await $_getPrefetchedData<
                          ObservationProtocol,
                          $ObservationProtocolsTable,
                          ReachZoneRecipe
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationProtocolsTableReferences
                              ._reachZoneRecipesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationProtocolsTableReferences(
                                db,
                                table,
                                p0,
                              ).reachZoneRecipesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.protocolId == item.id,
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

typedef $$ObservationProtocolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObservationProtocolsTable,
      ObservationProtocol,
      $$ObservationProtocolsTableFilterComposer,
      $$ObservationProtocolsTableOrderingComposer,
      $$ObservationProtocolsTableAnnotationComposer,
      $$ObservationProtocolsTableCreateCompanionBuilder,
      $$ObservationProtocolsTableUpdateCompanionBuilder,
      (ObservationProtocol, $$ObservationProtocolsTableReferences),
      ObservationProtocol,
      PrefetchHooks Function({
        bool userId,
        bool observableClassesRefs,
        bool observationSessionsRefs,
        bool learnedActivitiesRefs,
        bool reachZoneRecipesRefs,
      })
    >;
typedef $$ObservableClassesTableCreateCompanionBuilder =
    ObservableClassesCompanion Function({
      Value<int> id,
      Value<int?> protocolId,
      required String name,
      required int sortOrder,
      required DateTime createdAt,
    });
typedef $$ObservableClassesTableUpdateCompanionBuilder =
    ObservableClassesCompanion Function({
      Value<int> id,
      Value<int?> protocolId,
      Value<String> name,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

final class $$ObservableClassesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ObservableClassesTable,
          ObservableClassesData
        > {
  $$ObservableClassesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationProtocolsTable _protocolIdTable(_$AppDatabase db) =>
      db.observationProtocols.createAlias(
        'observable_classes__protocol_id__observation_protocols__id',
      );

  $$ObservationProtocolsTableProcessedTableManager? get protocolId {
    final $_column = $_itemColumn<int>('protocol_id');
    if ($_column == null) return null;
    final manager = $$ObservationProtocolsTableTableManager(
      $_db,
      $_db.observationProtocols,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_protocolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ObservableSubclassesTable,
    List<ObservableSubclassesData>
  >
  _observableSubclassesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.observableSubclasses,
        aliasName: 'observable_classes__id__observable_subclasses__class_id',
      );

  $$ObservableSubclassesTableProcessedTableManager
  get observableSubclassesRefs {
    final manager = $$ObservableSubclassesTableTableManager(
      $_db,
      $_db.observableSubclasses,
    ).filter((f) => f.classId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _observableSubclassesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ObservableClassesTableFilterComposer
    extends Composer<_$AppDatabase, $ObservableClassesTable> {
  $$ObservableClassesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationProtocolsTableFilterComposer get protocolId {
    final $$ObservationProtocolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.observationProtocols,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationProtocolsTableFilterComposer(
            $db: $db,
            $table: $db.observationProtocols,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> observableSubclassesRefs(
    Expression<bool> Function($$ObservableSubclassesTableFilterComposer f) f,
  ) {
    final $$ObservableSubclassesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observableSubclasses,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservableSubclassesTableFilterComposer(
            $db: $db,
            $table: $db.observableSubclasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ObservableClassesTableOrderingComposer
    extends Composer<_$AppDatabase, $ObservableClassesTable> {
  $$ObservableClassesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationProtocolsTableOrderingComposer get protocolId {
    final $$ObservationProtocolsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableOrderingComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ObservableClassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObservableClassesTable> {
  $$ObservableClassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ObservationProtocolsTableAnnotationComposer get protocolId {
    final $$ObservationProtocolsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> observableSubclassesRefs<T extends Object>(
    Expression<T> Function($$ObservableSubclassesTableAnnotationComposer a) f,
  ) {
    final $$ObservableSubclassesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.observableSubclasses,
          getReferencedColumn: (t) => t.classId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservableSubclassesTableAnnotationComposer(
                $db: $db,
                $table: $db.observableSubclasses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ObservableClassesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObservableClassesTable,
          ObservableClassesData,
          $$ObservableClassesTableFilterComposer,
          $$ObservableClassesTableOrderingComposer,
          $$ObservableClassesTableAnnotationComposer,
          $$ObservableClassesTableCreateCompanionBuilder,
          $$ObservableClassesTableUpdateCompanionBuilder,
          (ObservableClassesData, $$ObservableClassesTableReferences),
          ObservableClassesData,
          PrefetchHooks Function({
            bool protocolId,
            bool observableSubclassesRefs,
          })
        > {
  $$ObservableClassesTableTableManager(
    _$AppDatabase db,
    $ObservableClassesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObservableClassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObservableClassesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ObservableClassesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> protocolId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ObservableClassesCompanion(
                id: id,
                protocolId: protocolId,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> protocolId = const Value.absent(),
                required String name,
                required int sortOrder,
                required DateTime createdAt,
              }) => ObservableClassesCompanion.insert(
                id: id,
                protocolId: protocolId,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ObservableClassesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({protocolId = false, observableSubclassesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (observableSubclassesRefs) db.observableSubclasses,
                  ],
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
                        if (protocolId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.protocolId,
                                    referencedTable:
                                        $$ObservableClassesTableReferences
                                            ._protocolIdTable(db),
                                    referencedColumn:
                                        $$ObservableClassesTableReferences
                                            ._protocolIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (observableSubclassesRefs)
                        await $_getPrefetchedData<
                          ObservableClassesData,
                          $ObservableClassesTable,
                          ObservableSubclassesData
                        >(
                          currentTable: table,
                          referencedTable: $$ObservableClassesTableReferences
                              ._observableSubclassesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservableClassesTableReferences(
                                db,
                                table,
                                p0,
                              ).observableSubclassesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.classId == item.id,
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

typedef $$ObservableClassesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObservableClassesTable,
      ObservableClassesData,
      $$ObservableClassesTableFilterComposer,
      $$ObservableClassesTableOrderingComposer,
      $$ObservableClassesTableAnnotationComposer,
      $$ObservableClassesTableCreateCompanionBuilder,
      $$ObservableClassesTableUpdateCompanionBuilder,
      (ObservableClassesData, $$ObservableClassesTableReferences),
      ObservableClassesData,
      PrefetchHooks Function({bool protocolId, bool observableSubclassesRefs})
    >;
typedef $$ObservableSubclassesTableCreateCompanionBuilder =
    ObservableSubclassesCompanion Function({
      Value<int> id,
      required int classId,
      required String name,
      required String metricType,
      required int colorValue,
      required int sortOrder,
    });
typedef $$ObservableSubclassesTableUpdateCompanionBuilder =
    ObservableSubclassesCompanion Function({
      Value<int> id,
      Value<int> classId,
      Value<String> name,
      Value<String> metricType,
      Value<int> colorValue,
      Value<int> sortOrder,
    });

final class $$ObservableSubclassesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ObservableSubclassesTable,
          ObservableSubclassesData
        > {
  $$ObservableSubclassesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservableClassesTable _classIdTable(_$AppDatabase db) => db
      .observableClasses
      .createAlias('observable_subclasses__class_id__observable_classes__id');

  $$ObservableClassesTableProcessedTableManager get classId {
    final $_column = $_itemColumn<int>('class_id')!;

    final manager = $$ObservableClassesTableTableManager(
      $_db,
      $_db.observableClasses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CountEventsTable, List<CountEvent>>
  _countEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.countEvents,
    aliasName: 'observable_subclasses__id__count_events__subclass_id',
  );

  $$CountEventsTableProcessedTableManager get countEventsRefs {
    final manager = $$CountEventsTableTableManager(
      $_db,
      $_db.countEvents,
    ).filter((f) => f.subclassId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_countEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DurationIntervalsTable, List<DurationInterval>>
  _durationIntervalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.durationIntervals,
        aliasName: 'observable_subclasses__id__duration_intervals__subclass_id',
      );

  $$DurationIntervalsTableProcessedTableManager get durationIntervalsRefs {
    final manager = $$DurationIntervalsTableTableManager(
      $_db,
      $_db.durationIntervals,
    ).filter((f) => f.subclassId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _durationIntervalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ObservableSubclassesTableFilterComposer
    extends Composer<_$AppDatabase, $ObservableSubclassesTable> {
  $$ObservableSubclassesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metricType => $composableBuilder(
    column: $table.metricType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservableClassesTableFilterComposer get classId {
    final $$ObservableClassesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.observableClasses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservableClassesTableFilterComposer(
            $db: $db,
            $table: $db.observableClasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> countEventsRefs(
    Expression<bool> Function($$CountEventsTableFilterComposer f) f,
  ) {
    final $$CountEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countEvents,
      getReferencedColumn: (t) => t.subclassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountEventsTableFilterComposer(
            $db: $db,
            $table: $db.countEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> durationIntervalsRefs(
    Expression<bool> Function($$DurationIntervalsTableFilterComposer f) f,
  ) {
    final $$DurationIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.durationIntervals,
      getReferencedColumn: (t) => t.subclassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DurationIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.durationIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ObservableSubclassesTableOrderingComposer
    extends Composer<_$AppDatabase, $ObservableSubclassesTable> {
  $$ObservableSubclassesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metricType => $composableBuilder(
    column: $table.metricType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservableClassesTableOrderingComposer get classId {
    final $$ObservableClassesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.observableClasses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservableClassesTableOrderingComposer(
            $db: $db,
            $table: $db.observableClasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservableSubclassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObservableSubclassesTable> {
  $$ObservableSubclassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get metricType => $composableBuilder(
    column: $table.metricType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ObservableClassesTableAnnotationComposer get classId {
    final $$ObservableClassesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.classId,
          referencedTable: $db.observableClasses,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservableClassesTableAnnotationComposer(
                $db: $db,
                $table: $db.observableClasses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> countEventsRefs<T extends Object>(
    Expression<T> Function($$CountEventsTableAnnotationComposer a) f,
  ) {
    final $$CountEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countEvents,
      getReferencedColumn: (t) => t.subclassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.countEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> durationIntervalsRefs<T extends Object>(
    Expression<T> Function($$DurationIntervalsTableAnnotationComposer a) f,
  ) {
    final $$DurationIntervalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.durationIntervals,
          getReferencedColumn: (t) => t.subclassId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DurationIntervalsTableAnnotationComposer(
                $db: $db,
                $table: $db.durationIntervals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ObservableSubclassesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObservableSubclassesTable,
          ObservableSubclassesData,
          $$ObservableSubclassesTableFilterComposer,
          $$ObservableSubclassesTableOrderingComposer,
          $$ObservableSubclassesTableAnnotationComposer,
          $$ObservableSubclassesTableCreateCompanionBuilder,
          $$ObservableSubclassesTableUpdateCompanionBuilder,
          (ObservableSubclassesData, $$ObservableSubclassesTableReferences),
          ObservableSubclassesData,
          PrefetchHooks Function({
            bool classId,
            bool countEventsRefs,
            bool durationIntervalsRefs,
          })
        > {
  $$ObservableSubclassesTableTableManager(
    _$AppDatabase db,
    $ObservableSubclassesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObservableSubclassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObservableSubclassesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ObservableSubclassesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> classId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> metricType = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ObservableSubclassesCompanion(
                id: id,
                classId: classId,
                name: name,
                metricType: metricType,
                colorValue: colorValue,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int classId,
                required String name,
                required String metricType,
                required int colorValue,
                required int sortOrder,
              }) => ObservableSubclassesCompanion.insert(
                id: id,
                classId: classId,
                name: name,
                metricType: metricType,
                colorValue: colorValue,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ObservableSubclassesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                classId = false,
                countEventsRefs = false,
                durationIntervalsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (countEventsRefs) db.countEvents,
                    if (durationIntervalsRefs) db.durationIntervals,
                  ],
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
                        if (classId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.classId,
                                    referencedTable:
                                        $$ObservableSubclassesTableReferences
                                            ._classIdTable(db),
                                    referencedColumn:
                                        $$ObservableSubclassesTableReferences
                                            ._classIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (countEventsRefs)
                        await $_getPrefetchedData<
                          ObservableSubclassesData,
                          $ObservableSubclassesTable,
                          CountEvent
                        >(
                          currentTable: table,
                          referencedTable: $$ObservableSubclassesTableReferences
                              ._countEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservableSubclassesTableReferences(
                                db,
                                table,
                                p0,
                              ).countEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subclassId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (durationIntervalsRefs)
                        await $_getPrefetchedData<
                          ObservableSubclassesData,
                          $ObservableSubclassesTable,
                          DurationInterval
                        >(
                          currentTable: table,
                          referencedTable: $$ObservableSubclassesTableReferences
                              ._durationIntervalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservableSubclassesTableReferences(
                                db,
                                table,
                                p0,
                              ).durationIntervalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subclassId == item.id,
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

typedef $$ObservableSubclassesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObservableSubclassesTable,
      ObservableSubclassesData,
      $$ObservableSubclassesTableFilterComposer,
      $$ObservableSubclassesTableOrderingComposer,
      $$ObservableSubclassesTableAnnotationComposer,
      $$ObservableSubclassesTableCreateCompanionBuilder,
      $$ObservableSubclassesTableUpdateCompanionBuilder,
      (ObservableSubclassesData, $$ObservableSubclassesTableReferences),
      ObservableSubclassesData,
      PrefetchHooks Function({
        bool classId,
        bool countEventsRefs,
        bool durationIntervalsRefs,
      })
    >;
typedef $$ObservationSessionsTableCreateCompanionBuilder =
    ObservationSessionsCompanion Function({
      Value<int> id,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<bool> useManual,
      Value<bool> useReachZones,
      Value<bool> useActivity,
      Value<String> activityEngine,
      Value<int?> protocolId,
      Value<int?> userId,
      Value<String> name,
    });
typedef $$ObservationSessionsTableUpdateCompanionBuilder =
    ObservationSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<bool> useManual,
      Value<bool> useReachZones,
      Value<bool> useActivity,
      Value<String> activityEngine,
      Value<int?> protocolId,
      Value<int?> userId,
      Value<String> name,
    });

final class $$ObservationSessionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ObservationSessionsTable,
          ObservationSession
        > {
  $$ObservationSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationProtocolsTable _protocolIdTable(_$AppDatabase db) =>
      db.observationProtocols.createAlias(
        'observation_sessions__protocol_id__observation_protocols__id',
      );

  $$ObservationProtocolsTableProcessedTableManager? get protocolId {
    final $_column = $_itemColumn<int>('protocol_id');
    if ($_column == null) return null;
    final manager = $$ObservationProtocolsTableTableManager(
      $_db,
      $_db.observationProtocols,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_protocolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AppUsersTable _userIdTable(_$AppDatabase db) =>
      db.appUsers.createAlias('observation_sessions__user_id__app_users__id');

  $$AppUsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$AppUsersTableTableManager(
      $_db,
      $_db.appUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CountEventsTable, List<CountEvent>>
  _countEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.countEvents,
    aliasName: 'observation_sessions__id__count_events__session_id',
  );

  $$CountEventsTableProcessedTableManager get countEventsRefs {
    final manager = $$CountEventsTableTableManager(
      $_db,
      $_db.countEvents,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_countEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DurationIntervalsTable, List<DurationInterval>>
  _durationIntervalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.durationIntervals,
        aliasName: 'observation_sessions__id__duration_intervals__session_id',
      );

  $$DurationIntervalsTableProcessedTableManager get durationIntervalsRefs {
    final manager = $$DurationIntervalsTableTableManager(
      $_db,
      $_db.durationIntervals,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _durationIntervalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActivityEventsTable, List<ActivityEvent>>
  _activityEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activityEvents,
    aliasName: 'observation_sessions__id__activity_events__session_id',
  );

  $$ActivityEventsTableProcessedTableManager get activityEventsRefs {
    final manager = $$ActivityEventsTableTableManager(
      $_db,
      $_db.activityEvents,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activityEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActivityIntervalsTable, List<ActivityInterval>>
  _activityIntervalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.activityIntervals,
        aliasName: 'observation_sessions__id__activity_intervals__session_id',
      );

  $$ActivityIntervalsTableProcessedTableManager get activityIntervalsRefs {
    final manager = $$ActivityIntervalsTableTableManager(
      $_db,
      $_db.activityIntervals,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _activityIntervalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReachZoneIntervalsTable, List<ReachZoneInterval>>
  _reachZoneIntervalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.reachZoneIntervals,
        aliasName: 'observation_sessions__id__reach_zone_intervals__session_id',
      );

  $$ReachZoneIntervalsTableProcessedTableManager get reachZoneIntervalsRefs {
    final manager = $$ReachZoneIntervalsTableTableManager(
      $_db,
      $_db.reachZoneIntervals,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reachZoneIntervalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ObservationSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ObservationSessionsTable> {
  $$ObservationSessionsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useManual => $composableBuilder(
    column: $table.useManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useReachZones => $composableBuilder(
    column: $table.useReachZones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useActivity => $composableBuilder(
    column: $table.useActivity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityEngine => $composableBuilder(
    column: $table.activityEngine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationProtocolsTableFilterComposer get protocolId {
    final $$ObservationProtocolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.observationProtocols,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationProtocolsTableFilterComposer(
            $db: $db,
            $table: $db.observationProtocols,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableFilterComposer get userId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableFilterComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> countEventsRefs(
    Expression<bool> Function($$CountEventsTableFilterComposer f) f,
  ) {
    final $$CountEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countEvents,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountEventsTableFilterComposer(
            $db: $db,
            $table: $db.countEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> durationIntervalsRefs(
    Expression<bool> Function($$DurationIntervalsTableFilterComposer f) f,
  ) {
    final $$DurationIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.durationIntervals,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DurationIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.durationIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activityEventsRefs(
    Expression<bool> Function($$ActivityEventsTableFilterComposer f) f,
  ) {
    final $$ActivityEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityEvents,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityEventsTableFilterComposer(
            $db: $db,
            $table: $db.activityEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activityIntervalsRefs(
    Expression<bool> Function($$ActivityIntervalsTableFilterComposer f) f,
  ) {
    final $$ActivityIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityIntervals,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.activityIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reachZoneIntervalsRefs(
    Expression<bool> Function($$ReachZoneIntervalsTableFilterComposer f) f,
  ) {
    final $$ReachZoneIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reachZoneIntervals,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReachZoneIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.reachZoneIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ObservationSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ObservationSessionsTable> {
  $$ObservationSessionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useManual => $composableBuilder(
    column: $table.useManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useReachZones => $composableBuilder(
    column: $table.useReachZones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useActivity => $composableBuilder(
    column: $table.useActivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityEngine => $composableBuilder(
    column: $table.activityEngine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationProtocolsTableOrderingComposer get protocolId {
    final $$ObservationProtocolsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableOrderingComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AppUsersTableOrderingComposer get userId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableOrderingComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObservationSessionsTable> {
  $$ObservationSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<bool> get useManual =>
      $composableBuilder(column: $table.useManual, builder: (column) => column);

  GeneratedColumn<bool> get useReachZones => $composableBuilder(
    column: $table.useReachZones,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get useActivity => $composableBuilder(
    column: $table.useActivity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityEngine => $composableBuilder(
    column: $table.activityEngine,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$ObservationProtocolsTableAnnotationComposer get protocolId {
    final $$ObservationProtocolsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AppUsersTableAnnotationComposer get userId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> countEventsRefs<T extends Object>(
    Expression<T> Function($$CountEventsTableAnnotationComposer a) f,
  ) {
    final $$CountEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countEvents,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.countEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> durationIntervalsRefs<T extends Object>(
    Expression<T> Function($$DurationIntervalsTableAnnotationComposer a) f,
  ) {
    final $$DurationIntervalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.durationIntervals,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DurationIntervalsTableAnnotationComposer(
                $db: $db,
                $table: $db.durationIntervals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> activityEventsRefs<T extends Object>(
    Expression<T> Function($$ActivityEventsTableAnnotationComposer a) f,
  ) {
    final $$ActivityEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityEvents,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.activityEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activityIntervalsRefs<T extends Object>(
    Expression<T> Function($$ActivityIntervalsTableAnnotationComposer a) f,
  ) {
    final $$ActivityIntervalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.activityIntervals,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActivityIntervalsTableAnnotationComposer(
                $db: $db,
                $table: $db.activityIntervals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> reachZoneIntervalsRefs<T extends Object>(
    Expression<T> Function($$ReachZoneIntervalsTableAnnotationComposer a) f,
  ) {
    final $$ReachZoneIntervalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.reachZoneIntervals,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReachZoneIntervalsTableAnnotationComposer(
                $db: $db,
                $table: $db.reachZoneIntervals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ObservationSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObservationSessionsTable,
          ObservationSession,
          $$ObservationSessionsTableFilterComposer,
          $$ObservationSessionsTableOrderingComposer,
          $$ObservationSessionsTableAnnotationComposer,
          $$ObservationSessionsTableCreateCompanionBuilder,
          $$ObservationSessionsTableUpdateCompanionBuilder,
          (ObservationSession, $$ObservationSessionsTableReferences),
          ObservationSession,
          PrefetchHooks Function({
            bool protocolId,
            bool userId,
            bool countEventsRefs,
            bool durationIntervalsRefs,
            bool activityEventsRefs,
            bool activityIntervalsRefs,
            bool reachZoneIntervalsRefs,
          })
        > {
  $$ObservationSessionsTableTableManager(
    _$AppDatabase db,
    $ObservationSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObservationSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObservationSessionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ObservationSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<bool> useManual = const Value.absent(),
                Value<bool> useReachZones = const Value.absent(),
                Value<bool> useActivity = const Value.absent(),
                Value<String> activityEngine = const Value.absent(),
                Value<int?> protocolId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ObservationSessionsCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                useManual: useManual,
                useReachZones: useReachZones,
                useActivity: useActivity,
                activityEngine: activityEngine,
                protocolId: protocolId,
                userId: userId,
                name: name,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<bool> useManual = const Value.absent(),
                Value<bool> useReachZones = const Value.absent(),
                Value<bool> useActivity = const Value.absent(),
                Value<String> activityEngine = const Value.absent(),
                Value<int?> protocolId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ObservationSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                useManual: useManual,
                useReachZones: useReachZones,
                useActivity: useActivity,
                activityEngine: activityEngine,
                protocolId: protocolId,
                userId: userId,
                name: name,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ObservationSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                protocolId = false,
                userId = false,
                countEventsRefs = false,
                durationIntervalsRefs = false,
                activityEventsRefs = false,
                activityIntervalsRefs = false,
                reachZoneIntervalsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (countEventsRefs) db.countEvents,
                    if (durationIntervalsRefs) db.durationIntervals,
                    if (activityEventsRefs) db.activityEvents,
                    if (activityIntervalsRefs) db.activityIntervals,
                    if (reachZoneIntervalsRefs) db.reachZoneIntervals,
                  ],
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
                        if (protocolId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.protocolId,
                                    referencedTable:
                                        $$ObservationSessionsTableReferences
                                            ._protocolIdTable(db),
                                    referencedColumn:
                                        $$ObservationSessionsTableReferences
                                            ._protocolIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable:
                                        $$ObservationSessionsTableReferences
                                            ._userIdTable(db),
                                    referencedColumn:
                                        $$ObservationSessionsTableReferences
                                            ._userIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (countEventsRefs)
                        await $_getPrefetchedData<
                          ObservationSession,
                          $ObservationSessionsTable,
                          CountEvent
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationSessionsTableReferences
                              ._countEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).countEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (durationIntervalsRefs)
                        await $_getPrefetchedData<
                          ObservationSession,
                          $ObservationSessionsTable,
                          DurationInterval
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationSessionsTableReferences
                              ._durationIntervalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).durationIntervalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activityEventsRefs)
                        await $_getPrefetchedData<
                          ObservationSession,
                          $ObservationSessionsTable,
                          ActivityEvent
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationSessionsTableReferences
                              ._activityEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).activityEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activityIntervalsRefs)
                        await $_getPrefetchedData<
                          ObservationSession,
                          $ObservationSessionsTable,
                          ActivityInterval
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationSessionsTableReferences
                              ._activityIntervalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).activityIntervalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reachZoneIntervalsRefs)
                        await $_getPrefetchedData<
                          ObservationSession,
                          $ObservationSessionsTable,
                          ReachZoneInterval
                        >(
                          currentTable: table,
                          referencedTable: $$ObservationSessionsTableReferences
                              ._reachZoneIntervalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ObservationSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).reachZoneIntervalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
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

typedef $$ObservationSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObservationSessionsTable,
      ObservationSession,
      $$ObservationSessionsTableFilterComposer,
      $$ObservationSessionsTableOrderingComposer,
      $$ObservationSessionsTableAnnotationComposer,
      $$ObservationSessionsTableCreateCompanionBuilder,
      $$ObservationSessionsTableUpdateCompanionBuilder,
      (ObservationSession, $$ObservationSessionsTableReferences),
      ObservationSession,
      PrefetchHooks Function({
        bool protocolId,
        bool userId,
        bool countEventsRefs,
        bool durationIntervalsRefs,
        bool activityEventsRefs,
        bool activityIntervalsRefs,
        bool reachZoneIntervalsRefs,
      })
    >;
typedef $$CountEventsTableCreateCompanionBuilder =
    CountEventsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int subclassId,
      required DateTime occurredAt,
    });
typedef $$CountEventsTableUpdateCompanionBuilder =
    CountEventsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> subclassId,
      Value<DateTime> occurredAt,
    });

final class $$CountEventsTableReferences
    extends BaseReferences<_$AppDatabase, $CountEventsTable, CountEvent> {
  $$CountEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ObservationSessionsTable _sessionIdTable(_$AppDatabase db) => db
      .observationSessions
      .createAlias('count_events__session_id__observation_sessions__id');

  $$ObservationSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$ObservationSessionsTableTableManager(
      $_db,
      $_db.observationSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ObservableSubclassesTable _subclassIdTable(_$AppDatabase db) => db
      .observableSubclasses
      .createAlias('count_events__subclass_id__observable_subclasses__id');

  $$ObservableSubclassesTableProcessedTableManager get subclassId {
    final $_column = $_itemColumn<int>('subclass_id')!;

    final manager = $$ObservableSubclassesTableTableManager(
      $_db,
      $_db.observableSubclasses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subclassIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CountEventsTableFilterComposer
    extends Composer<_$AppDatabase, $CountEventsTable> {
  $$CountEventsTableFilterComposer({
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

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationSessionsTableFilterComposer get sessionId {
    final $$ObservationSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.observationSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationSessionsTableFilterComposer(
            $db: $db,
            $table: $db.observationSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ObservableSubclassesTableFilterComposer get subclassId {
    final $$ObservableSubclassesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subclassId,
      referencedTable: $db.observableSubclasses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservableSubclassesTableFilterComposer(
            $db: $db,
            $table: $db.observableSubclasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CountEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $CountEventsTable> {
  $$CountEventsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationSessionsTableOrderingComposer get sessionId {
    final $$ObservationSessionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableOrderingComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ObservableSubclassesTableOrderingComposer get subclassId {
    final $$ObservableSubclassesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.subclassId,
          referencedTable: $db.observableSubclasses,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservableSubclassesTableOrderingComposer(
                $db: $db,
                $table: $db.observableSubclasses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CountEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CountEventsTable> {
  $$CountEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$ObservationSessionsTableAnnotationComposer get sessionId {
    final $$ObservationSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ObservableSubclassesTableAnnotationComposer get subclassId {
    final $$ObservableSubclassesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.subclassId,
          referencedTable: $db.observableSubclasses,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservableSubclassesTableAnnotationComposer(
                $db: $db,
                $table: $db.observableSubclasses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CountEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CountEventsTable,
          CountEvent,
          $$CountEventsTableFilterComposer,
          $$CountEventsTableOrderingComposer,
          $$CountEventsTableAnnotationComposer,
          $$CountEventsTableCreateCompanionBuilder,
          $$CountEventsTableUpdateCompanionBuilder,
          (CountEvent, $$CountEventsTableReferences),
          CountEvent,
          PrefetchHooks Function({bool sessionId, bool subclassId})
        > {
  $$CountEventsTableTableManager(_$AppDatabase db, $CountEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CountEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CountEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CountEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> subclassId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
              }) => CountEventsCompanion(
                id: id,
                sessionId: sessionId,
                subclassId: subclassId,
                occurredAt: occurredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int subclassId,
                required DateTime occurredAt,
              }) => CountEventsCompanion.insert(
                id: id,
                sessionId: sessionId,
                subclassId: subclassId,
                occurredAt: occurredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CountEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, subclassId = false}) {
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
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$CountEventsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$CountEventsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (subclassId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.subclassId,
                                referencedTable: $$CountEventsTableReferences
                                    ._subclassIdTable(db),
                                referencedColumn: $$CountEventsTableReferences
                                    ._subclassIdTable(db)
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

typedef $$CountEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CountEventsTable,
      CountEvent,
      $$CountEventsTableFilterComposer,
      $$CountEventsTableOrderingComposer,
      $$CountEventsTableAnnotationComposer,
      $$CountEventsTableCreateCompanionBuilder,
      $$CountEventsTableUpdateCompanionBuilder,
      (CountEvent, $$CountEventsTableReferences),
      CountEvent,
      PrefetchHooks Function({bool sessionId, bool subclassId})
    >;
typedef $$DurationIntervalsTableCreateCompanionBuilder =
    DurationIntervalsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int subclassId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
    });
typedef $$DurationIntervalsTableUpdateCompanionBuilder =
    DurationIntervalsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> subclassId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
    });

final class $$DurationIntervalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DurationIntervalsTable,
          DurationInterval
        > {
  $$DurationIntervalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationSessionsTable _sessionIdTable(_$AppDatabase db) => db
      .observationSessions
      .createAlias('duration_intervals__session_id__observation_sessions__id');

  $$ObservationSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$ObservationSessionsTableTableManager(
      $_db,
      $_db.observationSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ObservableSubclassesTable _subclassIdTable(_$AppDatabase db) =>
      db.observableSubclasses.createAlias(
        'duration_intervals__subclass_id__observable_subclasses__id',
      );

  $$ObservableSubclassesTableProcessedTableManager get subclassId {
    final $_column = $_itemColumn<int>('subclass_id')!;

    final manager = $$ObservableSubclassesTableTableManager(
      $_db,
      $_db.observableSubclasses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subclassIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DurationIntervalsTableFilterComposer
    extends Composer<_$AppDatabase, $DurationIntervalsTable> {
  $$DurationIntervalsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationSessionsTableFilterComposer get sessionId {
    final $$ObservationSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.observationSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationSessionsTableFilterComposer(
            $db: $db,
            $table: $db.observationSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ObservableSubclassesTableFilterComposer get subclassId {
    final $$ObservableSubclassesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subclassId,
      referencedTable: $db.observableSubclasses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservableSubclassesTableFilterComposer(
            $db: $db,
            $table: $db.observableSubclasses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DurationIntervalsTableOrderingComposer
    extends Composer<_$AppDatabase, $DurationIntervalsTable> {
  $$DurationIntervalsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationSessionsTableOrderingComposer get sessionId {
    final $$ObservationSessionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableOrderingComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ObservableSubclassesTableOrderingComposer get subclassId {
    final $$ObservableSubclassesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.subclassId,
          referencedTable: $db.observableSubclasses,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservableSubclassesTableOrderingComposer(
                $db: $db,
                $table: $db.observableSubclasses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$DurationIntervalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DurationIntervalsTable> {
  $$DurationIntervalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$ObservationSessionsTableAnnotationComposer get sessionId {
    final $$ObservationSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ObservableSubclassesTableAnnotationComposer get subclassId {
    final $$ObservableSubclassesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.subclassId,
          referencedTable: $db.observableSubclasses,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservableSubclassesTableAnnotationComposer(
                $db: $db,
                $table: $db.observableSubclasses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$DurationIntervalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DurationIntervalsTable,
          DurationInterval,
          $$DurationIntervalsTableFilterComposer,
          $$DurationIntervalsTableOrderingComposer,
          $$DurationIntervalsTableAnnotationComposer,
          $$DurationIntervalsTableCreateCompanionBuilder,
          $$DurationIntervalsTableUpdateCompanionBuilder,
          (DurationInterval, $$DurationIntervalsTableReferences),
          DurationInterval,
          PrefetchHooks Function({bool sessionId, bool subclassId})
        > {
  $$DurationIntervalsTableTableManager(
    _$AppDatabase db,
    $DurationIntervalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DurationIntervalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DurationIntervalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DurationIntervalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> subclassId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
              }) => DurationIntervalsCompanion(
                id: id,
                sessionId: sessionId,
                subclassId: subclassId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int subclassId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
              }) => DurationIntervalsCompanion.insert(
                id: id,
                sessionId: sessionId,
                subclassId: subclassId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DurationIntervalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, subclassId = false}) {
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
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$DurationIntervalsTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$DurationIntervalsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (subclassId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.subclassId,
                                referencedTable:
                                    $$DurationIntervalsTableReferences
                                        ._subclassIdTable(db),
                                referencedColumn:
                                    $$DurationIntervalsTableReferences
                                        ._subclassIdTable(db)
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

typedef $$DurationIntervalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DurationIntervalsTable,
      DurationInterval,
      $$DurationIntervalsTableFilterComposer,
      $$DurationIntervalsTableOrderingComposer,
      $$DurationIntervalsTableAnnotationComposer,
      $$DurationIntervalsTableCreateCompanionBuilder,
      $$DurationIntervalsTableUpdateCompanionBuilder,
      (DurationInterval, $$DurationIntervalsTableReferences),
      DurationInterval,
      PrefetchHooks Function({bool sessionId, bool subclassId})
    >;
typedef $$LearnedActivitiesTableCreateCompanionBuilder =
    LearnedActivitiesCompanion Function({
      Value<int> id,
      Value<int?> protocolId,
      required String name,
      required String clipPath,
      required int colorValue,
      required int sortOrder,
      required DateTime createdAt,
      Value<String> kind,
    });
typedef $$LearnedActivitiesTableUpdateCompanionBuilder =
    LearnedActivitiesCompanion Function({
      Value<int> id,
      Value<int?> protocolId,
      Value<String> name,
      Value<String> clipPath,
      Value<int> colorValue,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<String> kind,
    });

final class $$LearnedActivitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LearnedActivitiesTable,
          LearnedActivity
        > {
  $$LearnedActivitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationProtocolsTable _protocolIdTable(_$AppDatabase db) =>
      db.observationProtocols.createAlias(
        'learned_activities__protocol_id__observation_protocols__id',
      );

  $$ObservationProtocolsTableProcessedTableManager? get protocolId {
    final $_column = $_itemColumn<int>('protocol_id');
    if ($_column == null) return null;
    final manager = $$ObservationProtocolsTableTableManager(
      $_db,
      $_db.observationProtocols,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_protocolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ActivityEventsTable, List<ActivityEvent>>
  _activityEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activityEvents,
    aliasName: 'learned_activities__id__activity_events__activity_id',
  );

  $$ActivityEventsTableProcessedTableManager get activityEventsRefs {
    final manager = $$ActivityEventsTableTableManager(
      $_db,
      $_db.activityEvents,
    ).filter((f) => f.activityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activityEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActivityIntervalsTable, List<ActivityInterval>>
  _activityIntervalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.activityIntervals,
        aliasName: 'learned_activities__id__activity_intervals__activity_id',
      );

  $$ActivityIntervalsTableProcessedTableManager get activityIntervalsRefs {
    final manager = $$ActivityIntervalsTableTableManager(
      $_db,
      $_db.activityIntervals,
    ).filter((f) => f.activityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _activityIntervalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActivityEmbeddingsTable, List<ActivityEmbedding>>
  _activityEmbeddingsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.activityEmbeddings,
        aliasName: 'learned_activities__id__activity_embeddings__activity_id',
      );

  $$ActivityEmbeddingsTableProcessedTableManager get activityEmbeddingsRefs {
    final manager = $$ActivityEmbeddingsTableTableManager(
      $_db,
      $_db.activityEmbeddings,
    ).filter((f) => f.activityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _activityEmbeddingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LearnedActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $LearnedActivitiesTable> {
  $$LearnedActivitiesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clipPath => $composableBuilder(
    column: $table.clipPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationProtocolsTableFilterComposer get protocolId {
    final $$ObservationProtocolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.observationProtocols,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationProtocolsTableFilterComposer(
            $db: $db,
            $table: $db.observationProtocols,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> activityEventsRefs(
    Expression<bool> Function($$ActivityEventsTableFilterComposer f) f,
  ) {
    final $$ActivityEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityEvents,
      getReferencedColumn: (t) => t.activityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityEventsTableFilterComposer(
            $db: $db,
            $table: $db.activityEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activityIntervalsRefs(
    Expression<bool> Function($$ActivityIntervalsTableFilterComposer f) f,
  ) {
    final $$ActivityIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityIntervals,
      getReferencedColumn: (t) => t.activityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.activityIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activityEmbeddingsRefs(
    Expression<bool> Function($$ActivityEmbeddingsTableFilterComposer f) f,
  ) {
    final $$ActivityEmbeddingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityEmbeddings,
      getReferencedColumn: (t) => t.activityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityEmbeddingsTableFilterComposer(
            $db: $db,
            $table: $db.activityEmbeddings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearnedActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $LearnedActivitiesTable> {
  $$LearnedActivitiesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clipPath => $composableBuilder(
    column: $table.clipPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationProtocolsTableOrderingComposer get protocolId {
    final $$ObservationProtocolsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableOrderingComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LearnedActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearnedActivitiesTable> {
  $$LearnedActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get clipPath =>
      $composableBuilder(column: $table.clipPath, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  $$ObservationProtocolsTableAnnotationComposer get protocolId {
    final $$ObservationProtocolsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> activityEventsRefs<T extends Object>(
    Expression<T> Function($$ActivityEventsTableAnnotationComposer a) f,
  ) {
    final $$ActivityEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityEvents,
      getReferencedColumn: (t) => t.activityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.activityEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activityIntervalsRefs<T extends Object>(
    Expression<T> Function($$ActivityIntervalsTableAnnotationComposer a) f,
  ) {
    final $$ActivityIntervalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.activityIntervals,
          getReferencedColumn: (t) => t.activityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActivityIntervalsTableAnnotationComposer(
                $db: $db,
                $table: $db.activityIntervals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> activityEmbeddingsRefs<T extends Object>(
    Expression<T> Function($$ActivityEmbeddingsTableAnnotationComposer a) f,
  ) {
    final $$ActivityEmbeddingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.activityEmbeddings,
          getReferencedColumn: (t) => t.activityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActivityEmbeddingsTableAnnotationComposer(
                $db: $db,
                $table: $db.activityEmbeddings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LearnedActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearnedActivitiesTable,
          LearnedActivity,
          $$LearnedActivitiesTableFilterComposer,
          $$LearnedActivitiesTableOrderingComposer,
          $$LearnedActivitiesTableAnnotationComposer,
          $$LearnedActivitiesTableCreateCompanionBuilder,
          $$LearnedActivitiesTableUpdateCompanionBuilder,
          (LearnedActivity, $$LearnedActivitiesTableReferences),
          LearnedActivity,
          PrefetchHooks Function({
            bool protocolId,
            bool activityEventsRefs,
            bool activityIntervalsRefs,
            bool activityEmbeddingsRefs,
          })
        > {
  $$LearnedActivitiesTableTableManager(
    _$AppDatabase db,
    $LearnedActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearnedActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearnedActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearnedActivitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> protocolId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> clipPath = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> kind = const Value.absent(),
              }) => LearnedActivitiesCompanion(
                id: id,
                protocolId: protocolId,
                name: name,
                clipPath: clipPath,
                colorValue: colorValue,
                sortOrder: sortOrder,
                createdAt: createdAt,
                kind: kind,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> protocolId = const Value.absent(),
                required String name,
                required String clipPath,
                required int colorValue,
                required int sortOrder,
                required DateTime createdAt,
                Value<String> kind = const Value.absent(),
              }) => LearnedActivitiesCompanion.insert(
                id: id,
                protocolId: protocolId,
                name: name,
                clipPath: clipPath,
                colorValue: colorValue,
                sortOrder: sortOrder,
                createdAt: createdAt,
                kind: kind,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LearnedActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                protocolId = false,
                activityEventsRefs = false,
                activityIntervalsRefs = false,
                activityEmbeddingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (activityEventsRefs) db.activityEvents,
                    if (activityIntervalsRefs) db.activityIntervals,
                    if (activityEmbeddingsRefs) db.activityEmbeddings,
                  ],
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
                        if (protocolId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.protocolId,
                                    referencedTable:
                                        $$LearnedActivitiesTableReferences
                                            ._protocolIdTable(db),
                                    referencedColumn:
                                        $$LearnedActivitiesTableReferences
                                            ._protocolIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (activityEventsRefs)
                        await $_getPrefetchedData<
                          LearnedActivity,
                          $LearnedActivitiesTable,
                          ActivityEvent
                        >(
                          currentTable: table,
                          referencedTable: $$LearnedActivitiesTableReferences
                              ._activityEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LearnedActivitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).activityEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.activityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activityIntervalsRefs)
                        await $_getPrefetchedData<
                          LearnedActivity,
                          $LearnedActivitiesTable,
                          ActivityInterval
                        >(
                          currentTable: table,
                          referencedTable: $$LearnedActivitiesTableReferences
                              ._activityIntervalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LearnedActivitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).activityIntervalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.activityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activityEmbeddingsRefs)
                        await $_getPrefetchedData<
                          LearnedActivity,
                          $LearnedActivitiesTable,
                          ActivityEmbedding
                        >(
                          currentTable: table,
                          referencedTable: $$LearnedActivitiesTableReferences
                              ._activityEmbeddingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LearnedActivitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).activityEmbeddingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.activityId == item.id,
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

typedef $$LearnedActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearnedActivitiesTable,
      LearnedActivity,
      $$LearnedActivitiesTableFilterComposer,
      $$LearnedActivitiesTableOrderingComposer,
      $$LearnedActivitiesTableAnnotationComposer,
      $$LearnedActivitiesTableCreateCompanionBuilder,
      $$LearnedActivitiesTableUpdateCompanionBuilder,
      (LearnedActivity, $$LearnedActivitiesTableReferences),
      LearnedActivity,
      PrefetchHooks Function({
        bool protocolId,
        bool activityEventsRefs,
        bool activityIntervalsRefs,
        bool activityEmbeddingsRefs,
      })
    >;
typedef $$ActivityEventsTableCreateCompanionBuilder =
    ActivityEventsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int activityId,
      required DateTime occurredAt,
    });
typedef $$ActivityEventsTableUpdateCompanionBuilder =
    ActivityEventsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> activityId,
      Value<DateTime> occurredAt,
    });

final class $$ActivityEventsTableReferences
    extends BaseReferences<_$AppDatabase, $ActivityEventsTable, ActivityEvent> {
  $$ActivityEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationSessionsTable _sessionIdTable(_$AppDatabase db) => db
      .observationSessions
      .createAlias('activity_events__session_id__observation_sessions__id');

  $$ObservationSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$ObservationSessionsTableTableManager(
      $_db,
      $_db.observationSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LearnedActivitiesTable _activityIdTable(_$AppDatabase db) => db
      .learnedActivities
      .createAlias('activity_events__activity_id__learned_activities__id');

  $$LearnedActivitiesTableProcessedTableManager get activityId {
    final $_column = $_itemColumn<int>('activity_id')!;

    final manager = $$LearnedActivitiesTableTableManager(
      $_db,
      $_db.learnedActivities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivityEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityEventsTable> {
  $$ActivityEventsTableFilterComposer({
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

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationSessionsTableFilterComposer get sessionId {
    final $$ObservationSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.observationSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationSessionsTableFilterComposer(
            $db: $db,
            $table: $db.observationSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearnedActivitiesTableFilterComposer get activityId {
    final $$LearnedActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.learnedActivities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.learnedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityEventsTable> {
  $$ActivityEventsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationSessionsTableOrderingComposer get sessionId {
    final $$ObservationSessionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableOrderingComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$LearnedActivitiesTableOrderingComposer get activityId {
    final $$LearnedActivitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.learnedActivities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedActivitiesTableOrderingComposer(
            $db: $db,
            $table: $db.learnedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityEventsTable> {
  $$ActivityEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$ObservationSessionsTableAnnotationComposer get sessionId {
    final $$ObservationSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$LearnedActivitiesTableAnnotationComposer get activityId {
    final $$LearnedActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.activityId,
          referencedTable: $db.learnedActivities,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearnedActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.learnedActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ActivityEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityEventsTable,
          ActivityEvent,
          $$ActivityEventsTableFilterComposer,
          $$ActivityEventsTableOrderingComposer,
          $$ActivityEventsTableAnnotationComposer,
          $$ActivityEventsTableCreateCompanionBuilder,
          $$ActivityEventsTableUpdateCompanionBuilder,
          (ActivityEvent, $$ActivityEventsTableReferences),
          ActivityEvent,
          PrefetchHooks Function({bool sessionId, bool activityId})
        > {
  $$ActivityEventsTableTableManager(
    _$AppDatabase db,
    $ActivityEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> activityId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
              }) => ActivityEventsCompanion(
                id: id,
                sessionId: sessionId,
                activityId: activityId,
                occurredAt: occurredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int activityId,
                required DateTime occurredAt,
              }) => ActivityEventsCompanion.insert(
                id: id,
                sessionId: sessionId,
                activityId: activityId,
                occurredAt: occurredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivityEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, activityId = false}) {
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
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$ActivityEventsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn:
                                    $$ActivityEventsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (activityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activityId,
                                referencedTable: $$ActivityEventsTableReferences
                                    ._activityIdTable(db),
                                referencedColumn:
                                    $$ActivityEventsTableReferences
                                        ._activityIdTable(db)
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

typedef $$ActivityEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityEventsTable,
      ActivityEvent,
      $$ActivityEventsTableFilterComposer,
      $$ActivityEventsTableOrderingComposer,
      $$ActivityEventsTableAnnotationComposer,
      $$ActivityEventsTableCreateCompanionBuilder,
      $$ActivityEventsTableUpdateCompanionBuilder,
      (ActivityEvent, $$ActivityEventsTableReferences),
      ActivityEvent,
      PrefetchHooks Function({bool sessionId, bool activityId})
    >;
typedef $$ActivityIntervalsTableCreateCompanionBuilder =
    ActivityIntervalsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int activityId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
    });
typedef $$ActivityIntervalsTableUpdateCompanionBuilder =
    ActivityIntervalsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> activityId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
    });

final class $$ActivityIntervalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ActivityIntervalsTable,
          ActivityInterval
        > {
  $$ActivityIntervalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationSessionsTable _sessionIdTable(_$AppDatabase db) => db
      .observationSessions
      .createAlias('activity_intervals__session_id__observation_sessions__id');

  $$ObservationSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$ObservationSessionsTableTableManager(
      $_db,
      $_db.observationSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LearnedActivitiesTable _activityIdTable(_$AppDatabase db) => db
      .learnedActivities
      .createAlias('activity_intervals__activity_id__learned_activities__id');

  $$LearnedActivitiesTableProcessedTableManager get activityId {
    final $_column = $_itemColumn<int>('activity_id')!;

    final manager = $$LearnedActivitiesTableTableManager(
      $_db,
      $_db.learnedActivities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivityIntervalsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityIntervalsTable> {
  $$ActivityIntervalsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationSessionsTableFilterComposer get sessionId {
    final $$ObservationSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.observationSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationSessionsTableFilterComposer(
            $db: $db,
            $table: $db.observationSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearnedActivitiesTableFilterComposer get activityId {
    final $$LearnedActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.learnedActivities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.learnedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityIntervalsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityIntervalsTable> {
  $$ActivityIntervalsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationSessionsTableOrderingComposer get sessionId {
    final $$ObservationSessionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableOrderingComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$LearnedActivitiesTableOrderingComposer get activityId {
    final $$LearnedActivitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.learnedActivities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedActivitiesTableOrderingComposer(
            $db: $db,
            $table: $db.learnedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityIntervalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityIntervalsTable> {
  $$ActivityIntervalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$ObservationSessionsTableAnnotationComposer get sessionId {
    final $$ObservationSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$LearnedActivitiesTableAnnotationComposer get activityId {
    final $$LearnedActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.activityId,
          referencedTable: $db.learnedActivities,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearnedActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.learnedActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ActivityIntervalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityIntervalsTable,
          ActivityInterval,
          $$ActivityIntervalsTableFilterComposer,
          $$ActivityIntervalsTableOrderingComposer,
          $$ActivityIntervalsTableAnnotationComposer,
          $$ActivityIntervalsTableCreateCompanionBuilder,
          $$ActivityIntervalsTableUpdateCompanionBuilder,
          (ActivityInterval, $$ActivityIntervalsTableReferences),
          ActivityInterval,
          PrefetchHooks Function({bool sessionId, bool activityId})
        > {
  $$ActivityIntervalsTableTableManager(
    _$AppDatabase db,
    $ActivityIntervalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityIntervalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityIntervalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityIntervalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> activityId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
              }) => ActivityIntervalsCompanion(
                id: id,
                sessionId: sessionId,
                activityId: activityId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int activityId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
              }) => ActivityIntervalsCompanion.insert(
                id: id,
                sessionId: sessionId,
                activityId: activityId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivityIntervalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, activityId = false}) {
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
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$ActivityIntervalsTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$ActivityIntervalsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (activityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activityId,
                                referencedTable:
                                    $$ActivityIntervalsTableReferences
                                        ._activityIdTable(db),
                                referencedColumn:
                                    $$ActivityIntervalsTableReferences
                                        ._activityIdTable(db)
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

typedef $$ActivityIntervalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityIntervalsTable,
      ActivityInterval,
      $$ActivityIntervalsTableFilterComposer,
      $$ActivityIntervalsTableOrderingComposer,
      $$ActivityIntervalsTableAnnotationComposer,
      $$ActivityIntervalsTableCreateCompanionBuilder,
      $$ActivityIntervalsTableUpdateCompanionBuilder,
      (ActivityInterval, $$ActivityIntervalsTableReferences),
      ActivityInterval,
      PrefetchHooks Function({bool sessionId, bool activityId})
    >;
typedef $$ActivityEmbeddingsTableCreateCompanionBuilder =
    ActivityEmbeddingsCompanion Function({
      Value<int> id,
      required int activityId,
      required Uint8List vector,
    });
typedef $$ActivityEmbeddingsTableUpdateCompanionBuilder =
    ActivityEmbeddingsCompanion Function({
      Value<int> id,
      Value<int> activityId,
      Value<Uint8List> vector,
    });

final class $$ActivityEmbeddingsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ActivityEmbeddingsTable,
          ActivityEmbedding
        > {
  $$ActivityEmbeddingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LearnedActivitiesTable _activityIdTable(_$AppDatabase db) => db
      .learnedActivities
      .createAlias('activity_embeddings__activity_id__learned_activities__id');

  $$LearnedActivitiesTableProcessedTableManager get activityId {
    final $_column = $_itemColumn<int>('activity_id')!;

    final manager = $$LearnedActivitiesTableTableManager(
      $_db,
      $_db.learnedActivities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivityEmbeddingsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityEmbeddingsTable> {
  $$ActivityEmbeddingsTableFilterComposer({
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

  ColumnFilters<Uint8List> get vector => $composableBuilder(
    column: $table.vector,
    builder: (column) => ColumnFilters(column),
  );

  $$LearnedActivitiesTableFilterComposer get activityId {
    final $$LearnedActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.learnedActivities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.learnedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityEmbeddingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityEmbeddingsTable> {
  $$ActivityEmbeddingsTableOrderingComposer({
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

  ColumnOrderings<Uint8List> get vector => $composableBuilder(
    column: $table.vector,
    builder: (column) => ColumnOrderings(column),
  );

  $$LearnedActivitiesTableOrderingComposer get activityId {
    final $$LearnedActivitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.learnedActivities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedActivitiesTableOrderingComposer(
            $db: $db,
            $table: $db.learnedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityEmbeddingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityEmbeddingsTable> {
  $$ActivityEmbeddingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get vector =>
      $composableBuilder(column: $table.vector, builder: (column) => column);

  $$LearnedActivitiesTableAnnotationComposer get activityId {
    final $$LearnedActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.activityId,
          referencedTable: $db.learnedActivities,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearnedActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.learnedActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ActivityEmbeddingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityEmbeddingsTable,
          ActivityEmbedding,
          $$ActivityEmbeddingsTableFilterComposer,
          $$ActivityEmbeddingsTableOrderingComposer,
          $$ActivityEmbeddingsTableAnnotationComposer,
          $$ActivityEmbeddingsTableCreateCompanionBuilder,
          $$ActivityEmbeddingsTableUpdateCompanionBuilder,
          (ActivityEmbedding, $$ActivityEmbeddingsTableReferences),
          ActivityEmbedding,
          PrefetchHooks Function({bool activityId})
        > {
  $$ActivityEmbeddingsTableTableManager(
    _$AppDatabase db,
    $ActivityEmbeddingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityEmbeddingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityEmbeddingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityEmbeddingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> activityId = const Value.absent(),
                Value<Uint8List> vector = const Value.absent(),
              }) => ActivityEmbeddingsCompanion(
                id: id,
                activityId: activityId,
                vector: vector,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int activityId,
                required Uint8List vector,
              }) => ActivityEmbeddingsCompanion.insert(
                id: id,
                activityId: activityId,
                vector: vector,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivityEmbeddingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({activityId = false}) {
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
                    if (activityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activityId,
                                referencedTable:
                                    $$ActivityEmbeddingsTableReferences
                                        ._activityIdTable(db),
                                referencedColumn:
                                    $$ActivityEmbeddingsTableReferences
                                        ._activityIdTable(db)
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

typedef $$ActivityEmbeddingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityEmbeddingsTable,
      ActivityEmbedding,
      $$ActivityEmbeddingsTableFilterComposer,
      $$ActivityEmbeddingsTableOrderingComposer,
      $$ActivityEmbeddingsTableAnnotationComposer,
      $$ActivityEmbeddingsTableCreateCompanionBuilder,
      $$ActivityEmbeddingsTableUpdateCompanionBuilder,
      (ActivityEmbedding, $$ActivityEmbeddingsTableReferences),
      ActivityEmbedding,
      PrefetchHooks Function({bool activityId})
    >;
typedef $$ReachZoneRecipesTableCreateCompanionBuilder =
    ReachZoneRecipesCompanion Function({
      Value<int> id,
      required int protocolId,
      required String joint,
      required String kind,
      Value<double> validateAngle,
      Value<double?> zoneMin,
      Value<double?> zoneMax,
      required int colorValue,
      required int sortOrder,
    });
typedef $$ReachZoneRecipesTableUpdateCompanionBuilder =
    ReachZoneRecipesCompanion Function({
      Value<int> id,
      Value<int> protocolId,
      Value<String> joint,
      Value<String> kind,
      Value<double> validateAngle,
      Value<double?> zoneMin,
      Value<double?> zoneMax,
      Value<int> colorValue,
      Value<int> sortOrder,
    });

final class $$ReachZoneRecipesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReachZoneRecipesTable, ReachZoneRecipe> {
  $$ReachZoneRecipesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationProtocolsTable _protocolIdTable(_$AppDatabase db) =>
      db.observationProtocols.createAlias(
        'reach_zone_recipes__protocol_id__observation_protocols__id',
      );

  $$ObservationProtocolsTableProcessedTableManager get protocolId {
    final $_column = $_itemColumn<int>('protocol_id')!;

    final manager = $$ObservationProtocolsTableTableManager(
      $_db,
      $_db.observationProtocols,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_protocolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReachZoneIntervalsTable, List<ReachZoneInterval>>
  _reachZoneIntervalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.reachZoneIntervals,
        aliasName: 'reach_zone_recipes__id__reach_zone_intervals__recipe_id',
      );

  $$ReachZoneIntervalsTableProcessedTableManager get reachZoneIntervalsRefs {
    final manager = $$ReachZoneIntervalsTableTableManager(
      $_db,
      $_db.reachZoneIntervals,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reachZoneIntervalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReachZoneRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $ReachZoneRecipesTable> {
  $$ReachZoneRecipesTableFilterComposer({
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

  ColumnFilters<String> get joint => $composableBuilder(
    column: $table.joint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get validateAngle => $composableBuilder(
    column: $table.validateAngle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get zoneMin => $composableBuilder(
    column: $table.zoneMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get zoneMax => $composableBuilder(
    column: $table.zoneMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationProtocolsTableFilterComposer get protocolId {
    final $$ObservationProtocolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.observationProtocols,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationProtocolsTableFilterComposer(
            $db: $db,
            $table: $db.observationProtocols,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reachZoneIntervalsRefs(
    Expression<bool> Function($$ReachZoneIntervalsTableFilterComposer f) f,
  ) {
    final $$ReachZoneIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reachZoneIntervals,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReachZoneIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.reachZoneIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReachZoneRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReachZoneRecipesTable> {
  $$ReachZoneRecipesTableOrderingComposer({
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

  ColumnOrderings<String> get joint => $composableBuilder(
    column: $table.joint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get validateAngle => $composableBuilder(
    column: $table.validateAngle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get zoneMin => $composableBuilder(
    column: $table.zoneMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get zoneMax => $composableBuilder(
    column: $table.zoneMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationProtocolsTableOrderingComposer get protocolId {
    final $$ObservationProtocolsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableOrderingComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ReachZoneRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReachZoneRecipesTable> {
  $$ReachZoneRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get joint =>
      $composableBuilder(column: $table.joint, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get validateAngle => $composableBuilder(
    column: $table.validateAngle,
    builder: (column) => column,
  );

  GeneratedColumn<double> get zoneMin =>
      $composableBuilder(column: $table.zoneMin, builder: (column) => column);

  GeneratedColumn<double> get zoneMax =>
      $composableBuilder(column: $table.zoneMax, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ObservationProtocolsTableAnnotationComposer get protocolId {
    final $$ObservationProtocolsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.protocolId,
          referencedTable: $db.observationProtocols,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationProtocolsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationProtocols,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> reachZoneIntervalsRefs<T extends Object>(
    Expression<T> Function($$ReachZoneIntervalsTableAnnotationComposer a) f,
  ) {
    final $$ReachZoneIntervalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.reachZoneIntervals,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReachZoneIntervalsTableAnnotationComposer(
                $db: $db,
                $table: $db.reachZoneIntervals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReachZoneRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReachZoneRecipesTable,
          ReachZoneRecipe,
          $$ReachZoneRecipesTableFilterComposer,
          $$ReachZoneRecipesTableOrderingComposer,
          $$ReachZoneRecipesTableAnnotationComposer,
          $$ReachZoneRecipesTableCreateCompanionBuilder,
          $$ReachZoneRecipesTableUpdateCompanionBuilder,
          (ReachZoneRecipe, $$ReachZoneRecipesTableReferences),
          ReachZoneRecipe,
          PrefetchHooks Function({bool protocolId, bool reachZoneIntervalsRefs})
        > {
  $$ReachZoneRecipesTableTableManager(
    _$AppDatabase db,
    $ReachZoneRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReachZoneRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReachZoneRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReachZoneRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> protocolId = const Value.absent(),
                Value<String> joint = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> validateAngle = const Value.absent(),
                Value<double?> zoneMin = const Value.absent(),
                Value<double?> zoneMax = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ReachZoneRecipesCompanion(
                id: id,
                protocolId: protocolId,
                joint: joint,
                kind: kind,
                validateAngle: validateAngle,
                zoneMin: zoneMin,
                zoneMax: zoneMax,
                colorValue: colorValue,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int protocolId,
                required String joint,
                required String kind,
                Value<double> validateAngle = const Value.absent(),
                Value<double?> zoneMin = const Value.absent(),
                Value<double?> zoneMax = const Value.absent(),
                required int colorValue,
                required int sortOrder,
              }) => ReachZoneRecipesCompanion.insert(
                id: id,
                protocolId: protocolId,
                joint: joint,
                kind: kind,
                validateAngle: validateAngle,
                zoneMin: zoneMin,
                zoneMax: zoneMax,
                colorValue: colorValue,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReachZoneRecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({protocolId = false, reachZoneIntervalsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (reachZoneIntervalsRefs) db.reachZoneIntervals,
                  ],
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
                        if (protocolId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.protocolId,
                                    referencedTable:
                                        $$ReachZoneRecipesTableReferences
                                            ._protocolIdTable(db),
                                    referencedColumn:
                                        $$ReachZoneRecipesTableReferences
                                            ._protocolIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (reachZoneIntervalsRefs)
                        await $_getPrefetchedData<
                          ReachZoneRecipe,
                          $ReachZoneRecipesTable,
                          ReachZoneInterval
                        >(
                          currentTable: table,
                          referencedTable: $$ReachZoneRecipesTableReferences
                              ._reachZoneIntervalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReachZoneRecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).reachZoneIntervalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
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

typedef $$ReachZoneRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReachZoneRecipesTable,
      ReachZoneRecipe,
      $$ReachZoneRecipesTableFilterComposer,
      $$ReachZoneRecipesTableOrderingComposer,
      $$ReachZoneRecipesTableAnnotationComposer,
      $$ReachZoneRecipesTableCreateCompanionBuilder,
      $$ReachZoneRecipesTableUpdateCompanionBuilder,
      (ReachZoneRecipe, $$ReachZoneRecipesTableReferences),
      ReachZoneRecipe,
      PrefetchHooks Function({bool protocolId, bool reachZoneIntervalsRefs})
    >;
typedef $$ReachZoneIntervalsTableCreateCompanionBuilder =
    ReachZoneIntervalsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int recipeId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
    });
typedef $$ReachZoneIntervalsTableUpdateCompanionBuilder =
    ReachZoneIntervalsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> recipeId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
    });

final class $$ReachZoneIntervalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReachZoneIntervalsTable,
          ReachZoneInterval
        > {
  $$ReachZoneIntervalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ObservationSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.observationSessions.createAlias(
        'reach_zone_intervals__session_id__observation_sessions__id',
      );

  $$ObservationSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$ObservationSessionsTableTableManager(
      $_db,
      $_db.observationSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReachZoneRecipesTable _recipeIdTable(_$AppDatabase db) => db
      .reachZoneRecipes
      .createAlias('reach_zone_intervals__recipe_id__reach_zone_recipes__id');

  $$ReachZoneRecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$ReachZoneRecipesTableTableManager(
      $_db,
      $_db.reachZoneRecipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReachZoneIntervalsTableFilterComposer
    extends Composer<_$AppDatabase, $ReachZoneIntervalsTable> {
  $$ReachZoneIntervalsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ObservationSessionsTableFilterComposer get sessionId {
    final $$ObservationSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.observationSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationSessionsTableFilterComposer(
            $db: $db,
            $table: $db.observationSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReachZoneRecipesTableFilterComposer get recipeId {
    final $$ReachZoneRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.reachZoneRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReachZoneRecipesTableFilterComposer(
            $db: $db,
            $table: $db.reachZoneRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReachZoneIntervalsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReachZoneIntervalsTable> {
  $$ReachZoneIntervalsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ObservationSessionsTableOrderingComposer get sessionId {
    final $$ObservationSessionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableOrderingComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ReachZoneRecipesTableOrderingComposer get recipeId {
    final $$ReachZoneRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.reachZoneRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReachZoneRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.reachZoneRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReachZoneIntervalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReachZoneIntervalsTable> {
  $$ReachZoneIntervalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$ObservationSessionsTableAnnotationComposer get sessionId {
    final $$ObservationSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.observationSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ReachZoneRecipesTableAnnotationComposer get recipeId {
    final $$ReachZoneRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.reachZoneRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReachZoneRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.reachZoneRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReachZoneIntervalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReachZoneIntervalsTable,
          ReachZoneInterval,
          $$ReachZoneIntervalsTableFilterComposer,
          $$ReachZoneIntervalsTableOrderingComposer,
          $$ReachZoneIntervalsTableAnnotationComposer,
          $$ReachZoneIntervalsTableCreateCompanionBuilder,
          $$ReachZoneIntervalsTableUpdateCompanionBuilder,
          (ReachZoneInterval, $$ReachZoneIntervalsTableReferences),
          ReachZoneInterval,
          PrefetchHooks Function({bool sessionId, bool recipeId})
        > {
  $$ReachZoneIntervalsTableTableManager(
    _$AppDatabase db,
    $ReachZoneIntervalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReachZoneIntervalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReachZoneIntervalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReachZoneIntervalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
              }) => ReachZoneIntervalsCompanion(
                id: id,
                sessionId: sessionId,
                recipeId: recipeId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int recipeId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
              }) => ReachZoneIntervalsCompanion.insert(
                id: id,
                sessionId: sessionId,
                recipeId: recipeId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReachZoneIntervalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, recipeId = false}) {
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
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$ReachZoneIntervalsTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$ReachZoneIntervalsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable:
                                    $$ReachZoneIntervalsTableReferences
                                        ._recipeIdTable(db),
                                referencedColumn:
                                    $$ReachZoneIntervalsTableReferences
                                        ._recipeIdTable(db)
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

typedef $$ReachZoneIntervalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReachZoneIntervalsTable,
      ReachZoneInterval,
      $$ReachZoneIntervalsTableFilterComposer,
      $$ReachZoneIntervalsTableOrderingComposer,
      $$ReachZoneIntervalsTableAnnotationComposer,
      $$ReachZoneIntervalsTableCreateCompanionBuilder,
      $$ReachZoneIntervalsTableUpdateCompanionBuilder,
      (ReachZoneInterval, $$ReachZoneIntervalsTableReferences),
      ReachZoneInterval,
      PrefetchHooks Function({bool sessionId, bool recipeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppUsersTableTableManager get appUsers =>
      $$AppUsersTableTableManager(_db, _db.appUsers);
  $$ObservationProtocolsTableTableManager get observationProtocols =>
      $$ObservationProtocolsTableTableManager(_db, _db.observationProtocols);
  $$ObservableClassesTableTableManager get observableClasses =>
      $$ObservableClassesTableTableManager(_db, _db.observableClasses);
  $$ObservableSubclassesTableTableManager get observableSubclasses =>
      $$ObservableSubclassesTableTableManager(_db, _db.observableSubclasses);
  $$ObservationSessionsTableTableManager get observationSessions =>
      $$ObservationSessionsTableTableManager(_db, _db.observationSessions);
  $$CountEventsTableTableManager get countEvents =>
      $$CountEventsTableTableManager(_db, _db.countEvents);
  $$DurationIntervalsTableTableManager get durationIntervals =>
      $$DurationIntervalsTableTableManager(_db, _db.durationIntervals);
  $$LearnedActivitiesTableTableManager get learnedActivities =>
      $$LearnedActivitiesTableTableManager(_db, _db.learnedActivities);
  $$ActivityEventsTableTableManager get activityEvents =>
      $$ActivityEventsTableTableManager(_db, _db.activityEvents);
  $$ActivityIntervalsTableTableManager get activityIntervals =>
      $$ActivityIntervalsTableTableManager(_db, _db.activityIntervals);
  $$ActivityEmbeddingsTableTableManager get activityEmbeddings =>
      $$ActivityEmbeddingsTableTableManager(_db, _db.activityEmbeddings);
  $$ReachZoneRecipesTableTableManager get reachZoneRecipes =>
      $$ReachZoneRecipesTableTableManager(_db, _db.reachZoneRecipes);
  $$ReachZoneIntervalsTableTableManager get reachZoneIntervals =>
      $$ReachZoneIntervalsTableTableManager(_db, _db.reachZoneIntervals);
}
