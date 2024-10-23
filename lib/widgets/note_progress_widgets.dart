import 'package:fl_chart/fl_chart.dart';

import '../helpers/paths.dart';

Widget containerNoteContentWidget(BuildContext context, NoteModel? note) {
  if (note == null) {
    return ListView(
      children: [
        Text("Simbología",
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: MediaQuery.of(context).size.width * 0.03,
          children: emotionColors.keys.map((e) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              padding: const EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.width * 0.135,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                color: emotionColors[e],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  e,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  } else {
    return ListView(
      children: [
        Row(
          children: [
            Text(note.emotion.icon!,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                )),
            const Spacer(),
            Text(
              "${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Row(
          children: [
            Text("Titulo:",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(note.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03)),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Row(
          children: [
            Text("Contenido:",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            Flexible(
                child: Text(note.content,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.03))),
          ],
        ),
      ],
    );
  }
}

Widget noteItem(
  BuildContext context,
  NoteModel note,
) {
  return GestureDetector(
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(3.0),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          width: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            color: emotionColors[note.emotion.name],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 15,
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Text(
              "${note.createdAt.day}/${note.createdAt.month}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

int calculateWeeks(List<NoteModel> notes) {
  //calcular cuantas semanas hay en las notas

  final weeks = <int>{};
  for (var note in notes) {
    weeks.add(note.createdAt.weekday ~/ 7);
  }

  return weeks.length;
}

Widget emotionsForWeekWidgetForStaticts(
  BuildContext context,
  Map<String, List<NoteModel>> notasPorSemana,
  int index,
) {
  //toma todas las notas de la semana, y las agrupa por emocion para mostrarlas, muestralas en grafica de barras
  final semana = notasPorSemana.keys
      .toList()[index]; // Obtener la clave (nombre de semana) en el índice dado
  final notesForWeek = notasPorSemana[semana]!;
  final staticsMap = <String, int>{};

  for (var note in notesForWeek) {
    if (staticsMap.containsKey(note.emotion.name)) {
      staticsMap[note.emotion.name] = staticsMap[note.emotion.name]! + 1;
    } else {
      staticsMap[note.emotion.name] = 1;
    }
  }

  final percentMap = <String, double>{};

  for (var key in staticsMap.keys) {
    percentMap[key] = staticsMap[key]! / notesForWeek.length;
  }

  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.3,
    margin: const EdgeInsets.symmetric(horizontal: 10.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(183, 246, 246, 246),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          semana,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Expanded(
            child: PieChart(
          PieChartData(
            sections: percentMap.keys
                .map((e) => PieChartSectionData(
                      value: percentMap[e]!,
                      color: emotionColors[e]!.withOpacity(0.7),
                      //put the emotion icon in the center of the pie chart
                      title: emotionIcons[e],
                      titleStyle: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                      radius: MediaQuery.of(context).size.width * 0.1,
                    ))
                .toList(),
          ),
        ))
      ],
    ),
  );
}

Widget percentWidget(BuildContext context, double percent, Color color) {
  //quiero que el widget tenga el tamaño del progreso, para poder simular una grafica de barras

  final percentHeight = MediaQuery.of(context).size.height * 0.18 * percent;

  return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: percentHeight,
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          "${(percent * 100).toStringAsFixed(2)}%",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.025,
              color: Colors.black),
        ),
      ));
}

Widget emotionsForWeekWidget(
  BuildContext context,
  int index,
  Map<String, List<NoteModel>> notasPorSemana,
) {
  final semana = notasPorSemana.keys
      .toList()[index]; // Obtener la clave (nombre de semana) en el índice dado
  final notesForWeek = notasPorSemana[semana]!;

  return Container(
    width: MediaQuery.of(context).size.width * 0.95,
    height: MediaQuery.of(context).size.height * 0.3,
    margin: const EdgeInsets.symmetric(horizontal: 10.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(183, 246, 246, 246),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          semana,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Row(
            children: [
              for (int i = 0; i < 7; i++)
                Expanded(
                  child: notesForDayWidget(context, notesForWeek, i),
                ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget notesForDayWidget(
  BuildContext context,
  List<NoteModel> notesForDay,
  int dayIndex,
) {
  final notesDay = notesForDay
      .where((element) => element.createdAt.weekday == dayIndex + 1)
      .toList();

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          days[dayIndex % 7],
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: notesDay.length,
            itemBuilder: (context, index) {
              return notePerDay(context, notesDay, index);
            },
          ),
        ),
      ],
    ),
  );
}

Widget notePerDay(BuildContext context, List<NoteModel> notes, int index) {
  return GestureDetector(
    onTap: () {
      showNoteInfoFromBottomShet(context, notes[index]);
    },
    child: Center(
      child: Text(notes[index].emotion.icon!,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: emotionColors[notes[index].emotion.name]!)),
    ),
  );
}

const List<String> days = ["L", "M", "M", "J", "V", "S", "D"];

void showNoteInfoFromBottomShet(BuildContext context, NoteModel note) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: emotionColors[note.emotion.name]!.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Titulo: ${note.title}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Fecha: ${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Emoción: ${note.emotion.name}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(note.emotion.icon!,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1,
                          color: emotionColors[note.emotion.name]!)),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: SingleChildScrollView(
                  child: Text(
                    textAlign: TextAlign.justify,
                    note.content,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

int getWeekNumber(DateTime date) {
  DateTime firstDayOfYear = DateTime(date.year, 1, 1);
  int days = date.difference(firstDayOfYear).inDays;
  int weeknumber = ((days - date.weekday + 10) / 7).floor();

  return weeknumber;
}

// Función para separar las notas por semana y día
Map<String, Map<String, List<NoteModel>>> separarNotasPorSemanaYDia(
    List<NoteModel> notas) {
  Map<String, Map<String, List<NoteModel>>> notasSeparadas = {};

  for (var nota in notas) {
    // Obtener el número de semana y el día de la nota
    String semana = '${getWeekNumber(nota.createdAt)}';
    String dia =
        '${nota.createdAt.year}-${nota.createdAt.month}-${nota.createdAt.day}';

    // Crear la estructura de datos si no existe
    notasSeparadas.putIfAbsent(semana, () => {});
    notasSeparadas[semana]?.putIfAbsent(dia, () => []);

    // Agregar la nota a la semana y día correspondientes
    notasSeparadas[semana]![dia]!.add(nota);
  }

  return notasSeparadas;
}

Map<String, List<NoteModel>> organizarNotasPorSemana(
    Map<String, Map<String, List<NoteModel>>> notasSeparadas) {
  Map<String, List<NoteModel>> notasPorSemana = {};

  // Obtener todas las claves (números de semana) y ordenarlas
  List<String> semanasOrdenadas = notasSeparadas.keys.toList();
  semanasOrdenadas.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

  // Iterar sobre las semanas ordenadas
  for (int i = 0; i < semanasOrdenadas.length; i++) {
    String semana = semanasOrdenadas[i];
    String semanaNombre = 'Semana ${i + 1}';

    // Agregar las notas de la semana al mapa organizado por semana
    notasPorSemana.putIfAbsent(semanaNombre, () => []);

    // Iterar sobre los días en la semana actual
    notasSeparadas[semana]!.forEach((dia, notas) {
      notasPorSemana[semanaNombre]!.addAll(notas);
    });
  }

  return notasPorSemana;
}
