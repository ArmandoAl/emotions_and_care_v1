import '../../../../helpers/paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomUIScreen extends StatefulWidget {
  static const String route = 'home';
  final Function tap;
  final String? registerFlow;
  const CustomUIScreen(
      {super.key, required this.tap, required this.registerFlow});

  @override
  State<CustomUIScreen> createState() => _CustomUIScreenState();
}

class _CustomUIScreenState extends State<CustomUIScreen>
    with TickerProviderStateMixin {
  AnimationController? _stickersController;
  Animation<double>? _stickersAnimation;

  AnimationController? _animationController;
  Animation? _animation;

  late UICubit uiProvider;
  late BegginCubit userProvider;

  @override
  void initState() {
    super.initState();
    uiProvider = getIt<UICubit>();
    userProvider = getIt<BegginCubit>();

    if (mounted) {
      _stickersController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      )..repeat(reverse: true);
      // Configurar la animación de los stickers
      _stickersAnimation = Tween<double>(
        begin: 1.0,
        end:
            1.1, // Cambia este valor a lo que desees (un poco más grande que 1.0)
      ).animate(
        CurvedAnimation(
          parent: _stickersController!,
          curve: Curves.easeInOut,
        ),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _stickersController!.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _stickersController!.forward();
          }
        });

      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      )..repeat(reverse: true);

      _animation = ColorTween(
        begin: const Color.fromARGB(255, 255, 255, 255),
        end: const Color.fromARGB(255, 87, 87, 83),
      ).animate(_animationController!);

      if (widget.registerFlow != null &&
          widget.registerFlow != "registerSuccess") {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showMessageDialog(context, "Hora de personalizar",
              "Elige una planta que te acompañará en esta aventura. A medida que avances, tu planta florecerá, reflejando tu progreso y bienestar. |Cada vez que la veas, será un recordatorio de tu crecimiento personal. Selecciona la maceta para elegir tu planta.",
              dimiss: false);
        });
      }
    }
  }

  @override
  void dispose() {
    _stickersController?.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 161, 210, 238),
      ),
      child: BlocConsumer<UICubit, UIState>(
          bloc: uiProvider,
          listener: (context, state) {},
          builder: (BuildContext context, UIState state) {
            if (state.status == UIStatus.loading) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }

            return Stack(
              children: [
                state.selectedBackground != "null"
                    ? SvgPicture.asset(
                        state.selectedBackground,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : const SizedBox(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    children: [
                      macetaConPlanta(
                        context,
                        true,
                        uiProvider,
                        state,
                        _animationController,
                        _animation,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.wood),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.08,
                  child: stickerWidget(
                      context,
                      getStickerFromState(state, 0),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      state,
                      0,
                      true),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: stickerWidget(
                      context,
                      getStickerFromState(state, 1),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      state,
                      1,
                      true),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.width * 0.09,
                  child: stickerWidget(
                      context,
                      getStickerFromState(state, 2),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      state,
                      2,
                      true),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.13,
                  right: MediaQuery.of(context).size.width * 0.008,
                  child: stickerWidget(
                      context,
                      getStickerFromState(state, 3),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      state,
                      3,
                      true),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.01,
                    child: Builder(builder: (context) {
                      return IconButton(
                        icon: Icon(Icons.check_circle,
                            color: const Color(
                              0xff064ACB,
                            ),
                            size: MediaQuery.of(context).size.width * 0.1),
                        onPressed: () async {
                          if (uiProvider.state.currentFlower == null) {
                            await widget.tap();
                            return;
                          }

                          if (widget.registerFlow != "registerSuccess") {
                            final userProvider = context.read<BegginCubit>();
                            userProvider.setRegisterFlow(
                                userProvider.state.patientModel!.id!,
                                "registerSuccess");
                          }

                          if (context.mounted) Navigator.of(context).pop();
                        },
                      );
                    })),
              ],
            );
          }),
    );
  }
}
