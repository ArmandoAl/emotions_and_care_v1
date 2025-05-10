import 'dart:async';

import '../../../../helpers/paths.dart';

class HomeController extends StatefulWidget {
  final int idUser;
  final Function(int) changeIndex;
  final BegginState begginState;
  const HomeController(
      {super.key,
      required this.idUser,
      required this.changeIndex,
      required this.begginState});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    if (widget.begginState.registerPatientFlow == "registerSuccess") {
      context.read<HomeCubit>().getNotifications(widget.idUser);
    }

    final UICubit uiProvider = context.read<UICubit>();
    if (uiProvider.state.flowerProgress.isEmpty) {
      uiProvider.getFlowerProgress(widget.idUser);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? registerFlow = getIt<BegginCubit>().state.registerPatientFlow;

    if (registerFlow == "firstTestCompleted") {
      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                      body: HomeScreen(
                        plane: null,
                        tap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Debes eligir una flor, haz click en la maceta para elegir una de las flores disponibles'),
                            duration: Duration(seconds: 1),
                          ));
                        },
                        registerFlow: "firstTestCompleted",
                        customEnable: true,
                      ),
                    )),
          );
        }
      });
    }

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: context.read<HomeCubit>(),
      buildWhen: (previous, current) {
        return previous.items != current.items;
      },
      builder: (builderContext, state) {
        final NotificationModel? notificationModel =
            state.items.isEmpty ? null : state.items.first;
        return Scaffold(
          drawer: DrawerWidget(
            currentIndex: 0,
            changeIndex: widget.changeIndex,
          ),
          body: HomeScreen(
              plane: notificationModel,
              tap: () async {
                if (notificationModel != null) {
                  final UICubit uiProvider = context.read<UICubit>();

                  if (notificationModel.idAchievement != null) {
                    final achivement = getIt<UICubit>()
                        .getAchivement(notificationModel.idAchievement!);

                    if (achivement == null) {
                      return;
                    }

                    await showStickerDialog(context, achivement);

                    if (context.mounted) {
                      builderContext
                          .read<HomeCubit>()
                          .deleteNotification(notificationModel.id);
                    }
                  } else {
                    await showCustomDialog(
                      context,
                      uiProvider,
                      widget.idUser,
                    );

                    if (context.mounted &&
                        (notificationModel.type ==
                            NotificationType.notificacionRecomendacion)) {
                    } else {
                      if (context.mounted) {
                        builderContext
                            .read<HomeCubit>()
                            .deleteNotification(notificationModel.id);
                      }
                    }
                  }
                }
              },
              registerFlow: registerFlow,
              customEnable: false),
        );
      },
    );
  }
}
