import '../../../../helpers/paths.dart';

class NewDateScreen extends StatefulWidget {
  final bool isPatient;
  final int? specialistId;
  final List<DateModel>? dates;
  final Function(DateModel date, PatientModel idPatient)? onSave;
  const NewDateScreen({
    super.key,
    required this.isPatient,
    this.specialistId,
    this.dates,
    this.onSave,
  });

  @override
  State<NewDateScreen> createState() => _NewDateScreenState();
}

class _NewDateScreenState extends State<NewDateScreen> {
  bool isLoading = false;
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _time = DateTime.now();
  PatientModel? pattient;
  late UICubit uiProvider;
  SpecialistModel? specialistModel;
  PatientModel? patientModel;
  DateTime actualDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    uiProvider = getIt<UICubit>();
    if (widget.isPatient == false) {
      specialistModel = getIt<BegginCubit>().state.specialistModel;
    } else {
      patientModel = getIt<BegginCubit>().state.patientModel;
    }
  }

  @override
  void dispose() {
    _placeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva cita'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () async {
              await showMessageDialog(context, "Agendar cita",
                  "Para agendar una cita con un especialista selecciona al de tu preferencia y rellena los campos con la información necesaria. |Recibirás una confirmación por parte del especialista");
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              widget.isPatient
                  ? specialistWidget(
                      context: context,
                      specialist: specialistModel,
                      patientModel: patientModel,
                      isPatient: widget.isPatient,
                    )
                  : pattientPicker(
                      context: context,
                      patient: pattient,
                      setPattientId: (PatientModel patient) {
                        setState(() {
                          pattient = patient;
                        });
                      }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await showTableCaledarBottomSheet(
                        context: context,
                        initialDate: _selectedDate,
                        onDaySelected: (DateTime selectedDay) {
                          setState(() {
                            _selectedDate = selectedDay;
                          });
                        },
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${_selectedDate.day} de ${Utils.getMonthName(_selectedDate.month)} de ${_selectedDate.year}',
                          style: TextStyle(
                            color: uiProvider.state.themes[
                                        uiProvider.state.selectedTheme] ==
                                    uiProvider.state.themes[1]
                                ? Colors.white
                                : Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await showTimePicker(
                          barrierColor: Colors.black.withOpacity(0.5),
                          helpText: 'Selecciona la hora',
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_time),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              _time = DateTime(
                                _time.year,
                                _time.month,
                                _time.day,
                                value.hour,
                                value.minute,
                              );
                              //formato de 12 horas y agrega el AM o PM
                            });
                          }
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _time.hour > 12
                                ? '${_time.hour - 12}:${_time.minute.toString().padLeft(2, '0')} PM'
                                : '${_time.hour}:${_time.minute.toString().padLeft(2, '0')} AM',
                            style: TextStyle(
                              color: uiProvider.state.themes[
                                          uiProvider.state.selectedTheme] ==
                                      uiProvider.state.themes[1]
                                  ? Colors.white
                                  : Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  //cuando el texto llega al final del campo de texto, el texto se desplaza hacia arriba
                  maxLines: null,
                  controller: _placeController,
                  decoration: InputDecoration(
                    //sin bordes
                    hintText: 'Lugar',
                    prefixIcon: const Icon(Icons.place),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    //cuando el texto llega al final del campo de texto, el texto se desplaza hacia arriba
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      //sin bordes
                      hintText: 'Descripción (Opcional)',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ElevatedButton(
                  onPressed: () async {
                    if (widget.isPatient == true &&
                        patientModel!.specialist == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'No tienes un especialista asignado, por favor selecciona uno en la opcioo "Buscar especialista" en el menu de Agenda'),
                      ));
                      return;
                    }

                    if (widget.isPatient == false && pattient == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Por favor, seleccione un paciente'),
                      ));
                      return;
                    }

                    if (_placeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Por favor, llene todos los campos y seleccione una fecha'),
                      ));
                      return;
                    }

                    //la cita no debe ser antes del dia actual, si es el dia actual la hora no debe ser antes de la hora actual

                    //validar que la fecha seleccionada no sea menor a la fecha actual, pero solo toma el dia, mes y año, ya que si tomas toda la fecha puede dar error ya que la hora actual puede ser diferente a la hora seleccionada por milisegundos
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        _time.hour,
                        _time.minute,
                      );
                    });

                    if (_selectedDate.isBefore(actualDate)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'La fecha seleccionada no es valida, por favor selecciona una fecha futura, o una hora futura si es el dia actual'),
                      ));
                      return;
                    }

                    //la cita debe ser al menos con 1 hora de anticipacion a la hora actual
                    if (_selectedDate.isAtSameMomentAs(DateTime.now())) {
                      if (_time.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'La cita debe ser al menos con 1 hora de anticipacion'),
                        ));
                        return;
                      }
                    }

                    //si la fecha seleccionada ya esta en la lista de fechas
                    for (var date in widget.dates!) {
                      if (date.date!.day == _selectedDate.day &&
                          date.date!.month == _selectedDate.month &&
                          date.date!.year == _selectedDate.year) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Ya tiene una cita para esta fecha'),
                        ));
                        return;
                      }
                    }

                    setState(() {
                      isLoading = true;
                    });

                    final date = DateModel(
                      date: _selectedDate,
                      hour: "${_time.hour}:${getminute(_time.minute)}",
                      place: _placeController.text,
                      description: _descriptionController.text,
                      confirmByPatient: widget.isPatient,
                      confirmByEspetialist: !widget.isPatient,
                      sentBySpecialist: !widget.isPatient,
                      status: widget.isPatient
                          ? DateStatus.initial
                          : DateStatus.confirmed,
                    );

                    if (widget.isPatient) {
                      await widget.onSave!(date, patientModel!);
                    } else {
                      if (pattient == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Por favor, seleccione un paciente'),
                        ));
                      } else {
                        await widget.onSave!(date, pattient!);
                      }
                    }

                    setState(() {
                      isLoading = false;
                    });

                    if (context.mounted) Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Guardar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

String getminute(int minute) {
  if (minute < 10) {
    return '0$minute';
  } else {
    return minute.toString();
  }
}

Widget pattientPicker(
    {required BuildContext context,
    required Function(PatientModel) setPattientId,
    PatientModel? patient}) {
  final pattients = context.watch<PattientsCubit>().state.patients;

  if (pattients.isEmpty) {
    return const SizedBox(
        child: Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Aún no tienes pacientes asignados, puedes dirigirte a la sección de configuración para ver tu código de vinculación y compartirlo con tus pacientes.',
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }

  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cita para: ",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 0, 0, 0),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<int>(
            hint: Text(patient?.name ?? 'Selecciona un paciente'),
            underline: Container(),
            isExpanded: true,
            items: pattients
                .map((e) => DropdownMenuItem<int>(
                      value: e.id,
                      child: Text(e.name!),
                    ))
                .toList(),
            onChanged: (int? value) {
              final patient =
                  pattients.firstWhere((element) => element.id == value);
              setPattientId(patient);
            },
          ),
        ),
      ],
    ),
  );
}
