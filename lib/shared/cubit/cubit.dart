import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> title = ['Tasks', 'Done', 'Archived'];
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  Database database;

  createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print('database created');
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT, statues TEXT)')
            .then((value) {
          print('table created');
        }).catchError((onError) {
          print('Error catch : $onError');
        });
      },
      onOpen: (database) {
        getData(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertData({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, data, time, statues) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfully ');
        emit(AppInsertDataBaseState());

        getData(database);
      }).catchError((onError) {
        print('Error : $onError');
      });
      return null;
    });
  }

  void getData(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDataBaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['statues'] == 'new')
          newTasks.add(element);
        else if (element['statues'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDataBaseState());
    });
  }

  void updateData({
    @required String statues,
    @required int id,
  }) async {
    // Update some record
    database.rawUpdate(
      'UPDATE tasks SET statues = ? WHERE id = ?',
      ['$statues', id],
    ).then((value) {
      getData(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({
    @required int id,
  }) async {
    // Update some record
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getData(database);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isBottomSheetDown = false;
  IconData fabIcon = Icons.add;

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetDown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
