part of 'BuilHomeLayoutWidgets.dart';

class BuildBottomNavigationBar extends StatelessWidget {
  const BuildBottomNavigationBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        cubit.changeIndex(index);
      },
      currentIndex: cubit.currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline), label: 'Done'),
        BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined), label: 'Archived'),
      ],
    );
  }
}
