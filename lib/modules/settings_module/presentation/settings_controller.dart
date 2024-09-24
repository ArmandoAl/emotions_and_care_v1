import '../../../helpers/paths.dart';

class SettingsController extends StatefulWidget {
  final BegginCubit userProvider;
  final Function(int)? changeIndex;
  final bool isPattient;
  const SettingsController(
      {super.key,
      required this.userProvider,
      required this.changeIndex,
      required this.isPattient});

  @override
  State<SettingsController> createState() => _SettingsControllerState();
}

class _SettingsControllerState extends State<SettingsController> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = getIt<UICubit>();

    return Scaffold(
      appBar: widget.isPattient
          ? const HeaderWidget(
              title: 'Configuración',
              isForReturn: false,
            )
          : AppBar(
              title: const Text('Configuración'),
            ),
      drawer: widget.isPattient
          ? DrawerWidget(
              currentIndex: 5,
              changeIndex: widget.changeIndex!,
            )
          : null,
      body: SettingsScreen(
        userProvider: widget.userProvider,
        isPattient: widget.isPattient,
        uiProvider: uiProvider,
      ),
    );
  }
}
