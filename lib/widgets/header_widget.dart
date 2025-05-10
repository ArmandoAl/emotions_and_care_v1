import 'dart:async';
import 'package:emotions_and_care_v1/helpers/paths.dart';

class HeaderWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isForReturn;
  final List<Widget>? actions;
  const HeaderWidget({
    super.key,
    required this.title,
    required this.isForReturn,
    this.actions,
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
  Animation<Color?>? _buttonAnimation;
  String status = "";
  bool animatedMenu = false;
  bool _isControllerDisposed = false; // Nueva bandera para rastrear el estado
  StreamSubscription? _cubitSubscription;

  @override
  void initState() {
    super.initState();
    begginCubit = getIt<BegginCubit>();
    animatedMenu = animatedMenuBools[
            begginCubit.state.registerPatientFlow ?? "registerSuccess"] ??
        false;

    if (animatedMenu) {
      _createAnimationController();
    }

    // Escuchar el stream del cubit y almacenar la suscripción
    _cubitSubscription = begginCubit.stream.listen((state) {
      if (!mounted) return; // Verificar si el widget está montado

      setState(() {
        status = state.registerPatientFlow ?? "";
        animatedMenu = animatedMenuBools[status]!;

        if (animatedMenu) {
          _disposeAnimationController(); // Asegurarse de eliminar el anterior
          _createAnimationController();
        } else {
          _disposeAnimationController();
        }
      });
    });
  }

  void _createAnimationController() {
    _isControllerDisposed = false; // Restablecer bandera
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _buttonAnimation = ColorTween(
      begin: const Color.fromARGB(255, 89, 8, 230),
      end: const Color.fromARGB(255, 251, 255, 0),
    ).animate(_buttonController!);
  }

  void _disposeAnimationController() {
    if (!_isControllerDisposed) {
      _buttonController?.dispose();
      _isControllerDisposed = true; // Marcar como eliminado
    }
  }

  @override
  void dispose() {
    _cubitSubscription?.cancel(); // Cancelar la suscripción al stream
    _disposeAnimationController(); // Eliminar el controlador si es necesario
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                icon: const Icon(Icons.arrow_back_rounded,
                    color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : animatedMenu
                ? AnimatedBuilder(
                    animation: _buttonController!,
                    builder: (context, child) {
                      return IconButton(
                        icon: Icon(Icons.menu,
                            color: _buttonAnimation!.value ?? Colors.black,
                            size: MediaQuery.of(context).size.width * 0.08),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
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
      actions: widget.actions,
    );
  }
}

const Map<String, bool> animatedMenuBools = {
  "registerSuccess": false,
  "register": false,
  'firstTestCompleted': true,
};
