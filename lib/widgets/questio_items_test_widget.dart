import '../helpers/paths.dart';

Widget questionItems(
  BuildContext context,
  TestState state,
  int index,
  double progress,
  PageController pageController,
  bool isLoading,
  String? resultado,
  int userId,
  void Function(int testId, int questionId, int responseId) onTap,
  int testId,
  QuestionModel item,
  Function(bool loading) setLoadingState,
  Function(String result) setResultState,
  Function(GoalModel? goal) setGoal,
) {
  final uiProvider = getIt<UICubit>();
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.07,
      vertical: MediaQuery.of(context).size.height * 0.01,
    ),
    child: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.035),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () {
                //change page
                pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
            ),
            const Spacer(),
            Text(
              '$index/${state.testList[testId - 1].questions.length}',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),

              //progress bar
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        LinearProgressIndicator(
          value: progress,
          valueColor: AlwaysStoppedAnimation<Color>(Color.lerp(
              const Color(0xff1C8AAD),
              const Color.fromARGB(255, 21, 137, 19),
              progress)!),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          children: [
            Text("Pregunta ${index.toString()}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    decoration: TextDecoration.none)),
            const Spacer()
          ],
        ),
        const SizedBox(height: 5),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Text(item.question,
        //           style: TextStyle(
        //               fontSize: MediaQuery.of(context).size.width * 0.07,
        //               fontWeight: FontWeight.bold,
        //               decoration: TextDecoration.none)),
        //     ),
        //   ],
        // ),
        Text(item.question,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                decoration: TextDecoration.none)),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: item.answers.length,
            itemBuilder: (context, index) {
              ResponseModel answer = item.answers[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTap(testId, item.id, index);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: !answer.isSelected
                            ? Colors.transparent
                            : Colors.amber,

                        borderRadius: answer.isSelected
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(0),
                        //border just in the bottom
                        border: const Border(
                          bottom: BorderSide(
                            width: 0.5,
                          ),
                          top: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: !answer.isSelected
                                  ? Colors.transparent
                                  : Colors.amberAccent,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                // item.answers.length == 4
                                //     ? (index).toString()
                                //     : numbersForMoreThanFourDigits[index + 1]!,
                                "",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(answer.response,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.055,
                                    color: !answer.isSelected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.lerp(const Color(0xff1C8AAD),
                  const Color.fromARGB(255, 21, 137, 19), progress)!,
            ),
            onPressed: () async {
              final String? registerFlow =
                  context.read<BegginCubit>().state.registerPatientFlow;
              //if the last question
              if (index == state.testList[testId - 1].questions.length) {
                setLoadingState(true);

                GoalWithTestInfoModel result = await context
                    .read<TestCubit>()
                    .onCompleteTest(
                        userId, testId, registerFlow != "registerSuccess");

                if (result.goalModel != null && context.mounted) {
                  final UICubit uiProvider = getIt<UICubit>();

                  await uiProvider.getSticker(result.goalModel!.idSticker!);
                }

                setResultState(result.testInfoModel!.resultado);
                setGoal(result.goalModel);
              }

              if (item.answers.any((element) => element.isSelected)) {
                //change page
                pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Selecciona una respuesta'),
                    ),
                  );
                }
              }
            },
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Continuar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        decoration: TextDecoration.none))),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    ),
  );
}
