import 'package:flutter/material.dart';
import 'package:notes_project/presentation/screen/notes/note_list_screens.dart';
import 'package:notes_project/service/note_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NoteProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ứng dụng Ghi Chú',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NoteListScreen(),
    );
  }
}
