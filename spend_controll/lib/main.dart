import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:spend_controll/modules/app_modules.dart';

import 'modules/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
