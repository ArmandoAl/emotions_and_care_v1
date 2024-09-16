import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
  final uiProvider = context.read<UIProvider>();
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
          backgroundColor: Colors.grey,
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
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
            const Spacer()
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(item.question,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: item.answers.length,
            itemBuilder: (context, index) {
              final answer = item.answers[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTap(testId, item.id, answer.id);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: !answer.isSelected
                            ? Colors.transparent
                            : item.answers.length == 4
                                ? fourQuestionsColors[index + 1]!
                                    .withOpacity(0.75)
                                : sixQuestionsColors[index + 1]!
                                    .withOpacity(0.75),

                        borderRadius: answer.isSelected
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(0),
                        //border just in the bottom
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.grey,
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
                                  : item.answers.length == 4
                                      ? fourQuestionsColors[index + 1]!
                                      : sixQuestionsColors[index + 1]!,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                item.answers.length == 4
                                    ? (index).toString()
                                    : numbersForMoreThanFourDigits[index + 1]!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
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
                                        ? uiProvider.theme ==
                                                uiProvider.themes[3]
                                            ? Colors.white
                                            : Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.065,
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
              final RegisterPatientFlow? registerFlow =
                  context.read<UserProvider>().registerPatientFlow;
              //if the last question
              if (index == state.testList[testId - 1].questions.length) {
                setLoadingState(true);

                GoalWithTestInfoModel result = await context
                    .read<TestCubit>()
                    .onCompleteTest(userId, testId,
                        registerFlow != RegisterPatientFlow.homeUiChanged);

                if (result.goalModel != null && context.mounted) {
                  final UIProvider uiProvider =
                      Provider.of<UIProvider>(context, listen: false);

                  await uiProvider.getSticker(result.goalModel!.idSticker!);
                }

                setResultState(result.testInfoModel.resultado);
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
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none))),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      ],
    ),
  );
}
