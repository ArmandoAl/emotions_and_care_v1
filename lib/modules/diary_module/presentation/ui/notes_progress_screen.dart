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

  @override
  void initState() {
    super.initState();
    notasPorSemana = organizarNotasPorSemana(
      separarNotasPorSemanaYDia(widget.notes),
    );
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
                  "Hola, en esta pantalla puedes ver tu progreso a lo largo de las semanas, puedes hacer swipe para ver las emociones de cada semana y seleccionar una para ver la nota a la que pertenece, también puedes ver las emociones mas frecuentes a lo largo de las semanas. Si tienes alguna duda puedes contactarnos en goodforhealtlab@gmail.com.");
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
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
                child: PageView.builder(
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
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: notasPorSemana.length,
                  itemBuilder: (context, index) {
                    return emotionsForWeekWidgetForStaticts(
                        context, notasPorSemana, index);
                  },
                ),
              ),
            ),
          ],
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
