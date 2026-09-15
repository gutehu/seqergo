import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:seqergo/app.dart';
import 'package:seqergo/data/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase.memory();
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('demande de créer un compte au premier lancement', (tester) async {
    await tester.pumpWidget(SeqErgoApp(database: db));
    await tester.pump();
    await tester.pump();

    expect(find.text('Créer un compte'), findsOneWidget);
    expect(find.text('Créer le compte'), findsOneWidget);
  });

  testWidgets('ouvre le hub après création de compte', (tester) async {
    await tester.pumpWidget(SeqErgoApp(database: db));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byKey(const Key('username')), 'alice');
    await tester.enterText(find.byKey(const Key('password')), 'secret1');
    await tester.tap(find.text('Créer le compte'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Observation'), findsOneWidget);
    expect(find.text('Mes protocoles'), findsOneWidget);
    expect(find.text('Résultats'), findsOneWidget);
  });

  testWidgets('configure un protocole manuel', (tester) async {
    await tester.pumpWidget(SeqErgoApp(database: db));
    await tester.pump();
    await tester.pump();
    await tester.enterText(find.byKey(const Key('username')), 'alice');
    await tester.enterText(find.byKey(const Key('password')), 'secret1');
    await tester.tap(find.text('Créer le compte'));
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Nouveau protocole'));
    await tester.pump();
    await tester.pump();
    await tester.tap(find.text('Mode manuel'));
    await tester.pump();
    await tester.tap(find.text('Configurer le protocole'));
    await tester.pump();
    await tester.pump();

    expect(find.text("Démarrer l'observation"), findsOneWidget);
    expect(find.textContaining("Créez une classe d'observables"), findsOneWidget);
    expect(find.text('Enregistrer'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
