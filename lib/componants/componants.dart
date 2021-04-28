import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required Function validator,
  Function onTap,
  @required TextInputType type,
  @required Widget pIcon,
  @required String label,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: type,
      onTap: onTap,
      decoration: InputDecoration(
          prefixIcon: pIcon, labelText: label, border: OutlineInputBorder()),
    );

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    background: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.delete,
            color: Colors.black45,
            size: 35,
          ),
          Icon(
            Icons.delete,
            color: Colors.black45,
            size: 35,
          ),
        ],
      ),
      color: Colors.red,
    ),
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model['id']);
    },
    child: Container(
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '${model['data']}',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.check_circle_outline,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                AppCubit.get(context)
                    .updateData(statues: 'done', id: model['id']);
              }),
          IconButton(
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
              onPressed: () {
                AppCubit.get(context)
                    .updateData(statues: 'archived', id: model['id']);
              })
        ],
      ),
    ),
  );
}

Widget tasksBuilder({@required List<Map> tasks}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    fallback: (context) => Center(
      child: Text(
        'No tasks yet',
        style: TextStyle(fontSize: 20, color: Colors.black45),
      ),
    ),
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Padding(
              padding: EdgeInsetsDirectional.only(start: 20, end: 20),
              child: Container(
                height: 1.0,
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                width: double.infinity,
              ),
            ),
        itemCount: tasks.length),
  );
}
