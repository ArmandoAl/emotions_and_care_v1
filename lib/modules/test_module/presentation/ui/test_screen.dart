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
  AnimationController? _animationController;
  Animation? _animation;

  StreamSubscription? _cubitSubscription;

  @override
  void initState() {
    super.initState();
    userProvider = getIt<BegginCubit>();

    animatedMenu = animatedMenuBools[
        userProvider.state.registerPatientFlow ?? "registerSuccess"]!;

    final state = userProvider.state;

    if (state.registerPatientFlow == "register") {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      )..repeat(reverse: true);

      _animation = ColorTween(
        begin: const Color.fromARGB(255, 67, 59, 59),
        end: const Color.fromARGB(255, 13, 24, 172),
      ).animate(_animationController!);

      setState(() {});
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final state = userProvider.state;

      if (state.registerPatientFlow == "register") {
        await showMessageDialog(context, "Cuestionarios",
            "En esta sección, encontrarás instrumentos validados en México para evaluar indicadores de salud mental. |Es importante que respondas con honestidad.");
      }
    });
  }

  //didChangeDependencies
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubitSubscription?.cancel();
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
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showMessageDialog(
              context,
              "Cuestionarios",
              state.registerPatientFlow! == "register"
                  ? "En esta sección, encontrarás instrumentos validados en México para evaluar indicadores de salud mental. |Es importante que respondas con honestidad."
                  : "Gracias por completar tu primer cuestionario. |Con base en tus respuestas, recibirás consejos para apoyarte en tu camino. |Por favor dirígete al menú.");
        });

        _dialogShown = true;
      }
    });
  }

  @override
  void dispose() {
    _cubitSubscription?.cancel();

    _animationController?.dispose();

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
                  if (userProvider.state.registerPatientFlow == "register") {
                    return AnimatedBuilder(
                      animation: _animationController!,
                      builder: (context, child) {
                        return Container(
                            decoration: BoxDecoration(
                              color: _animation!.value,
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
                            child: ListTestItems(
                              item: item,
                              completedTestList: widget.completedTestList,
                              onTestTap: widget.onTestTap,
                            ));
                      },
                    );
                  } else {
                    return Container(
                        decoration: BoxDecoration(
                          color: userProvider.state.registerPatientFlow ==
                                  "register"
                              ? _animation!.value
                              : widget.completedTestList.any(
                                      (element) => element.testId == item.id)
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
                        child: ListTestItems(
                          item: item,
                          completedTestList: widget.completedTestList,
                          onTestTap: widget.onTestTap,
                        ));
                  }
                })));
  }
}

class ListTestItems extends StatefulWidget {
  final TestModel item;
  final List<CompletedTestModel> completedTestList;
  final void Function(TestModel test) onTestTap;
  const ListTestItems(
      {super.key,
      required this.item,
      required this.completedTestList,
      required this.onTestTap});

  @override
  State<ListTestItems> createState() => _ListTestItemsState();
}

class _ListTestItemsState extends State<ListTestItems> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.item.name,
          style: TextStyle(
            color: widget.completedTestList
                    .any((element) => element.testId == widget.item.id)
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
              Text("${widget.item.questions.length} Preguntas",
                  style: TextStyle(
                    color: widget.completedTestList
                            .any((element) => element.testId == widget.item.id)
                        ? Colors.black
                        : const Color(0xffE3EDF3),
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  )),
              if (widget.completedTestList
                  .any((element) => element.testId == widget.item.id))
                Text(
                    "Completado ${widget.completedTestList.firstWhere((element) => element.testId == widget.item.id).date.day}/${widget.completedTestList.firstWhere((element) => element.testId == widget.item.id).date.month}/${widget.completedTestList.firstWhere((element) => element.testId == widget.item.id).date.year}",
                    style: TextStyle(
                      color: widget.completedTestList.any(
                              (element) => element.testId == widget.item.id)
                          ? Colors.black
                          : const Color(0xffE3EDF3),
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    )),
            ],
          ),
          const Spacer(),
          // Text(widget.item.questions.length.toString()),
        ],
      ),
      trailing: widget.completedTestList
              .any((element) => element.testId == widget.item.id)
          ? Icon(
              Icons.check,
              color: widget.completedTestList
                      .any((element) => element.testId == widget.item.id)
                  ? Colors.black
                  : const Color(0xffE3EDF3),
            )
          : null,
      onTap: () {
        widget.onTestTap(widget.item);
      },
    );
  }
}
