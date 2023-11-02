import 'package:flutter/material.dart';
import 'package:testtask/UI/screens/home_screen.dart';

import 'package:testtask/styles/styles.dart';
import 'package:testtask/utils/service_locator.dart';

Future<void> main() async {
  registerSingleton();

  await initializeServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
      home: const HomeScreen(),
    );
  }
}
