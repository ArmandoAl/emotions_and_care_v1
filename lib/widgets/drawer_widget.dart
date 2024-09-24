import 'dart:async';
import 'package:provider/provider.dart';

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
  RegisterPatientFlow.registerSucess: 1,
  RegisterPatientFlow.firstTestCompleted: 5,
  RegisterPatientFlow.homeUiChanged: -1,
};

class _DrawerWidgetState extends State<DrawerWidget>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation _animation;
  int? dinamicIndex;

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
    final registerFlow = context.watch<BegginCubit>().state.registerPatientFlow;

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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    _menuItem(
                        context: context,
                        title: 'Inicio',
                        icon: Icons.home,
                        index: 0,
                        currentIndex: widget.currentIndex,
                        changeIndex: widget.changeIndex,
                        dynamicIndex: dinamicIndex,
                        animationController: _animationController,
                        animation: _animation),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    _menuItem(
                        context: context,
                        title: 'Cuestionarios',
                        icon: Icons.question_answer,
                        index: 1,
                        currentIndex: widget.currentIndex,
                        changeIndex: widget.changeIndex,
                        dynamicIndex: dinamicIndex,
                        animationController: _animationController,
                        animation: _animation),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    _menuItem(
                        context: context,
                        title: 'Diario',
                        icon: Icons.mode_outlined,
                        index: 2,
                        currentIndex: widget.currentIndex,
                        changeIndex: widget.changeIndex,
                        dynamicIndex: dinamicIndex,
                        animationController: _animationController,
                        animation: _animation),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    _menuItem(
                        context: context,
                        title: 'Comunidad',
                        icon: Icons.people,
                        index: 3,
                        currentIndex: widget.currentIndex,
                        changeIndex: widget.changeIndex,
                        dynamicIndex: dinamicIndex,
                        animationController: _animationController,
                        animation: _animation),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    _menuItem(
                        context: context,
                        title: 'Agenda',
                        icon: Icons.book_sharp,
                        index: 4,
                        currentIndex: widget.currentIndex,
                        changeIndex: widget.changeIndex,
                        dynamicIndex: dinamicIndex,
                        animationController: _animationController,
                        animation: _animation),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    _menuItem(
                        context: context,
                        title: 'Configuración',
                        icon: Icons.settings,
                        index: 5,
                        currentIndex: widget.currentIndex,
                        changeIndex: widget.changeIndex,
                        dynamicIndex: dinamicIndex,
                        animationController: _animationController,
                        animation: _animation),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                fontWeight: FontWeight.bold,
                color:
                    animation.value ?? Colors.white, // Aplica el color animado
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            leading: Icon(
              size: MediaQuery.of(context).size.width * 0.05,
              icon,
              color: animation.value ?? Colors.white, // Aplica el color animado
            ),
            onTap: () {
              if (index != currentIndex) {
                Navigator.of(context).pop();

                Timer(const Duration(milliseconds: 250), () {
                  changeIndex(index);
                });
              } else {
                Navigator.of(context).pop();
              }
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
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
      leading: Icon(
        size: MediaQuery.of(context).size.width * 0.05,
        icon,
      ),
      onTap: () {
        if (index != currentIndex) {
          Navigator.of(context).pop();

          Timer(const Duration(milliseconds: 250), () {
            changeIndex(index);
          });
        } else {
          Navigator.of(context).pop();
        }
      },
      selected: isSelected,
    );
  }
}
