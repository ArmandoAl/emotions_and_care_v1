import '../../../../helpers/paths.dart';

class NotesProgressScreen extends StatefulWidget {
  static const String route = 'progress';
  final PatientModel patientModel;
  final List<NoteModel> notes;
  const NotesProgressScreen(
      {super.key, required this.patientModel, required this.notes});

  @override
  State<NotesProgressScreen> createState() => _NotesProgressScreenState();
}

class _NotesProgressScreenState extends State<NotesProgressScreen> {
  Map<String, List<NoteModel>> notasPorSemana = {};
  NoteModel? selectedNote;
  final PageController daysController = PageController();
  final PageController chartController = PageController();

  @override
  void initState() {
    super.initState();
    notasPorSemana = organizarNotasPorSemana(
      separarNotasPorSemanaYDia(widget.notes),
    );
  }

  void navInDays(bool next) {
    if (next) {
      if (daysController.page!.toInt() < notasPorSemana.length - 1) {
        daysController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else {
      if (daysController.page!.toInt() > 0) {
        daysController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }

  void navInChart(bool next) {
    if (next) {
      if (chartController.page!.toInt() < notasPorSemana.length - 1) {
        chartController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else {
      if (chartController.page!.toInt() > 0) {
        chartController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progreso de Diario"),
        actions: [
          IconButton(
            onPressed: () async {
              await showTutorialDialog(context,
                  "Para observar tu evolución desde que iniciaste la aplicación puedes deslizar a través de las semanas. |Al seleccionar una semana, podrás elegir una emoción y ver tus notas relacionadas con ella.");
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 3,
          radius: const Radius.circular(10),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                child: Text(
                  "Estas son tus emociones a lo largo de las semanas, selecciona una para ver la nota a la que pertenece",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.005),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Scrollbar(
                    child: PageView.builder(
                      controller: daysController,
                      scrollDirection: Axis.horizontal,
                      itemCount: notasPorSemana.length,
                      itemBuilder: (context, index) {
                        return emotionsForWeekWidget(
                          context,
                          index,
                          notasPorSemana,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  IconButton(
                    onPressed: () {
                      navInDays(false);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  const Text(
                    "Navegar",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      navInDays(true);
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                child: Text(
                  "Esta gráfica muestra tus emociones mas frecuentes a lo largo de las semanas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.005),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Scrollbar(
                    child: PageView.builder(
                      controller: chartController,
                      scrollDirection: Axis.horizontal,
                      itemCount: notasPorSemana.length,
                      itemBuilder: (context, index) {
                        return emotionsForWeekWidgetForStaticts(
                            context, notasPorSemana, index);
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  IconButton(
                    onPressed: () {
                      navInChart(false);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  const Text(
                    "Navegar",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      navInChart(true);
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showTutorialDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Ayuda'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
