import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../config/assets/assets.dart';
import '../../../../helpers/paths.dart';

class TestController extends StatefulWidget {
  final PatientModel patientModel;
  final Function(int) changeIndex;
  const TestController(
      {super.key, required this.patientModel, required this.changeIndex});

  @override
  State<TestController> createState() => _TestControllerState();
}

class _TestControllerState extends State<TestController> {
  @override
  void initState() {
    super.initState();
    context.read<TestCubit>().getTest(widget.patientModel.id!);
  }

  @override
  Widget build(BuildContext context) {
    final RegisterPatientFlow? registerFlow =
        context.watch<BegginCubit>().state.registerPatientFlow;

    return BlocBuilder<TestCubit, TestState>(
      bloc: context.read<TestCubit>(),
      builder: (context, state) {
        if (state.status == TestStatus.error) {
          return const Scaffold(
            body: Center(
              child: Text(
                  'Error al cargar las pruebas, intente de nuevo haciendo scroll hacia abajo',
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.none)),
            ),
          );
        }

        return Scaffold(
          appBar: HeaderWidget(
            title: 'Cuestionarios',
            isForReturn: false,
            action: ElevatedButton(
                onPressed: state.status == TestStatus.loading ||
                        registerFlow != RegisterPatientFlow.homeUiChanged
                    ? null
                    : () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TestProgressScreen(
                            patientModel: widget.patientModel,
                            historyTestList: state.historyTestList,
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
          ),
          drawer: DrawerWidget(
            currentIndex: 1,
            changeIndex: widget.changeIndex,
          ),
          body: state.status == TestStatus.loading
              ? Center(
                  child: Lottie.asset(Assets.brainLoading),
                )
              : TestsScreen(
                  testList: state.testList,
                  completedTestList: state.completedTestList,
                  onTestTap: (TestModel test) {
                    if (state.completedTestList
                        .any((element) => element.testId == test.id)) {
                      showDialogForCompletedTest(
                          context,
                          state.completedTestList
                              .firstWhere(
                                  (element) => element.testId == test.id)
                              .date);
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CompleteTest(
                          testId: test.id,
                          userId: widget.patientModel.id!,
                          onTap: (int testId, int questionId, int responseId) {
                            context.read<TestCubit>().onSelectResponse(
                                  testId,
                                  questionId,
                                  responseId,
                                );
                          },
                        ),
                      ),
                    );
                  },
                  onRefresh: () async {
                    context.read<TestCubit>().getTest(widget.patientModel.id!);
                  },
                ),
        );
      },
    );
  }
}
