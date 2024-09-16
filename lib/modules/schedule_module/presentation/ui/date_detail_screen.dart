import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helpers/paths.dart';

class DateDetailScreen extends StatefulWidget {
  final DateModel? dateModel;
  final bool isPattient;
  final SpecialistModel? especialistaModel;
  final PatientModel? patientModel;
  const DateDetailScreen(
      {super.key,
      required this.dateModel,
      required this.isPattient,
      required this.especialistaModel,
      required this.patientModel});

  @override
  State<DateDetailScreen> createState() => _DateDetailScreenState();
}

class _DateDetailScreenState extends State<DateDetailScreen> {
  bool _isEditing = false;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.dateModel!.description;
  }

  @override
  void dispose() {
    descriptionController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de la cita'),
          actions: [
            IconButton(
              icon: Icon(
                _isEditing ? Icons.save : Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
            ),
            IconButton(
                onPressed: () async {
                  await showDeleteMassageDialog(context, () async {
                    await context
                        .read<ScheduleCubit>()
                        .deleteDate(widget.dateModel!.id!);
                  });

                  await context
                      .read<ScheduleCubit>()
                      .getDatesForSpecialist(widget.especialistaModel!.id);

                  if (context.mounted) Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              widget.isPattient == false
                  ? Text("Patient: ${widget.dateModel!.patient!.name}")
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: const Border.fromBorderSide(
                          BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical:
                                MediaQuery.of(context).size.height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Especialista: ${widget.patientModel!.specialist!.name}",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Numero: ${widget.patientModel!.specialist!.phone}",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "Correo: ${widget.patientModel!.specialist!.email}",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fecha: ${widget.dateModel!.date.day}/${widget.dateModel!.date.month}/${widget.dateModel!.date.year} ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Hora: ${widget.dateModel!.hour}",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Lugar: ${widget.dateModel!.place}",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: descriptionController,
                  enabled: _isEditing,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Descripción",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Notas del especialista:",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: notesController,
                        enabled: _isEditing,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Notas",
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Future<void> showDeleteMassageDialog(
    BuildContext context, Function() deleteFunction) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("¿Estás seguro de que quieres eliminar esta cita?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await deleteFunction();
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text("Eliminar"),
          ),
        ],
      );
    },
  );
}
