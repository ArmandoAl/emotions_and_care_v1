import 'dart:async';

import '../../../../helpers/paths.dart';

class TestsScreen extends StatefulWidget {
  static const String route = 'tests';
  final List<TestModel> testList;
  final List<CompletedTestModel> completedTestList;
  final void Function(TestModel test) onTestTap;
  final Future<void> Function() onRefresh;
  const TestsScreen(
      {super.key,
      required this.testList,
      required this.completedTestList,
      required this.onTestTap,
      required this.onRefresh});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen>
    with SingleTickerProviderStateMixin {
  late BegginCubit userProvider;
  bool animatedMenu = true;
  bool _dialogShown = false; // Evitar mostrar el diálogo más de una vez

  StreamSubscription? _cubitSubscription;

  @override
  void initState() {
    super.initState();
    userProvider = getIt<BegginCubit>();

    animatedMenu = animatedMenuBools[
        userProvider.state.registerPatientFlow ?? "registerSuccess"]!;

    _cubitSubscription = userProvider.stream.listen((state) {
      if (!mounted) return;

      if (state.registerPatientFlow! == "firstTestCompleted") {
        setState(() {
          _dialogShown = false;
        });
      }

      setState(() {
        animatedMenu =
            animatedMenuBools[state.registerPatientFlow ?? "registerSuccess"]!;
      });

      if (animatedMenu && !_dialogShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showMessageDialog(
              context,
              "Cuestionarios",
              state.registerPatientFlow! == "register"
                  ? "Para nosotros es muy importante detectar si existe algún riesgo de padecer algún trastorno relacionado con la salud mental. |Para esto, debes dirigirte a cuestionarios. Es importante que respondas tu primer cuestionario para que podamos ofrecerte todas las funcionalidades. |Es importante señalar que la aplicación en ningún momento pretende sustituir la ayuda profesional (opcional)."
                  : "¡Gracias por completar el cuestionario!| Ahora, dirígete de nuevo al menú principal y selecciona configuración para continuar.");
        });

        _dialogShown = true;
      }
    });
  }

  @override
  void dispose() {
    _cubitSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: RefreshIndicator(
          onRefresh: () async {
            await widget.onRefresh();
          },
          child: ListView.builder(
            itemCount: widget.testList.length,
            itemBuilder: (context, index) {
              final item = widget.testList[index];
              return Container(
                  decoration: BoxDecoration(
                    color: widget.completedTestList
                            .any((element) => element.testId == item.id)
                        ? Colors.grey[300]
                        : const Color(0xff2CB5E0),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        spreadRadius: 0,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text(item.name,
                        style: TextStyle(
                          color: widget.completedTestList
                                  .any((element) => element.testId == item.id)
                              ? Colors.black
                              : const Color(0xffE3EDF3),
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        )),
                    subtitle: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item.questions.length} Preguntas",
                                style: TextStyle(
                                  color: widget.completedTestList.any(
                                          (element) =>
                                              element.testId == item.id)
                                      ? Colors.black
                                      : const Color(0xffE3EDF3),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            if (widget.completedTestList
                                .any((element) => element.testId == item.id))
                              Text(
                                  "Completado ${widget.completedTestList.firstWhere((element) => element.testId == item.id).date.day}/${widget.completedTestList.firstWhere((element) => element.testId == item.id).date.month}/${widget.completedTestList.firstWhere((element) => element.testId == item.id).date.year}",
                                  style: TextStyle(
                                    color: widget.completedTestList.any(
                                            (element) =>
                                                element.testId == item.id)
                                        ? Colors.black
                                        : const Color(0xffE3EDF3),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                          ],
                        ),
                        const Spacer(),
                        // Text(item.questions.length.toString()),
                      ],
                    ),
                    trailing: widget.completedTestList
                            .any((element) => element.testId == item.id)
                        ? Icon(
                            Icons.check,
                            color: widget.completedTestList
                                    .any((element) => element.testId == item.id)
                                ? Colors.black
                                : const Color(0xffE3EDF3),
                          )
                        : null,
                    onTap: () {
                      widget.onTestTap(item);
                    },
                  ));
            },
          ),
        ));
  }
}
