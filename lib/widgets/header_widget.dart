import 'package:emotions_and_care_v1/helpers/paths.dart';

class HeaderWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isForReturn;
  final Widget? action;
  const HeaderWidget({
    super.key,
    required this.title,
    required this.isForReturn,
    this.action,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _HeaderWidgetState extends State<HeaderWidget>
    with TickerProviderStateMixin {
  late BegginCubit begginCubit;
  AnimationController? _buttonController;
  Animation<double>? _buttonAnimation;
  String status = "";
  bool animatedMenu = false;

  @override
  void initState() {
    begginCubit = getIt<BegginCubit>();
    animatedMenu = animatedMenuBools[
            begginCubit.state.registerPatientFlow ?? "register"] ??
        false;

    if (animatedMenu) {
      _buttonController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      )..repeat(reverse: true);

      _buttonAnimation = Tween<double>(begin: 1, end: 1.1).animate(
        CurvedAnimation(
          parent: _buttonController!,
          curve: Curves.easeInOut,
        ),
      );
    }

    //listener of the begginCubit state status
    begginCubit.stream.listen((state) {
      setState(() {
        status = state.registerPatientFlow ?? "";

        animatedMenu = animatedMenuBools[status]!;

        if (animatedMenu) {
          // Si ya existe un controlador, lo desecha antes de crear uno nuevo
          _buttonController?.dispose();
          _buttonController = AnimationController(
            vsync: this,
            duration: const Duration(seconds: 1),
          )..repeat(reverse: true);

          _buttonAnimation = Tween<double>(begin: 1, end: 1.1).animate(
            CurvedAnimation(
              parent: _buttonController!,
              curve: Curves.easeInOut,
            ),
          );
        } else {
          _buttonController!.dispose();
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _buttonController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //elevation: 1,
      shadowColor: Colors.black,
      shape: widget.isForReturn
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            )
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
      title: Text(widget.title),
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: widget.isForReturn
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : animatedMenu
                ? AnimatedBuilder(
                    animation: _buttonController!,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _buttonAnimation!.value,
                        child: IconButton(
                          icon: Icon(Icons.menu,
                              color: const Color(
                                0xff064ACB,
                              ),
                              size: MediaQuery.of(context).size.width * 0.1),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      );
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.menu,
                        color: const Color(0xff064ACB),
                        size: MediaQuery.of(context).size.width * 0.08),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
      ),
      actions: widget.action != null
          ? [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: widget.action!)
            ]
          : null,
    );
  }
}

const Map<String, bool> animatedMenuBools = {
  "registerSuccess": false,
  "register": false,
  'firstTestCompleted': true,
};
