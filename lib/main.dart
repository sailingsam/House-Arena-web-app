import 'package:flutter/material.dart';
import 'package:web_app_house_arena_basic/auth.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 183, 58, 58)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}