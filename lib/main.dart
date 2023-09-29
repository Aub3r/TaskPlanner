import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import './todo_filter.dart';
import './api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await register();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
