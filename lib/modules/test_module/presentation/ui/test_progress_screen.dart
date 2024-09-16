import '../../../../helpers/paths.dart';

class TestProgressScreen extends StatefulWidget {
  static const String route = 'progress';
  final PatientModel patientModel;
  final bool isPatient;
  final List<HistoryTestModel> historyTestList;
  final Function(TestInfoModel) onFisrtItemTap;
  final Function(HistoryTestModel test) onTap;

  const TestProgressScreen(
      {super.key,
      required this.onTap,
      required this.patientModel,
      required this.historyTestList,
      required this.isPatient,
      required this.onFisrtItemTap});

  @override
  State<TestProgressScreen> createState() => _TestProgressScreenState();
}

class _TestProgressScreenState extends State<TestProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Progreso de cuestionarios",
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.isPatient
                  ? "Estos son los resultados de los últimos cuestionarios que has respondido"
                  : "Estos son los cuestionarios que ha realizado el paciente ${widget.patientModel.name}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.historyTestList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    testItem(
                      context,
                      widget.historyTestList[index],
                      widget.onFisrtItemTap,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            widget.onTap(widget.historyTestList[index]);
                          },
                          child: const Text(
                            "Ver historial",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
