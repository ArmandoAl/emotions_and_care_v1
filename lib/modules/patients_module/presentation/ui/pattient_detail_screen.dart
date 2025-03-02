import 'package:lottie/lottie.dart';
import '../../../../helpers/paths.dart';

class PatientDetail extends StatefulWidget {
  final PatientModel patient;
  const PatientDetail({super.key, required this.patient});

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  bool isloading = false;
  bool aceptedLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: '',
        isForReturn: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE3EDF3),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.02),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Text(
                      widget.patient.name!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "Vinculado desde: ***",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                widget.patient.age.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              //genero
                              const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                widget.patient.sex!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.mail_rounded,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Correo electrónico",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      widget.patient.email!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Teléfono",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      widget.patient.phone!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Programar cita",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
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
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                  ),
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Later",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.schedule,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Later",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                                containerItem(
                                    context, Colors.white, "Later", 'Later', "",
                                    () {
                                  //onTap(date);
                                },
                                    hasHeader: true,
                                    icon: Icons.info_outline_rounded),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DailyController(
                                  patientModel: widget.patient,
                                  changeIndex: null,
                                  isPattient: false)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.9),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      elevation: 3,
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      //add a border here with color black
                    ),
                    child: isloading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          )
                        : Text(
                            'Diario',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<TestCubit>().getTest(widget.patient.id!);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocBuilder<TestCubit, TestState>(
                          bloc: context.read<TestCubit>(),
                          builder: (context, state) {
                            if (state.status == TestStatus.error) {
                              return const Scaffold(
                                body: Center(
                                  child: Text(
                                      'Error al cargar las pruebas, intente de nuevo haciendo scroll hacia abajo',
                                      style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.none)),
                                ),
                              );
                            }

                            if (state.status == TestStatus.loading) {
                              return Scaffold(
                                body: Center(
                                  child: Lottie.asset(Assets.brainLoading),
                                ),
                              );
                            }

                            return TestProgressScreen(
                              patientModel: widget.patient,
                              historyTestList: state.historyTestList,
                              isPatient: false,
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
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return TestHistoryQuestionsScreen(
                                            test: testInfo,
                                          );
                                        }));
                                      });
                                }));
                              },
                            );
                          },
                        );
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ),
                    child: aceptedLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : Text(
                            'Cuestionarios',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
