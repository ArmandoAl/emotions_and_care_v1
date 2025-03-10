import '../../../../helpers/paths.dart';

class DateDetail extends StatefulWidget {
  final int speciaistId;
  final DateModel date;
  final SpecialistModel specialist;
  const DateDetail(
      {super.key,
      required this.date,
      required this.speciaistId,
      required this.specialist});

  @override
  State<DateDetail> createState() => _DateDetailState();
}

class _DateDetailState extends State<DateDetail> {
  bool isloading = false;
  bool aceptedLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: '',
        isForReturn: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE3EDF3),
        ),
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      convertToName(widget.date.patient!.name!),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.mail_rounded,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Expanded(
                          child: Text(
                            widget.date.patient!.email!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Expanded(
                          child: Text(
                            widget.date.patient!.phone!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text("Información de la cita",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.065,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        widget.date.date != null
                            ? Expanded(
                                child: Text(
                                  getDateFormatWithText(widget.date.date!),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Expanded(
                          child: Text(
                            getTimeFormatWithText(widget.date.hour!),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Expanded(
                          child: Text(
                            widget.date.place!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DateDetailScreen(
                                        dateModel: widget.date,
                                        isPattient: false,
                                        especialistaModel: widget.specialist,
                                        patientModel: widget.date.patient!,
                                        edit: true)));
                          },
                          child: Text(
                            "Editar",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text("Descripción",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.065,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        )),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.date.description!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });

                        await context
                            .read<PattientsDatesCubit>()
                            .rejectDate(widget.speciaistId, widget.date.id!);

                        setState(() {
                          isloading = false;
                        });

                        if (context.mounted) Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      child: isloading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Rechazar',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          aceptedLoading = true;
                        });

                        final bool res = await context
                            .read<PattientsDatesCubit>()
                            .aceptDateBySpecialist(
                                widget.speciaistId, widget.date.id!);

                        if (res && context.mounted) {
                          await context
                              .read<ScheduleCubit>()
                              .getDatesForSpecialist(widget.speciaistId);
                        }

                        setState(() {
                          aceptedLoading = false;
                        });

                        if (context.mounted) Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: aceptedLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Aceptar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
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

String getDateFormatWithText(DateTime date) {
  //formato 19 feb 2025
  final String day = date.day.toString();

  switch (date.month) {
    case 1:
      return '$day Ene ${date.year}';
    case 2:
      return '$day Feb ${date.year}';
    case 3:
      return '$day Mar ${date.year}';
    case 4:
      return '$day Abr ${date.year}';
    case 5:
      return '$day May ${date.year}';
    case 6:
      return '$day Jun ${date.year}';
    case 7:
      return '$day Jul ${date.year}';
    case 8:
      return '$day Ago ${date.year}';
    case 9:
      return '$day Sep ${date.year}';
    case 10:
      return '$day Oct ${date.year}';
    case 11:
      return '$day Nov ${date.year}';
    case 12:
      return '$day Dic ${date.year}';
    default:
      return '';
  }
}

String getTimeFormatWithText(String hour) {
  //input 18:0,
  //take the first number (18) and give an output like 6:00 PM

  final List<String> hourList = hour.split(':');
  final int hourInt = int.parse(hourList[0]);

  //si el numero termina asi: 6:0 PM vuelvelo asi 6:00 PM
  if (hourList[1].length == 1) {
    return '${hourInt > 12 ? hourInt - 12 : hourInt}:0${hourList[1]} ${hourInt > 12 ? 'PM' : 'AM'}';
  }

  return '${hourInt > 12 ? hourInt - 12 : hourInt}:${hourList[1]} ${hourInt > 12 ? 'PM' : 'AM'}';
}

String convertToName(String name) {
  //input: "juan perez"
  //output: "Juan Perez"
  final List<String> nameList = name.split(' ');
  String nameString = '';

  for (final String item in nameList) {
    nameString += '${item[0].toUpperCase()}${item.substring(1).toLowerCase()} ';
  }

  return nameString;
}
