import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helpers/paths.dart';

class HomeController extends StatefulWidget {
  final int idUser;
  final Function(int) changeIndex;
  const HomeController(
      {super.key, required this.idUser, required this.changeIndex});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().getNotifications(widget.idUser);

    _subscription = context.read<HomeCubit>().stream.listen((event) {
      if (event.status == HomeStatus.growing) {
        if (mounted) {
          showGrowingDialog(context);
        }
      }
    });
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
        final notificationModel =
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
                  await showCustomDialog(context);

                  if (context.mounted) {
                    print(notificationModel.id);
                    // builderContext
                    //     .read<HomeCubit>()
                    //     .deleteNotification(notificationModel.id);
                    context.read<HomeCubit>().changeStatus(HomeStatus.growing);
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

void showGrowingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Creciendo flor'),
        content: ElevatedButton(
            onPressed: () {
              context.read<UICubit>().growFlowerStage();

              Navigator.of(context).pop();
            },
            child: const Text('Aceptar')),
      );
    },
  );
}
