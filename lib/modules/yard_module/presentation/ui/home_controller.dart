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
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getNotifications(widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    final RegisterPatientFlow? registerFlow =
        context.watch<BegginCubit>().state.registerPatientFlow;

    if (registerFlow == RegisterPatientFlow.firstTestCompleted) {
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
                        registerFlow: RegisterPatientFlow.firstTestCompleted,
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
              tap: () {
                if (notificationModel != null) {
                  showCustomDialog(context, notificationModel);
                  builderContext
                      .read<HomeCubit>()
                      .deleteNotification(notificationModel.id);
                }
              },
              registerFlow: registerFlow,
              customEnable: false),
        );
      },
    );
  }
}
