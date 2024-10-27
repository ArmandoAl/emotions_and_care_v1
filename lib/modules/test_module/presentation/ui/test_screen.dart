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

      setState(() {
        animatedMenu =
            animatedMenuBools[state.registerPatientFlow ?? "registerSuccess"]!;
      });

      if (animatedMenu && !_dialogShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text(
                "¡Completaste tu primer test! Ahora puedes dirigirte a la sección de Configuración para personalizar tu experiencia.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Aceptar"),
                ),
              ],
            ),
          );
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
