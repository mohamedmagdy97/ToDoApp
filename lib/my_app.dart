
import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_layout_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomeLayout(),
    );
  }
}