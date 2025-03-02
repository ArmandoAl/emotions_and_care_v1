import '../../../../helpers/paths.dart';

class CompleteTest extends StatefulWidget {
  final int testId;
  final int userId;
  final void Function(int testId, int questionId, int responseId) onTap;
  const CompleteTest({
    super.key,
    required this.testId,
    required this.onTap,
    required this.userId,
  });
  @override
  State<CompleteTest> createState() => _CompleteTestState();
}

class _CompleteTestState extends State<CompleteTest> {
  final PageController _pageController = PageController();
  double progress = 0;
  String? resultado;
  bool isLoading = false;
  GoalModel? goal;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BegginCubit userProvider = getIt<BegginCubit>();

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocConsumer<TestCubit, TestState>(
          listener: (context, state) {
            if (state.status == TestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error'),
                ),
              );
            }
          },
          builder: (context, state) {
            return PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: state.testList[widget.testId - 1].questions.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return intructionsWidget(context,
                      state.testList[widget.testId - 1], _pageController);
                }

                if (index ==
                    state.testList[widget.testId - 1].questions.length + 1) {
                  //get the test result
                  return testResultWidget(
                    context,
                    state.historyTestList
                                .firstWhere((element) =>
                                    element.idCuestionario == widget.testId)
                                .testInfoList
                                .length >
                            1
                        ? state.historyTestList
                            .firstWhere((element) =>
                                element.idCuestionario == widget.testId)
                            .testInfoList
                            .last
                        : state.historyTestList
                            .firstWhere((element) =>
                                element.idCuestionario == widget.testId)
                            .testInfoList
                            .first,
                    _pageController,
                    widget.userId,
                    resultado!,
                    userProvider,
                    goal,
                  );
                }

                final item =
                    state.testList[widget.testId - 1].questions[index - 1];
                progress =
                    index / state.testList[widget.testId - 1].questions.length;

                return questionItems(
                  context,
                  state,
                  index,
                  progress,
                  _pageController,
                  isLoading,
                  resultado,
                  widget.userId,
                  widget.onTap,
                  widget.testId,
                  item,
                  (bool loading) {
                    setState(() {
                      isLoading = loading;
                    });
                  },
                  (String result) {
                    setState(() {
                      resultado = result;
                    });
                  },
                  (GoalModel? goal) {
                    setState(() {
                      this.goal = goal;
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
