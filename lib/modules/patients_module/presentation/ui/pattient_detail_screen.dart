import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/assets/assets.dart';
import '../../../../helpers/paths.dart';

class PatientDetail extends StatefulWidget {
  final PatientModel patient;
  const PatientDetail({super.key, required this.patient});

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        title: 'Paciente: ${widget.patient.name}',
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
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Expanded(
                        child: Text(
                          'Paciente: ${widget.patient.name}',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Expanded(
                        child: Text(
                          'Teléfono: ${widget.patient.phone}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Expanded(
                        child: Text(
                          'Correo: ${widget.patient.email}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Expanded(
                        child: Text(
                          'Edad: ${widget.patient.age}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Expanded(
                        child: Text(
                          'Sexo: ${widget.patient.sex}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DailyController(
                            patientModel: widget.patient,
                            changeIndex: null,
                            isPattient: false)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2cb5e0),
                elevation: 5,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.05),
              ),
              child: Text(
                'Diario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TestCubit>().getTest(widget.patient.id!);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                                      MaterialPageRoute(builder: (context) {
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
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 5,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.05),
              ),
              child: Text(
                'Progreso',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
