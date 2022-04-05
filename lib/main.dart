import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/my_app.dart';
import 'package:todo_app/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
