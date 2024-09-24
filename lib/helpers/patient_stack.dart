import 'package:emotions_and_care_v1/helpers/paths.dart';

class PatientStack extends StatefulWidget {
  const PatientStack({super.key});

  @override
  State<PatientStack> createState() => _PatientStackState();
}

class _PatientStackState extends State<PatientStack> {
  int _currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    BegginCubit userProvider = getIt<BegginCubit>();

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            HomeController(
              idUser: userProvider.state.patientModel!.id!,
              changeIndex: changeIndex,
            ),
            TestController(
              patientModel: userProvider.state.patientModel!,
              changeIndex: changeIndex,
            ),
            DailyController(
              patientModel: userProvider.state.patientModel!,
              changeIndex: changeIndex,
              isPattient: true,
            ),
            GlobalCommunityController(
              changeIndex: changeIndex,
              patientModel: userProvider.state.patientModel!,
              isPatient: true,
            ),
            ScheduleController(
              patientModel: userProvider.state.patientModel!,
              changeIndex: changeIndex,
              isPattient: true,
              especialistaModel: null,
            ),
            SettingsController(
                userProvider: userProvider,
                changeIndex: changeIndex,
                isPattient: true)
          ],
        ),
      ),
    );
  }
}
