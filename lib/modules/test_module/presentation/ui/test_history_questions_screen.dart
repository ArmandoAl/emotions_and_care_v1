import '../../../../helpers/paths.dart';

class TestHistoryQuestionsScreen extends StatefulWidget {
  final TestInfoModel test;
  const TestHistoryQuestionsScreen({super.key, required this.test});

  @override
  State<TestHistoryQuestionsScreen> createState() =>
      _TestHistoryQuestionsScreenState();
}

class _TestHistoryQuestionsScreenState
    extends State<TestHistoryQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            Text(widget.test.resultado,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${widget.test.date.day}/${widget.test.date.month}/${widget.test.date.year} ${widget.test.date.hour}:${widget.test.date.minute}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.test.testQuestionWithAnswerList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      testHistoryQuestion(context,
                          widget.test.testQuestionWithAnswerList[index], index),
                      const SizedBox(height: 15),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget testHistoryQuestion(
    BuildContext context, TestQuestionWithAnswer question, int index) {
  final uiProvider = getIt<UICubit>();
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pregunta ${index + 1}",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.025,
            )),
        const SizedBox(height: 5),
        Text(
          question.question,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffEEC24F),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            question.answer,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: uiProvider.state.themes[uiProvider.state.selectedTheme] ==
                      uiProvider.state.themes[3]
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
