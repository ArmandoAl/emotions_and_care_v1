import 'dart:async';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../../helpers/paths.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';
  final NotificationModel? plane;
  final Function tap;
  final String? registerFlow;
  final bool customEnable;
  const HomeScreen({
    super.key,
    required this.plane,
    required this.tap,
    required this.registerFlow,
    required this.customEnable,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.customEnable) {
      return CustomUIScreen(
        tap: widget.tap,
        registerFlow: widget.registerFlow,
      );
    } else {
      return StaticHomeScreen(
        plane: widget.plane,
        registerFlow: widget.registerFlow,
        tap: widget.tap,
      );
    }
  }
}

class StaticHomeScreen extends StatefulWidget {
  static const String route = 'home';
  final NotificationModel? plane;
  final String? registerFlow;
  final Function tap;
  const StaticHomeScreen(
      {super.key,
      required this.plane,
      required this.registerFlow,
      required this.tap});

  @override
  State<StaticHomeScreen> createState() => _StaticHomeScreenState();
}

class _StaticHomeScreenState extends State<StaticHomeScreen>
    with TickerProviderStateMixin {
  double _animationTop = 0;
  double _animationLeft = -0.2;
  double angle = 0;
  bool itGotTheEnd = false;
  AnimationController? _controller;
  Timer? _timer;

  AnimationController? _buttonController;
  Animation<Color?>? _buttonAnimation;

  AnimationController? _flashController;
  Animation<double>? _flashAnimation;

  StreamSubscription? _subscription;

  late UICubit uiProvider;
  late BegginCubit userProvider;

  @override
  void initState() {
    super.initState();
    uiProvider = getIt<UICubit>();
    userProvider = getIt<BegginCubit>();

    if (mounted) {
      _flashController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
      _flashAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _flashController!, curve: Curves.bounceIn));

      if (widget.registerFlow != null && widget.registerFlow == "register") {
        _buttonController = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        )..repeat(reverse: true);

        // Configurar la animación del botón
        _buttonAnimation = ColorTween(
          begin: const Color.fromARGB(255, 224, 10, 10),
          end: const Color.fromARGB(255, 0, 0, 0),
        ).animate(
          CurvedAnimation(
            parent: _buttonController!,
            curve: Curves.easeInOut,
          ),
        )..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _buttonController!.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _buttonController!.forward();
            }
          });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showMessageDialog(context, "¡Hola!",
              "Te damos la bienvenida a Emotions&Care, una aplicación móvil diseñada para la detección y seguimiento de la salud mental de personas que se encuentran estudiando la universidad. |Sabemos que el camino universitario puede ser retador, pero no te preocupes, ¡Estamos aquí para apoyarte en cada paso del camino!. |Por favor, selecciona el menú para iniciar.",
              dimiss: false);
        });
      }

      // if (widget.registerFlow != null &&
      //     widget.registerFlow == "registerSuccess") {}

      //revisar como haremos este dialog
      // ¡Estás listo para despegar hacia el bienestar!
      // Tu avión de recomendaciones diarias está aquí para guiarte.
      // Recibirás recomendaciones diarias y personalizadas que te ayudarán a darle seguimiento tu salud mental
      // Cada día, despegamos hacia nuevas posibilidades y pequeñas acciones que marcarán la diferencia en tu camino hacia el crecimiento personal.
      if (widget.registerFlow != null &&
          widget.registerFlow == "registerSuccess") {
        _controller = AnimationController(
          duration: const Duration(seconds: 3),
          vsync: this,
        )..repeat();

        _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
          _moveBox(_controller!);
        });
      }
    }
  }

  //didChangeDependencies
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscription = context.read<BegginCubit>().stream.listen((event) {
      if (event.status == BegginStatus.growing) {
        if (mounted) {
          playFlashEffect();
        }
      }
    });
  }

  void playFlashEffect() {
    _flashController!.forward().then((value) {
      context.read<UICubit>().growFlowerStage();
      _flashController!.reverse();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.stop();
    _controller?.dispose();
    _buttonController?.stop();
    _buttonController?.dispose();
    _flashController?.stop();
    _flashController?.dispose();
    _subscription?.cancel();
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
      child: BlocBuilder<UICubit, UIState>(
          bloc: uiProvider,
          builder: (BuildContext context, UIState state) {
            if (state.status == UIStatus.loading) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Emotions&Care',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: Scaffold(
                  body: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }

            return Stack(
              children: [
                uiProvider.state.selectedBackground != "null"
                    ? SvgPicture.asset(
                        uiProvider.state.selectedBackground,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : const SizedBox(),
                if (_flashAnimation != null)
                  Positioned(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: FadeTransition(
                          opacity: _flashAnimation ??
                              const AlwaysStoppedAnimation(0),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    children: [
                      macetaConPlanta(
                        context,
                        false,
                        uiProvider,
                        state,
                        null,
                        null,
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
                  child: stickerWidget(context, getStickerFromState(state, 0),
                      null, null, uiProvider, state, 0, false),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: stickerWidget(context, getStickerFromState(state, 1),
                      null, null, uiProvider, state, 1, false),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.width * 0.09,
                  child: stickerWidget(context, getStickerFromState(state, 2),
                      null, null, uiProvider, state, 2, false),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.13,
                  right: MediaQuery.of(context).size.width * 0.008,
                  child: stickerWidget(context, getStickerFromState(state, 3),
                      null, null, uiProvider, state, 3, false),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.01,
                  child: widget.registerFlow != null &&
                          widget.registerFlow == "register"
                      ? AnimatedBuilder(
                          animation: _buttonController!,
                          builder: (context, child) {
                            return IconButton(
                              icon: Icon(Icons.menu,
                                  color:
                                      _buttonAnimation!.value ?? Colors.black,
                                  size:
                                      MediaQuery.of(context).size.width * 0.1),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          },
                        )
                      : Builder(builder: (context) {
                          return IconButton(
                            icon: Icon(Icons.menu,
                                color: const Color(
                                  0xff064ACB,
                                ),
                                size: MediaQuery.of(context).size.width * 0.1),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          );
                        }),
                ),
                widget.plane != null && _controller != null
                    ? AnimatedBuilder(
                        animation: _controller!,
                        builder: (context, child) {
                          return AnimatedPositioned(
                            duration: const Duration(seconds: 1),
                            top: MediaQuery.of(context).size.height *
                                _animationTop,
                            left: MediaQuery.of(context).size.width *
                                _animationLeft,
                            child: GestureDetector(
                              onTap: () {
                                widget.tap();
                              },
                              child: Transform(
                                //flip the plane when it changes direction
                                transform:
                                    Matrix4.rotationY(itGotTheEnd ? 3.14 : 0)
                                      ..rotateZ(angle),

                                alignment: Alignment.center,
                                child: Lottie.asset(
                                  Assets.paperPlaneAnimation,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            );
          }),
    );
  }

  void _moveBox(AnimationController controller) {
    double newTop = sin(controller.value * pi * 2) * 0.1 + 0.4;
    double deltaY = newTop - _animationTop;
    double deltaX = _animationLeft >= 1.5 ? -0.1 : 0.1;
    //si el avion llega al final de la pantalla, cambia de direccion
    double newangle = atan2(deltaY, deltaX);

    if (_animationLeft >= 1.5) {
      itGotTheEnd = true;
    } else if (_animationLeft <= -0.6) {
      itGotTheEnd = false;
    }

    setState(() {
      _animationTop = newTop;
      _animationLeft =
          itGotTheEnd ? _animationLeft - 0.01 : _animationLeft + 0.01;
      angle = newangle;
    });
  }
}

StickerModel? getStickerFromState(UIState state, int index) {
  if (state.stickersInUse.length > index) {
    if (state.stickersInUse[index].url != null &&
        state.stickersInUse[index].url != "") {
      return state.stickersInUse[index];
    } else {
      return null;
    }
  } else {
    return null;
  }
}
