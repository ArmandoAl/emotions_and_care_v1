import '../../../helpers/paths.dart';

class SettingsController extends StatefulWidget {
  final BegginCubit userProvider;
  final bool isPattient;
  final Function logout;
  const SettingsController(
      {super.key,
      required this.userProvider,
      required this.isPattient,
      required this.logout});

  @override
  State<SettingsController> createState() => _SettingsControllerState();
}

class _SettingsControllerState extends State<SettingsController> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = getIt<UICubit>();

    return Scaffold(
      appBar: widget.isPattient
          ? null
          : const HeaderWidget(title: "Configuracion", isForReturn: true),
      body: SettingsScreen(
        userProvider: widget.userProvider,
        isPattient: widget.isPattient,
        uiProvider: uiProvider,
        logout: widget.logout,
      ),
    );
  }
}
