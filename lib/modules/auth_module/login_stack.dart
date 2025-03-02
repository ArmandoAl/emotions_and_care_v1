// ignore_for_file: avoid_types_as_parameter_names
import 'package:emotions_and_care_v1/modules/patients_request/presentation/ui/patient_request_controller.dart';

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

    homeCubit.canGrowStage(begginCubit.state.patientModel!.id!);

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
      return HeaderWidget(title: 'Cuestionarios', isForReturn: false, actions: [
        ElevatedButton(
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
        const SizedBox(width: 10),
      ]);
    case NavigationItem.dairy:
      return HeaderWidget(title: 'Diario', isForReturn: false, actions: [
        ElevatedButton(
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
        const SizedBox(width: 10),
      ]);
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
        idUser: begginCubit.state.patientModel!.id!,
        changeIndex: (int) {},
        begginState: begginCubit.state,
      );
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
        isPattient: begginCubit.state.isPatient!,
      );
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
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            headerSpecialistWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PattientsDatesController(
                            idUser: begginCubit.state.specialistModel!.id!,
                          );
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.date_range,
                                size: MediaQuery.of(context).size.width * 0.1,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Solictudes de citas",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PatientsRequestController(
                            idUser: begginCubit.state.specialistModel!.id!,
                          );
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person,
                                size: MediaQuery.of(context).size.width * 0.1,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Vinulación de pacientes",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ScheduleController(
                    isPattient: false,
                  );
                }));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.date_range,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text("Agenda",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                    ),
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
                  return SpecialistPattientsController(
                    idUser: begginCubit.state.specialistModel!.id!,
                  );
                }));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text("Pacientes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                    ),
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
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      color: Theme.of(context).colorScheme.secondary,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text("Comunidad",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ]),
        ),
      ),
    );
  }

  Widget headerSpecialistWidget() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hola ${begginCubit.state.specialistModel!.name!}!",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Text(getDate(context),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        color: Colors.black))
              ],
            ),
          ),
          IconButton(
              onPressed: () {
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
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.surface,
              ))
        ],
      ),
    );
  }
}

String getDate(BuildContext context) {
//formato: Miércoles 15 de septiembre de 2021
  final DateTime now = DateTime.now();
  final String day = now.day.toString();
  final String month = now.month.toString();
  // final String year = now.year.toString();

  switch (now.weekday) {
    case 1:
      return "Lunes $day de ${getMonth(month)}";
    case 2:
      return "Martes $day de ${getMonth(month)}";
    case 3:
      return "Miércoles $day de ${getMonth(month)}";
    case 4:
      return "Jueves $day de ${getMonth(month)}";
    case 5:
      return "Viernes $day de ${getMonth(month)}";
    case 6:
      return "Sábado $day de ${getMonth(month)}";
    case 7:
      return "Domingo $day de ${getMonth(month)}";
    default:
      return "";
  }
}

String getMonth(String month) {
  switch (month) {
    case "1":
      return "Enero";
    case "2":
      return "Febrero";
    case "3":
      return "Marzo";
    case "4":
      return "Abril";
    case "5":
      return "Mayo";
    case "6":
      return "Junio";
    case "7":
      return "jJlio";
    case "8":
      return "Agosto";
    case "9":
      return "Septiembre";
    case "10":
      return "Octubre";
    case "11":
      return "Noviembre";
    case "12":
      return "Diciembre";
    default:
      return "";
  }
}
