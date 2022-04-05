part of 'BuilHomeLayoutWidgets.dart';

class BuildFloatingActionButton extends StatelessWidget {
  const BuildFloatingActionButton(
      {Key? key, required this.cubit, required this.homeLayoutData})
      : super(key: key);

  final AppCubit cubit;

  final HomeLayoutData homeLayoutData;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(cubit.fabIcon),
      onPressed: () {
        if (cubit.isBottomSheetDown) {
          if (homeLayoutData.formKey.currentState!.validate()) {
            cubit.insertData(
              title: homeLayoutData.titleController.text,
              time: homeLayoutData.timeController.text,
              date: homeLayoutData.dateController.text,
            );
            homeLayoutData.titleController.text = '';
            homeLayoutData.timeController.text = '';
            homeLayoutData.dateController.text = '';
          }
        } else {
          homeLayoutData.scaffoldKey.currentState
              ?.showBottomSheet(
                (context) =>
                    BuildInputsFormField(homeLayoutData: homeLayoutData),
                elevation: 20,
              )
              .closed
              .then((value) {
            cubit.changeBottomSheetState(isShow: false, icon: Icons.add);
          });
          cubit.changeBottomSheetState(isShow: true, icon: Icons.done);
        }

        // insertData();
      },
    );
  }
}
