// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/NoteProvider.dart';
import 'screen/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: HomeScreen(),
      ),
    );
  }
}
