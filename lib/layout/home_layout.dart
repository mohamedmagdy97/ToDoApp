import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/componants/componants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if (cubit.isBottomSheetDown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertData(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                    titleController.text = '';
                    timeController.text = '';
                    dateController.text = '';
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: EdgeInsets.all(20),

                          // height: 150,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                    controller: titleController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Title must not be empty';
                                      }
                                      return null;
                                    },
                                    type: TextInputType.text,
                                    pIcon: Icon(Icons.title),
                                    label: 'Task Title'),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                    controller: timeController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Date must not be empty';
                                      }
                                    },
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value.format(context);
                                      });
                                    },
                                    type: TextInputType.text,
                                    pIcon: Icon(Icons.watch_later_outlined),
                                    label: 'Task Time'),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                    controller: dateController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Date must not be empty';
                                      }
                                    },
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2021-12-01'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value);
                                      });
                                    },
                                    type: TextInputType.datetime,
                                    pIcon: Icon(Icons.calendar_today),
                                    label: 'Task Date'),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.add);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.done);
                }

                // insertData();
              },
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDataBaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
