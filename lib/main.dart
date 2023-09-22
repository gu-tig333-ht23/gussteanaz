import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'todo_provider.dart';

void main() {
  final todoProvider = ToDoProvider();

  runApp(
    ChangeNotifierProvider(
      create: (context) => todoProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: HomePage(title: 'Att Göra'),
    );
  }
}
