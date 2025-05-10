import '../../../../helpers/paths.dart';

class DateDetailScreen extends StatefulWidget {
  final DateModel? dateModel;
  final bool isPattient;
  final SpecialistModel? especialistaModel;
  final PatientModel? patientModel;
  final bool? edit;
  const DateDetailScreen({
    super.key,
    required this.dateModel,
    required this.isPattient,
    required this.especialistaModel,
    required this.patientModel,
    this.edit = false,
  });

  @override
  State<DateDetailScreen> createState() => _DateDetailScreenState();
}

class _DateDetailScreenState extends State<DateDetailScreen> {
  bool isEditing = false;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController specialistNotesController = TextEditingController();
  DateTime date = DateTime.now().toLocal();
  String hour = "";
  bool pendingToMatch = false;
  List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(
      value: "Inicial",
      child: Text("Inicial"),
    ),
    const DropdownMenuItem(
      value: "Completada",
      child: Text("Completada"),
    ),
    const DropdownMenuItem(
      value: "No completada",
      child: Text("No asistió"),
    ),
  ];
  String statusValue = "Inicial";

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.dateModel!.description ?? '';
    date = widget.dateModel!.date!;
    placeController.text = widget.dateModel!.place ?? '';
    hour = widget.dateModel!.hour!;
    statusValue = getStatusFromDateValue(widget.dateModel!.status!, items);
    if (widget.dateModel!.status == DateStatus.pendingToMatch) {
      pendingToMatch = true;
    }

    if (widget.edit == true) {
      isEditing = true;
    }
  }

  String getStatusFromDateValue(
      DateStatus status, List<DropdownMenuItem<String>> items) {
    switch (status) {
      case DateStatus.initial:
        return items[0].value!;
      case DateStatus.confirmed:
        return items[0].value!;
      case DateStatus.completed:
        return items[2].value!;
      case DateStatus.notCompleted:
        return items[3].value!;
      case DateStatus.pendingToMatch:
        return items[0].value!;
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    placeController.dispose();
    specialistNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderWidget(
          title: "",
          isForReturn: true,
          actions: [
            if (isEditing)
              IconButton(
                  onPressed: () async {
                    setState(() {
                      isEditing = false;
                    });
                    //reset the values
                    descriptionController.text = widget.dateModel!.description!;
                    placeController.text = widget.dateModel!.place!;
                    specialistNotesController.text =
                        widget.dateModel!.specialistNotes!;
                    date = widget.dateModel!.date!;
                    hour = widget.dateModel!.hour!;
                  },
                  icon: const Icon(
                    Icons.cancel,
                  )),
            IconButton(
                onPressed: () async {
                  await showDeleteMassageDialog(context, () async {
                    await showLoadingdialog("Eliminando cita", context,
                        () async {
                      await context
                          .read<ScheduleCubit>()
                          .deleteDate(widget.dateModel!.id!);
                    });

                    if (widget.isPattient == false && context.mounted) {
                      await context
                          .read<ScheduleCubit>()
                          .getDatesForSpecialist(widget.especialistaModel!.id!);
                    }
                  });

                  if (context.mounted) Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.primary,
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
                    : SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Datos del especialista",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.065,
                                      color: Colors.black,
                                      decoration: TextDecoration.none)),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  Text(
                                    widget.patientModel!.specialist!.name!,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  Text(
                                    widget.patientModel!.specialist!.phone!,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  Text(
                                    widget.patientModel!.specialist!.email!,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                GestureDetector(
                  onTap: () async {
                    if (isEditing) {
                      await showTableCaledarBottomSheet(
                        context: context,
                        initialDate: date,
                        onDaySelected: (DateTime selectedDay) {
                          setState(() {
                            date = selectedDay;
                          });
                        },
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 3,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              "Fecha",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          getDateFormatWithText(date),
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: isEditing ? Colors.black : Colors.grey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                GestureDetector(
                  onTap: () async {
                    if (isEditing) {
                      await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(date),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            hour = "${value.hour}:${value.minute}";
                          });
                        }
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 3,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              "Hora",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          getTimeFormatWithText(hour),
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: isEditing ? Colors.black : Colors.grey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            "Ubicación",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: placeController,
                        enabled: isEditing,
                        decoration: const InputDecoration(
                          hintText: "Ej: Calle 123, CDMX",
                          border: InputBorder.none,
                        ),
                      ),
                    ],
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
                    enabled: isEditing,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Descripción",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                widget.isPattient == false
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      )
                    : const SizedBox.shrink(),
                widget.isPattient == false
                    ? Row(
                        children: [
                          Text(
                            "Notas del especialista:",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                widget.isPattient == false
                    ? Container(
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
                                controller: specialistNotesController,
                                enabled: isEditing,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  hintText: "Notas",
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                widget.isPattient == false
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      )
                    : const SizedBox.shrink(),
                widget.isPattient == false
                    ? Row(
                        children: [
                          Text(
                            "Estado de la cita:",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                widget.isPattient == false
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 3,
                        ),
                        child: DropdownButton(
                            // enable: isEditing,
                            underline: const SizedBox.shrink(),
                            elevation: 1,
                            isExpanded: true,
                            items: items,
                            onChanged: (value) {
                              setState(() {
                                statusValue = value.toString();
                              });
                            },
                            value: statusValue),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                if (widget.isPattient == true &&
                    widget.dateModel!.status == DateStatus.pendingToMatch &&
                    isEditing == false)
                  Column(
                    children: [
                      Text(
                          "El especialista ha hecho cambios en la cita, por favor acepta la cita o da click en editar para proponer una nueva fecha",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () async {
                          if (isEditing) {
                            await showLoadingdialog("Guardando cita", context,
                                () async {
                              if (statusValue == "Inicial") {
                                bool res = await context
                                    .read<ScheduleCubit>()
                                    .updateDate(
                                      widget.dateModel!.copyWith(
                                        date: date,
                                        hour: hour,
                                        place: placeController.text,
                                        description: descriptionController.text,
                                        status: statusValue == "Inicial"
                                            ? DateStatus.pendingToMatch
                                            : statusValue == "Completada"
                                                ? DateStatus.completed
                                                : DateStatus.notCompleted,
                                        specialistNotes:
                                            specialistNotesController.text,
                                        confirmByEspetialist:
                                            !widget.isPattient,
                                        confirmByPatient: widget.isPattient,
                                        sentBySpecialist: !widget.isPattient,
                                      ),
                                      widget.dateModel!.patient!.id!,
                                      widget.especialistaModel!.id!,
                                      !widget.isPattient,
                                    );

                                if (res == true && context.mounted) {
                                  showMessageDialog(context, "Cita actualizada",
                                      "Tu cita ha sido actualizada correctamente");
                                } else {
                                  if (context.mounted) {
                                    showMessageDialog(context, "Error",
                                        "Hubo un error al actualizar la cita",
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Aceptar"),
                                          ),
                                        ]);
                                  }
                                }

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              } else {
                                bool res = await context
                                    .read<ScheduleCubit>()
                                    .updateDateStatus(
                                      widget.dateModel!.copyWith(
                                        date: date,
                                        hour: hour,
                                        place: placeController.text,
                                        description: descriptionController.text,
                                        status: statusValue == "Inicial"
                                            ? DateStatus.pendingToMatch
                                            : statusValue == "Completada"
                                                ? DateStatus.completed
                                                : DateStatus.notCompleted,
                                        specialistNotes:
                                            specialistNotesController.text,
                                        sentBySpecialist: !widget.isPattient,
                                      ),
                                    );

                                if (res == true && context.mounted) {
                                  showMessageDialog(context, "Cita actualizada",
                                      "Tu cita ha sido actualizada correctamente");
                                } else {
                                  if (context.mounted) {
                                    showMessageDialog(context, "Error",
                                        "Hubo un error al actualizar la cita",
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Aceptar"),
                                          ),
                                        ]);
                                  }
                                }

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }

                              if (context.mounted) Navigator.of(context).pop();
                              if (context.mounted) Navigator.of(context).pop();
                            });
                          } else {
                            setState(() {
                              isEditing = !isEditing;
                            });
                          }
                        },
                        child: Text(
                          isEditing ? "Guardar" : "Editar",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )),
                    if (widget.isPattient == true &&
                        widget.dateModel!.status == DateStatus.pendingToMatch &&
                        isEditing == false)
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () async {
                            await showLoadingdialog("Guardando cita", context,
                                () async {
                              await context
                                  .read<ScheduleCubit>()
                                  .confirmDateByPatient(
                                    widget.dateModel!.copyWith(
                                      status: DateStatus.confirmed,
                                    ),
                                    widget.dateModel!.patient!.id!,
                                  );

                              if (context.mounted) Navigator.of(context).pop();
                              if (context.mounted) Navigator.of(context).pop();
                            });
                          },
                          child: const Text(
                            "Aceptar",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        ));
  }
}

Future<void> showDeleteMassageDialog(
    BuildContext context, Function() deleteFunction) async {
  await showDialog(
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
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text("Eliminar"),
          ),
        ],
      );
    },
  );
}
