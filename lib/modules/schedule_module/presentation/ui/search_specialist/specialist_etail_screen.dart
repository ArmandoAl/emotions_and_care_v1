import '../../../../../helpers/paths.dart';

class SpecialistDetailScreen extends StatefulWidget {
  final PatientModel? patientModel;
  final SpecialistModel? specialistModel;
  final Future<bool> Function(String) syncByCode;
  const SpecialistDetailScreen(
      {super.key,
      required this.patientModel,
      required this.specialistModel,
      required this.syncByCode});

  @override
  State<SpecialistDetailScreen> createState() => _SpecialistDetailScreenState();
}

class _SpecialistDetailScreenState extends State<SpecialistDetailScreen> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del especialista"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Column(
                        children: [
                          Icon(Icons.person,
                              size: MediaQuery.of(context).size.height * 0.1),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          Text(widget.specialistModel!.name!),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.email,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text("Correo ",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(widget.specialistModel!.email!),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.phone,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text("Teléfono ",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(widget.specialistModel!.phone!),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text("Sexo ",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(widget.specialistModel!.sex!,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text("Edad ",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("${widget.specialistModel!.age} años",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text("Enfoque",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(widget.specialistModel!.focus!,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text("Institución",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          widget.specialistModel!.presentation != ""
                              ? widget.specialistModel!.presentation!
                              : "Sin institución",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text("Ubicacion",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          widget.specialistModel!.ubication != ""
                              ? widget.specialistModel!.ubication!
                              : "Sin ubicación definida",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text("Carta de presentación",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                    ],
                  ),
                  Text(
                      widget.specialistModel!.institution != ""
                          ? widget.specialistModel!.institution!
                          : "Sin carta de presentación",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isloading = !isloading;
                        });
                        bool result = await widget.syncByCode(
                            widget.specialistModel!.tokenForRelate!);
                        setState(() {
                          isloading = !isloading;
                        });

                        if (context.mounted) {
                          await showConfirmTextDialog(context,
                              result ? "Especialista vinculado" : "Error");
                        }
                        if (context.mounted) Navigator.pop(context);
                      },
                      child: isloading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Vincular especialista",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showConfirmTextDialog(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirmación"),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
