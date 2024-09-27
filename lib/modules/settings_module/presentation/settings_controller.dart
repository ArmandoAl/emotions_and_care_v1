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
      body: SettingsScreen(
        userProvider: widget.userProvider,
        isPattient: widget.isPattient,
        uiProvider: uiProvider,
      ),
    );
  }
}
