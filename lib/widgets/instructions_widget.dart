import '../helpers/paths.dart';
import '../modules/test_module/presentation/utils/test_module_strings.dart';

Widget intructionsWidget(
    BuildContext context, TestModel test, PageController pageController) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.07,
      vertical: MediaQuery.of(context).size.height * 0.01,
    ),
    child: ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(test.name,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none)),
        const SizedBox(
          height: 20,
        ),
        Text(test.instructions,
            //justify
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none)),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              //   backgroundColor: const Color(0xff1C8AAD),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: MediaQuery.of(context).size.height * 0.015),
              textStyle: const TextStyle(fontSize: 30),
            ),
            onPressed: () {
              //change page
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            },
            child: Text(
              'Empezar cuesionario',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            )),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      ],
    ),
  );
}

Widget testResultWidget(
  BuildContext context,
  TestInfoModel test,
  PageController pageController,
  int userId,
  String? result,
  BegginCubit userProvider,
  GoalModel? goal,
) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          color: Color(0xff1C8AAD),
        ),
        child: Icon(
          Icons.check_circle,
          size: MediaQuery.of(context).size.width * 0.2,
        ),
      ),
      Expanded(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(testResult1String,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            Text(result!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Text(testResult2String,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1C8AAD),
                ),
                onPressed: () async {
                  if (goal != null) {
                    await showStickerDialog(context, goal);
                  }

                  if (userProvider.state.registerPatientFlow ==
                      RegisterPatientFlow.registerSucess) {
                    userProvider.setRegisterFlow(
                        RegisterPatientFlow.firstTestCompleted);
                  }

                  if (context.mounted) Navigator.of(context).pop();
                },
                child: Text('Continuar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none))),
          ],
        ),
      ))
    ],
  );
}
