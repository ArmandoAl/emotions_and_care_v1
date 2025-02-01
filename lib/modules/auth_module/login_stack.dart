// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/navigation_bloc.dart';
import '../../helpers/paths.dart';

class LoginStack extends StatefulWidget {
  const LoginStack({super.key});

  @override
  State<LoginStack> createState() => _LoginStackState();
}

class _LoginStackState extends State<LoginStack> {
  late BegginCubit userProvider;

  @override
  void initState() {
    userProvider = getIt<BegginCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userProvider.state.status == BegginStatus.loading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userProvider.state.isPatient == true) {
      return const PattientStack();
    } else {
      return const SpecialistStack();
    }
  }
}

class PattientStack extends StatefulWidget {
  const PattientStack({super.key});

  @override
  State<PattientStack> createState() => _PattientStackState();
}

class _PattientStackState extends State<PattientStack> {
  late NavigationBloc navigationBloc;
  late BegginCubit begginCubit;
  late CommunityCubit communityCubit;
  late DailyCubit dailyCubit;
  late EmotionCubit emotionCubit;
  late ScheduleCubit scheduleCubit;
  late HomeCubit homeCubit;
  late TestCubit testCubit;
  late PattientsDatesCubit pattientsDatesCubit;
  late UICubit uiCubit;
  late Widget _content;

  @override
  void initState() {
    uiCubit = getIt<UICubit>();
    begginCubit = getIt<BegginCubit>();

    navigationBloc = NavigationBloc(
      NavigationItem.home,
    );

    communityCubit = getIt<CommunityCubit>();
    dailyCubit = getIt<DailyCubit>();
    emotionCubit = getIt<EmotionCubit>();
    scheduleCubit = getIt<ScheduleCubit>();
    homeCubit = getIt<HomeCubit>();
    testCubit = getIt<TestCubit>();
    pattientsDatesCubit = getIt<PattientsDatesCubit>();

    _content = _getContentForState(
      navigationBloc.state.selectedItem,
      begginCubit,
      communityCubit,
      dailyCubit,
      emotionCubit,
      scheduleCubit,
      homeCubit,
      pattientsDatesCubit,
      testCubit,
      uiCubit,
    );

    uiCubit.setBackAssets(
        begginCubit.state.patientModel!.userInterface!.userStickers,
        begginCubit.state.patientModel!.userInterface!.userFlowers);

    //TODO: Get progress and gifts from back

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: navigationBloc,
      child: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (BuildContext context, NavigationState state) {
          setState(() {
            _content = _getContentForState(
                state.selectedItem,
                begginCubit,
                communityCubit,
                dailyCubit,
                emotionCubit,
                scheduleCubit,
                homeCubit,
                pattientsDatesCubit,
                testCubit,
                uiCubit);
          });
        },
        buildWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },
        listenWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },
        builder: (BuildContext context, NavigationState state) {
          return Scaffold(
            appBar: _getAppBarFromState(
                state.selectedItem,
                navigationBloc,
                begginCubit,
                communityCubit,
                dailyCubit,
                emotionCubit,
                scheduleCubit,
                homeCubit,
                testCubit,
                uiCubit,
                context),
            drawer: DrawerWidget(
              currentIndex: state.selectedItem.index,
              changeIndex: (int) {},
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.linear,
              switchOutCurve: Curves.linear,
              duration: const Duration(milliseconds: 300),
              child: _content,
            ),
          );
        },
      ),
    );
  }
}

PreferredSizeWidget? _getAppBarFromState(
  NavigationItem selectedItem,
  NavigationBloc navigationBloc,
  BegginCubit begginCubit,
  CommunityCubit communityCubit,
  DailyCubit dailyCubit,
  EmotionCubit emotionCubit,
  ScheduleCubit scheduleCubit,
  HomeCubit homeCubit,
  TestCubit testCubit,
  UICubit uiCubit,
  BuildContext context,
) {
  switch (selectedItem) {
    case NavigationItem.home:
      return null;
    case NavigationItem.test:
      return HeaderWidget(
        title: 'Cuestionarios',
        isForReturn: false,
        action: ElevatedButton(
            onPressed: () {
              if (testCubit.state.status == TestStatus.loading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cargando cuestionarios, intente de nuevo'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              if (begginCubit.state.registerPatientFlow != "registerSuccess") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No se ha completado el registro'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TestProgressScreen(
                  patientModel: begginCubit.state.patientModel!,
                  historyTestList: testCubit.state.historyTestList,
                  isPatient: true,
                  onFisrtItemTap: (TestInfoModel testInfo) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TestHistoryQuestionsScreen(
                        test: testInfo,
                      );
                    }));
                  },
                  onTap: (HistoryTestModel test) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TestHistoryItemsScreen(
                          test: test,
                          onTap: (TestInfoModel testInfo) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TestHistoryQuestionsScreen(
                                test: testInfo,
                              );
                            }));
                          });
                    }));
                  },
                );
              }));
            },
            child: Text('Progreso',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                ))),
      );
    case NavigationItem.dairy:
      return HeaderWidget(
        title: 'Diario',
        isForReturn: false,
        action: ElevatedButton(
            onPressed: () {
              if (dailyCubit.state.result == DailyResult.loading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cargando notas, intente de nuevo'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              if (dailyCubit.state.notes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No hay notas para mostrar'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotesProgressScreen(
                      notes: dailyCubit.state.notes,
                      patientModel: begginCubit.state.patientModel!)));
            },
            child: Text('Progreso',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                ))),
      );
    case NavigationItem.community:
      return const HeaderWidget(title: 'Comunidad', isForReturn: false);
    case NavigationItem.schedule:
      return const HeaderWidget(title: 'Agenda', isForReturn: false);
    case NavigationItem.settings:
      return const HeaderWidget(title: 'Configuración', isForReturn: false);
    case NavigationItem.patients:
      return null;
    case NavigationItem.scheduleSpecialist:
      return null;
    case NavigationItem.patientDates:
      return null;
  }
}

Widget _getContentForState(
  NavigationItem selectedItem,
  BegginCubit begginCubit,
  CommunityCubit communityCubit,
  DailyCubit dailyCubit,
  EmotionCubit emotionCubit,
  ScheduleCubit scheduleCubit,
  HomeCubit homeCubit,
  PattientsDatesCubit pattientsDatesCubit,
  TestCubit testCubit,
  UICubit uiCubit,
) {
  switch (selectedItem) {
    case NavigationItem.home:
      return HomeController(
          idUser: begginCubit.state.patientModel!.id!, changeIndex: (int) {});
    case NavigationItem.test:
      return TestController(
        patientModel: begginCubit.state.patientModel!,
        changeIndex: (int) {},
      );
    case NavigationItem.dairy:
      return DailyController(
          patientModel: begginCubit.state.patientModel!,
          changeIndex: (int) {},
          isPattient: begginCubit.state.isPatient!);
    case NavigationItem.community:
      return GlobalCommunityController(
          isPatient: begginCubit.state.isPatient!,
          patientModel: begginCubit.state.patientModel);
    case NavigationItem.schedule:
      return ScheduleController(
          patientModel: begginCubit.state.patientModel!,
          isPattient: begginCubit.state.isPatient!,
          especialistaModel: begginCubit.state.specialistModel);
    case NavigationItem.settings:
      return SettingsController(
        userProvider: begginCubit,
        isPattient: begginCubit.state.isPatient!,
        logout: () {
          scheduleCubit.clean();
          homeCubit.clean();
          // emotionCubit.clean();
          communityCubit.clean();
          dailyCubit.clean();
          testCubit.clean();
          uiCubit.clean();
          begginCubit.logout();
          pattientsDatesCubit.clean();
        },
      );
    case NavigationItem.patients:
      return Container();
    case NavigationItem.scheduleSpecialist:
      return Container();
    case NavigationItem.patientDates:
      return Container();
  }
}

class SpecialistStack extends StatefulWidget {
  const SpecialistStack({super.key});

  @override
  State<SpecialistStack> createState() => _SpecialistStackState();
}

class _SpecialistStackState extends State<SpecialistStack> {
  late NavigationBloc navigationBloc;
  late BegginCubit begginCubit;
  late CommunityCubit communityCubit;
  late DailyCubit dailyCubit;
  late EmotionCubit emotionCubit;
  late ScheduleCubit scheduleCubit;
  late HomeCubit homeCubit;
  late TestCubit testCubit;
  late PattientsDatesCubit pattientsDatesCubit;
  late UICubit uiCubit;

  @override
  void initState() {
    uiCubit = getIt<UICubit>();
    begginCubit = getIt<BegginCubit>();

    navigationBloc = NavigationBloc(
      NavigationItem.home,
    );

    communityCubit = getIt<CommunityCubit>();
    dailyCubit = getIt<DailyCubit>();
    emotionCubit = getIt<EmotionCubit>();
    scheduleCubit = getIt<ScheduleCubit>();
    homeCubit = getIt<HomeCubit>();
    testCubit = getIt<TestCubit>();
    pattientsDatesCubit = getIt<PattientsDatesCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotions&Care',
            style: TextStyle(color: Colors.black, fontSize: 25)),
        centerTitle: false,
        elevation: 5,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          //put a gradient here
          color: Color(0xFFE3EDF3),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3EDF3), Color.fromARGB(255, 19, 110, 163)],
          ),
        ),
        padding: const EdgeInsets.all(30),
        child: ListView(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SpecialistPattientsController(
                  idUser: begginCubit.state.specialistModel!.id!,
                );
              }));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Pacientes",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                            decoration: TextDecoration.none,
                            color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.people,
                      size: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScheduleController(
                    patientModel: null,
                    isPattient: false,
                    especialistaModel: begginCubit.state.specialistModel!);
              }));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Agenda",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                            decoration: TextDecoration.none,
                            color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.date_range,
                      size: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PattientsDatesController(
                  idUser: begginCubit.state.specialistModel!.id!,
                );
              }));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Soliciudes de citas",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                            decoration: TextDecoration.none,
                            color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.note_alt_rounded,
                      size: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Solictudes de pacientes",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                            decoration: TextDecoration.none,
                            color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.person,
                      size: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GlobalCommunityController(
                    specialistModel: begginCubit.state.specialistModel!,
                    isPatient: false,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Comunidad",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                            decoration: TextDecoration.none,
                            color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.people,
                      size: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingsController(
                  userProvider: begginCubit,
                  isPattient: false,
                  logout: () {
                    scheduleCubit.clean();
                    homeCubit.clean();
                    // emotionCubit.clean();
                    communityCubit.clean();
                    dailyCubit.clean();
                    testCubit.clean();
                    uiCubit.clean();

                    pattientsDatesCubit.clean();

                    begginCubit.logout();
                  },
                );
              }));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Configuración",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                            decoration: TextDecoration.none,
                            color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.settings,
                      size: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ]),
      ),
    );
  }
}
