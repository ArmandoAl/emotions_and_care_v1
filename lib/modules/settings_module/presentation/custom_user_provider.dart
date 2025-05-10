import 'dart:async';
import '../../../helpers/paths.dart';

enum ItemUiType { colores, fondo, jardin, flores }

class CustomMenuScreen extends StatefulWidget {
  final BegginCubit userProvider;
  final UICubit uiProvider;
  const CustomMenuScreen(
      {super.key, required this.userProvider, required this.uiProvider});

  @override
  State<CustomMenuScreen> createState() => _CustomMenuScreenState();
}

class _CustomMenuScreenState extends State<CustomMenuScreen>
    with SingleTickerProviderStateMixin {
  late BegginCubit userProvider;
  bool animatedMenu = false;
  AnimationController? _animationController;
  Animation<Color?>? _animation;
  bool _isControllerDisposed = false;

  StreamSubscription? _cubitSubscription;

  @override
  void initState() {
    super.initState();
    userProvider = widget.userProvider;
    animatedMenu = animatedMenuBools[
            userProvider.state.registerPatientFlow ?? "registerSuccess"] ??
        false;

    if (animatedMenu) {
      _createAnimationController();
    }

    _cubitSubscription = userProvider.stream.listen((state) {
      if (!mounted) return;

      setState(() {
        animatedMenu =
            animatedMenuBools[state.registerPatientFlow ?? "registerSuccess"]!;
        if (animatedMenu) {
          _disposeAnimationController();
          _createAnimationController();
        } else {
          _disposeAnimationController();
        }
      });
    });
  }

  void _createAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = ColorTween(
      begin: const Color.fromARGB(255, 224, 10, 10),
      end: const Color.fromARGB(255, 56, 5, 159),
    ).animate(_animationController!);
  }

  void _disposeAnimationController() {
    if (_isControllerDisposed) return;

    _animationController?.dispose();
    _isControllerDisposed = true;
  }

  @override
  void dispose() {
    _cubitSubscription?.cancel();
    _disposeAnimationController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalización'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            listItemCustom(
                context,
                "Paleta de colores",
                const AssetImage(
                  Assets.colorPallete,
                ), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeUiItemScreen(
                    userProvider: widget.userProvider,
                    uiProvider: widget.uiProvider,
                    itemType: ItemUiType.colores,
                    items: [
                      widget.uiProvider.state.themes[0],
                      // widget.uiProvider.state.themes[1],
                    ],
                    blocks: const [false, false, true, false],
                  ),
                ),
              );
            }, animatedMenu, false, _animationController, _animation),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            listItemCustom(context, "Fondo de pantalla",
                const AssetImage(Assets.backPickerIcon), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeUiItemScreen(
                    userProvider: widget.userProvider,
                    uiProvider: widget.uiProvider,
                    itemType: ItemUiType.fondo,
                    items: const [
                      Assets.yardBackgroundLottieAnimation,
                      Assets.starBackgroundLottieAnimation,
                    ],
                    blocks: const [false, true, false, false],
                  ),
                ),
              );
            }, animatedMenu, false, _animationController, _animation),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            listItemCustom(
                context,
                "Perzonalizar jardín",
                const AssetImage(
                  Assets.patioIcon,
                ), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          plane: null,
                          tap: () async {
                            final uiProvider = context.read<UICubit>();

                            if (uiProvider.state.currentFlower == null) {
                              await showMessageDialog(context, "",
                                  'Por favor debes elegir una planta para poder continuar, haz clic en la maceta para elegir una.');
                            }
                          },
                          registerFlow: userProvider.state.registerPatientFlow,
                          customEnable: true,
                        )),
              );
            }, false, animatedMenu, _animationController, _animation),
          ],
        ),
      ),
    );
  }
}

Widget listItemCustom(
  BuildContext context,
  String title,
  AssetImage icon,
  Function onTap,
  bool disable,
  bool animate,
  AnimationController? animationController,
  Animation<Color?>? animation,
) {
  return InkWell(
    onTap: () {
      if (!disable) {
        onTap();
      }
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          disable == false && animate == true
              ? AnimatedBuilder(
                  animation: animationController!,
                  builder: (context, child) => Text(
                    title,
                    style: TextStyle(
                        color: animation!.value ??
                            Theme.of(context).colorScheme.onSurface,
                        fontSize: 22),
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: disable
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.onSurface),
                ),
          const Spacer(),
          Image(
            image: icon,
            width: MediaQuery.of(context).size.width * 0.1,
          ),
        ],
      ),
    ),
  );
}
