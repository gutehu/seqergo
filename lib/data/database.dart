import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class AppUsers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get salt => text()();
  DateTimeColumn get createdAt => dateTime()();
}

class ObservationProtocols extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(
    AppUsers,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get name => text()();
  BoolColumn get useManual => boolean().withDefault(const Constant(false))();
  BoolColumn get useReachZones => boolean().withDefault(const Constant(false))();
  BoolColumn get useActivity => boolean().withDefault(const Constant(false))();
  TextColumn get activityEngine =>
      text().withDefault(const Constant('observer'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class ObservableClasses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get protocolId => integer().nullable().references(
    ObservationProtocols,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

class ObservableSubclasses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get classId => integer().references(
    ObservableClasses,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get name => text()();
  TextColumn get metricType => text()();
  IntColumn get colorValue => integer()();
  IntColumn get sortOrder => integer()();
}

class ObservationSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  BoolColumn get useManual => boolean().withDefault(const Constant(true))();
  BoolColumn get useReachZones => boolean().withDefault(const Constant(false))();
  BoolColumn get useActivity => boolean().withDefault(const Constant(false))();
  TextColumn get activityEngine =>
      text().withDefault(const Constant('observer'))();
  IntColumn get protocolId => integer().nullable().references(
    ObservationProtocols,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get userId => integer().nullable().references(
    AppUsers,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get name => text().withDefault(const Constant(''))();
}

class CountEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(
    ObservationSessions,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get subclassId => integer().references(
    ObservableSubclasses,
    #id,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get occurredAt => dateTime()();
}

class DurationIntervals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(
    ObservationSessions,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get subclassId => integer().references(
    ObservableSubclasses,
    #id,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
}

class LearnedActivities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get protocolId => integer().nullable().references(
    ObservationProtocols,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get name => text()();
  TextColumn get clipPath => text()();
  IntColumn get colorValue => integer()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get kind => text().withDefault(const Constant('visual'))();
}

class ActivityEmbeddings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get activityId => integer().references(
    LearnedActivities,
    #id,
    onDelete: KeyAction.cascade,
  )();
  BlobColumn get vector => blob()();
}

class ActivityEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(
    ObservationSessions,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get activityId => integer().references(
    LearnedActivities,
    #id,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get occurredAt => dateTime()();
}

class ActivityIntervals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(
    ObservationSessions,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get activityId => integer().references(
    LearnedActivities,
    #id,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
}

class ReachZoneRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get protocolId => integer().references(
    ObservationProtocols,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get joint => text()();
  TextColumn get kind => text()();
  RealColumn get validateAngle => real().withDefault(const Constant(90))();
  RealColumn get zoneMin => real().nullable()();
  RealColumn get zoneMax => real().nullable()();
  IntColumn get colorValue => integer()();
  IntColumn get sortOrder => integer()();
}

class ReachZoneIntervals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(
    ObservationSessions,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get recipeId => integer().references(
    ReachZoneRecipes,
    #id,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
}

@DriftDatabase(
  tables: [
    AppUsers,
    ObservationProtocols,
    ObservableClasses,
    ObservableSubclasses,
    ObservationSessions,
    CountEvents,
    DurationIntervals,
    LearnedActivities,
    ActivityEvents,
    ActivityIntervals,
    ActivityEmbeddings,
    ReachZoneRecipes,
    ReachZoneIntervals,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.addColumn(observationSessions, observationSessions.useManual);
          await m.addColumn(observationSessions, observationSessions.useReachZones);
          await m.addColumn(observationSessions, observationSessions.useActivity);
          await m.createTable(learnedActivities);
          await m.createTable(activityEvents);
          await m.createTable(activityIntervals);
        }
        if (from < 3) {
          await m.addColumn(
            observationSessions,
            observationSessions.activityEngine,
          );
          await m.addColumn(learnedActivities, learnedActivities.kind);
          await m.createTable(activityEmbeddings);
        }
        if (from < 4) {
          await m.createTable(appUsers);
          await m.createTable(observationProtocols);
          await m.addColumn(observableClasses, observableClasses.protocolId);
          await m.addColumn(learnedActivities, learnedActivities.protocolId);
          await m.addColumn(observationSessions, observationSessions.protocolId);
          await m.addColumn(observationSessions, observationSessions.userId);
        }
        if (from < 5) {
          await m.createTable(reachZoneRecipes);
          await m.createTable(reachZoneIntervals);
        }
        if (from < 6) {
          await m.addColumn(observationSessions, observationSessions.name);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'seqergo');
  }
}
