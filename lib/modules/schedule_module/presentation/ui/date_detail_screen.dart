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
    descriptionController.text = widget.dateModel!.description ?? '';
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
        appBar: HeaderWidget(
          title: "",
          isForReturn: true,
          actions: [
            IconButton(
              icon: Icon(
                _isEditing ? Icons.save : Icons.edit,
                color: Theme.of(context).colorScheme.secondary,
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

                  if (context.mounted) {
                    await context
                        .read<ScheduleCubit>()
                        .getDatesForSpecialist(widget.especialistaModel!.id!);
                  }

                  if (context.mounted) Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.surface,
                )),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                widget.isPattient == false
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            convertToName(widget.dateModel!.patient!.name!),
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Cita",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                "${widget.dateModel!.date!.day}/${widget.dateModel!.date!.month}/${widget.dateModel!.date!.year}",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                getTimeFormatWithText(widget.dateModel!.hour!),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                widget.dateModel!.place!,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
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
                Row(
                  children: [
                    Text("Descripción",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                            decoration: TextDecoration.none)),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.black,
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
                Row(
                  children: [
                    Text(
                      "Notas del especialista:",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
