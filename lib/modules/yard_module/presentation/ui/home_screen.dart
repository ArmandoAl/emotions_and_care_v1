import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../../config/assets/assets.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  double _animationTop = 0;
  double _animationLeft = -0.2;
  double angle = 0;
  bool itGotTheEnd = false;
  AnimationController? _controller;
  Timer? _timer;

  AnimationController? _buttonController;
  Animation<Color?>? _buttonAnimation;

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
          showMessageDialog(context, '¡Bienvenido!',
              "Bienvenid@ a Emotions&Care. Dirigete al menú lateral y dirígete a la sección de Cuestionarios para completar tu registro.");
        });
      }

      if (widget.customEnable == true) {
        _stickersController = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
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

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showMessageDialog(context, "Hora de personalizar",
              "Selecciona un espacio para colocar tu sticker.");
        });
      } else {
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

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.stop();
    _controller?.dispose();
    _buttonController?.stop();
    _buttonController?.dispose();
    _stickersController?.stop();
    _stickersController?.dispose();
    _animationController?.stop();
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
      child: BlocBuilder<UICubit, UIState>(
          bloc: uiProvider,
          builder: (BuildContext context, UIState state) {
            if (state.status == UIStatus.loading) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
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
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.01,
                  child: widget.customEnable
                      ? Builder(builder: (context) {
                          return IconButton(
                            icon: Icon(Icons.check_circle,
                                color: const Color(
                                  0xff064ACB,
                                ),
                                size: MediaQuery.of(context).size.width * 0.1),
                            onPressed: () async {
                              // if (uiProvider.state.currentFlower == null) {
                              //   await widget.tap();
                              //   return;
                              // }

                              if (widget.registerFlow != "registerSuccess") {
                                final userProvider =
                                    context.read<BegginCubit>();
                                userProvider.setRegisterFlow(
                                    userProvider.state.patientModel!.id!,
                                    "registerSuccess");

                                await userProvider
                                    .setRegisterSet("registerSuccess");
                              }

                              if (context.mounted) Navigator.of(context).pop();
                            },
                          );
                        })
                      : widget.registerFlow != null &&
                              widget.registerFlow == "register"
                          ? AnimatedBuilder(
                              animation: _buttonController!,
                              builder: (context, child) {
                                return IconButton(
                                  icon: Icon(Icons.menu,
                                      color: _buttonAnimation!.value ??
                                          Colors.black,
                                      size: MediaQuery.of(context).size.width *
                                          0.1),
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
                                    size: MediaQuery.of(context).size.width *
                                        0.1),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              );
                            }),
                ),
                widget.plane != null && widget.customEnable == false
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    children: [
                      macetaConPlanta(
                        context,
                        widget.customEnable,
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
                      getStickerFromState(uiProvider, 0),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      0,
                      widget.customEnable),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: stickerWidget(
                      context,
                      getStickerFromState(uiProvider, 1),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      1,
                      widget.customEnable),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.width * 0.09,
                  child: stickerWidget(
                      context,
                      getStickerFromState(uiProvider, 2),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      2,
                      widget.customEnable),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.13,
                  right: MediaQuery.of(context).size.width * 0.008,
                  child: stickerWidget(
                      context,
                      getStickerFromState(uiProvider, 3),
                      _stickersController,
                      _stickersAnimation,
                      uiProvider,
                      3,
                      widget.customEnable),
                ),
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

StickerModel? getStickerFromState(UICubit uiProvider, int index) {
  if (uiProvider.state.stickersInUse.length > index) {
    if (uiProvider.state.stickersInUse[index].url != null &&
        uiProvider.state.stickersInUse[index].url != "") {
      return uiProvider.state.stickersInUse[index];
    } else {
      return null;
    }
  } else {
    return null;
  }
}
