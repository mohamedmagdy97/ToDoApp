part of 'BuilHomeLayoutWidgets.dart';

class BuildInputsFormField extends StatelessWidget {
  const BuildInputsFormField({
    Key? key,
    required this.homeLayoutData,
  }) : super(key: key);

  final HomeLayoutData homeLayoutData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      // height: 150,
      child: Form(
        key: homeLayoutData.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BuildFormField(
                controller: homeLayoutData.titleController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Title must not be empty';
                  }
                  return null;
                },
                type: TextInputType.text,
                pIcon: const Icon(Icons.title),
                label: 'Task Title'),
            const SizedBox(
              height: 15,
            ),
            BuildFormField(
                controller: homeLayoutData.timeController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Date must not be empty';
                  }
                },
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    homeLayoutData.timeController.text = value!.format(context);
                  });
                },
                type: TextInputType.text,
                pIcon: const Icon(Icons.watch_later_outlined),
                label: 'Task Time'),
            const SizedBox(height: 15),
            BuildFormField(
                controller: homeLayoutData.dateController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Date must not be empty';
                  }
                },
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2025-12-01'))
                      .then((value) {
                    homeLayoutData.dateController.text =
                        DateFormat.yMMMd().format(value!);
                  });
                },
                type: TextInputType.datetime,
                pIcon: const Icon(Icons.calendar_today),
                label: 'Task Date'),
          ],
        ),
      ),
    );
  }
}
