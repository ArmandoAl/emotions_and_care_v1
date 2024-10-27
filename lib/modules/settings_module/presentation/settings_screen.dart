import 'dart:async';

import '../../../helpers/paths.dart';

class SettingsScreen extends StatefulWidget {
  final BegginCubit userProvider;
  final bool isPattient;
  final UICubit uiProvider;
  final Function logout;
  const SettingsScreen(
      {super.key,
      required this.userProvider,
      required this.isPattient,
      required this.uiProvider,
      required this.logout});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late BegginCubit userProvider;
  bool animatedMenu = true;
  AnimationController? _animationController;
  Animation<Color?>? _animation;
  bool _isControllerDisposed = false;
  bool _dialogShown = false; // Evitar mostrar el diálogo más de una vez

  StreamSubscription? _cubitSubscription;

  @override
  void initState() {
    super.initState();
    userProvider = widget.userProvider;

    animatedMenu = animatedMenuBools[
        userProvider.state.registerPatientFlow ?? "registerSuccess"]!;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Solo mostrar el diálogo si estamos en el tutorial (animatedMenu es true)
    if (animatedMenu && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text(
              "¡Diríjase a la sección de personalización para elegir su planta y personalizar su jardín!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Aceptar"),
              ),
            ],
          ),
        );
      });
    }
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: ListView(
        children: [
          headerItem(
            context,
            widget.isPattient ? widget.userProvider.state.patientModel! : null,
            widget.isPattient
                ? null
                : widget.userProvider.state.specialistModel ??
                    SpecialistModel(),
            widget.isPattient,
            widget.userProvider,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          widget.isPattient
              ? listItem(
                  context,
                  "Personalización",
                  Icon(
                    Icons.color_lens,
                    color: const Color.fromARGB(255, 216, 13, 182),
                    size: MediaQuery.of(context).size.width * 0.1,
                  ), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomMenuScreen(
                        userProvider: widget.userProvider,
                        uiProvider: widget.uiProvider,
                      ),
                    ),
                  );
                }, false, animatedMenu, _animationController, _animation)
              : Container(),
          widget.isPattient
              ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
              : Container(),
          widget.isPattient
              ? listItem(
                  context,
                  "Privacidad",
                  Icon(
                    Icons.privacy_tip,
                    color: const Color.fromARGB(255, 7, 110, 38),
                    size: MediaQuery.of(context).size.width * 0.1,
                  ), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyScreen(
                        settings: widget.isPattient
                            ? widget.userProvider.state.patientModel!.settings
                            : widget.userProvider.state.patientModel!.settings,
                      ),
                    ),
                  );
                }, animatedMenu, false, _animationController, _animation)
              : Container(),
          widget.isPattient
              ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
              : Container(),
          listItem(
              context,
              "Términos y Condiciones",
              Icon(
                Icons.description,
                color: const Color.fromARGB(255, 75, 11, 160),
                size: MediaQuery.of(context).size.width * 0.1,
              ), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TermsScreen(
                  terms: widget.isPattient
                      ? widget
                          .userProvider.state.patientModel!.termsClass!.terms
                      : widget.userProvider.state.specialistModel!.termsClass!
                          .terms,
                ),
              ),
            );
          }, animatedMenu, false, _animationController, _animation),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          listItem(
              context,
              "Acerca de",
              Icon(
                Icons.info,
                color: const Color.fromARGB(255, 231, 150, 19),
                size: MediaQuery.of(context).size.width * 0.1,
              ), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutScreen(),
              ),
            );
          }, animatedMenu, false, _animationController, _animation),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          listItem(
              context,
              "Cerrar Sesión",
              Icon(
                Icons.logout,
                color: const Color.fromARGB(255, 0, 0, 0),
                size: MediaQuery.of(context).size.width * 0.1,
              ), () {
            // print("cerrar sesion");
            if (widget.isPattient == false) {
              Navigator.pop(context);
            }
            widget.logout();
          }, animatedMenu, false, _animationController, _animation),
        ],
      ),
    );
  }
}

Widget listItem(
  BuildContext context,
  String title,
  Icon icon,
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
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          icon,
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Expanded(
            child: disable == false && animate == true
                ? AnimatedBuilder(
                    animation: animationController!,
                    builder: (context, child) => Text(
                      title,
                      style: TextStyle(
                          color: animation!.value ?? Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.06),
                    ),
                  )
                : Text(
                    title,
                    style: TextStyle(
                        color: disable == false && animate == true
                            ? animation!.value ?? Colors.black
                            : disable == false
                                ? Colors.black
                                : Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: MediaQuery.of(context).size.width * 0.05,
            color: disable ? Colors.grey : Colors.black,
          )
        ],
      ),
    ),
  );
}

Widget headerItem(
  BuildContext context,
  PatientModel? patientModel,
  SpecialistModel? specialistModel,
  bool isPattient,
  BegginCubit userProvider,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            patientModel: patientModel,
            specialistModel: specialistModel,
            userProvider: userProvider,
            isPatient: isPattient,
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: MediaQuery.of(context).size.width * 0.12,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textToUpperCateFirstLetter(isPattient
                      ? patientModel!.name ?? ""
                      : specialistModel!.name ?? ""),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Text(
                  isPattient
                      ? patientModel!.email ?? ''
                      : specialistModel!.email ?? '',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 30,
          )
        ],
      ),
    ),
  );
}
