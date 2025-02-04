import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'view/screen/notepad_screen.dart';

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
  Box box = await Hive.openBox('notepad');
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

      ),
      home: const NotepadScreen(),
    );
  }
}
