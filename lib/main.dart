import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Loads pt_BR date symbols so DateFormat('...', 'pt_BR') works app-wide.
  await initializeDateFormatting('pt_BR', null);
  runApp(const TravelApp());
}
