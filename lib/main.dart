import 'package:flutter/material.dart';

import 'app.dart';
import 'data/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SeqErgoApp(database: AppDatabase()));
}
