import '../helpers/paths.dart';

Widget containerContentWidget(
  BuildContext context,
  DateModel? date,
  bool isPatient,
  PatientModel? patientModel,
  SpecialistModel? especialistaModel,
  List<DateModel> dates,
) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03),
    child: ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewDateScreen(
                  patientModel:
                      isPatient && patientModel != null ? patientModel : null,
                  specialistModel: isPatient ? null : especialistaModel,
                  isPatient: isPatient,
                  dates: dates,
                  onSave: (DateModel date, PatientModel patient) async {
                    if (isPatient) {
                      GoalwithDate? res = await context
                          .read<ScheduleCubit>()
                          .addDate(
                              patient.id!, date, patientModel!.specialist!.id!);

                      if (res.goal != null && context.mounted) {
                        final UICubit uiProvider = context.read<UICubit>();

                        await uiProvider.getSticker(res.goal!.idSticker!);

                        if (context.mounted) {
                          await showStickerDialog(context, res.goal!);
                        }
                      }
                    } else {
                      await context.read<ScheduleCubit>().addDateBySpecialist(
                          especialistaModel!.id!, date, patient);
                    }
                  },
                ),
              ),
            );
          },
          child: Row(
            children: [
              const Icon(Icons.add_circle_sharp, color: Colors.white),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Expanded(
                child: Text(
                  "Agendar cita ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.05,
        // ),
        // Row(
        //   children: [
        //     const Icon(Icons.calendar_today, color: Colors.white),
        //     SizedBox(
        //       width: MediaQuery.of(context).size.width * 0.02,
        //     ),
        //     Expanded(
        //       child: Text(
        //         "Historial de citas",
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize: MediaQuery.of(context).size.height * 0.025,
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        isPatient
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchSpecialistController(
                        patientModel: patientModel,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.person_search_rounded,
                        color: Colors.white),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Expanded(
                      child: Text(
                        "Buscar especialista ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    ),
  );
}

class Utils {
  static String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
      default:
        return '';
    }
  }
}
