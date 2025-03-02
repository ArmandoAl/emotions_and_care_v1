import 'package:emotions_and_care_v1/helpers/navigation_bloc.dart';

import '../helpers/paths.dart';

class DrawerWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int) changeIndex;
  final int? animatedIndex;
  final int? dynamicIndex;
  const DrawerWidget(
      {super.key,
      required this.currentIndex,
      required this.changeIndex,
      this.animatedIndex,
      this.dynamicIndex});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

const drawerDynaicIndexNumbers = {
  "register": 1,
  "firstTestCompleted": 5,
  "registerSuccess": -1,
};

class _NavigationItem {
  final NavigationItem item;
  final String title;
  final IconData icon;

  _NavigationItem(this.item, this.title, this.icon);
}

class _DrawerWidgetState extends State<DrawerWidget>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation _animation;
  int? dinamicIndex;

  final List<_NavigationItem> _itemList = [
    _NavigationItem(NavigationItem.home, 'Jardín', Icons.home),
    _NavigationItem(
        NavigationItem.test, 'Cuestionarios', Icons.question_answer),
    _NavigationItem(NavigationItem.dairy, 'Diario', Icons.mode_outlined),
    _NavigationItem(NavigationItem.community, 'Comunidad', Icons.people),
    _NavigationItem(NavigationItem.schedule, 'Agenda', Icons.book_sharp),
    _NavigationItem(NavigationItem.settings, 'Configuración', Icons.settings),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = ColorTween(
      begin: const Color.fromARGB(255, 255, 255, 255),
      end: const Color.fromARGB(255, 251, 255, 0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerFlow =
        context.watch<BegginCubit>().state.registerPatientFlow ??
            "registerSuccess";

    dinamicIndex = drawerDynaicIndexNumbers[registerFlow]!;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.55,
      child: AnimatedContainer(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.008,
        ),
        duration: const Duration(milliseconds: 250),
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView(
                  children: [
                    ..._itemList.map((item) {
                      return BlocBuilder<NavigationBloc, NavigationState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: _menuItem(
                              context: context,
                              title: item.title,
                              icon: item.icon,
                              index: item.item.index,
                              currentIndex: widget.currentIndex,
                              changeIndex: widget.changeIndex,
                              dynamicIndex: dinamicIndex,
                              animationController: _animationController,
                              animation: _animation,
                              onTap: () {
                                if (item.item.index != widget.currentIndex) {
                                  BlocProvider.of<NavigationBloc>(context).add(
                                    NavigateTo(item.item),
                                  );

                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          );
                        },
                      );
                    })
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      context.read<ScheduleCubit>().clean();
                      context.read<HomeCubit>().clean();

                      // emotionCubit.clean();

                      context.read<CommunityCubit>().clean();

                      context.read<DailyCubit>().clean();

                      context.read<TestCubit>().clean();

                      context.read<UICubit>().clean();

                      context.read<BegginCubit>().logout();

                      context.read<PattientsDatesCubit>().clean();
                    },
                    icon: Icon(Icons.help,
                        size: MediaQuery.of(context).size.width * 0.1)),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _menuItem({
  required BuildContext context,
  required String title,
  required IconData icon,
  required int index,
  required int currentIndex,
  required Function(int) changeIndex,
  required int? dynamicIndex,
  required AnimationController animationController,
  required Animation animation,
  required Function onTap,
}) {
  bool isSelected = index == currentIndex;

  if (dynamicIndex! >= 0 && dynamicIndex == index) {
    //animatedTextListTitle
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            leading: Icon(
              size: MediaQuery.of(context).size.width * 0.05,
              icon,
            ),
            onTap: () {
              onTap();
            },
            selected: isSelected,
          );
        });
  } else {
    return ListTile(
      enabled: dynamicIndex >= 0 ? false : true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
      leading: Icon(
        size: MediaQuery.of(context).size.width * 0.05,
        icon,
      ),
      onTap: () {
        onTap();
      },
      selected: isSelected,
    );
  }
}
