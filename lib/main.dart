import 'package:flutter/material.dart';
import 'package:youtube_clone_app/features/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Clone',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

