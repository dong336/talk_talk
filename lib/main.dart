import 'package:flutter/material.dart';

import 'package:talk_talk/screens/main_screen.dart';
import 'package:talk_talk/screens/write_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '톡톡',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pinkAccent,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/write': (context) => WriteScreen(),
      },
    );
  }
}