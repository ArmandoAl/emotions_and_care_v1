import 'package:table_calendar/table_calendar.dart';
import '../helpers/paths.dart';

Future<void> showTableCaledarBottomSheet(
    {required BuildContext context,
    required DateTime initialDate,
    required Function(DateTime) onDaySelected}) {
  final uiCubit = getIt<UICubit>();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          //si el tema es oscuro el color de fondo sera gris oscuro
          color: uiCubit.state.themes[uiCubit.state.selectedTheme] ==
                  uiCubit.state.themes[3]
              ? Colors.black
              : Theme.of(context).scaffoldBackgroundColor,

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: TableCalendar(
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronVisible: false,
            rightChevronVisible: false,
            headerMargin: const EdgeInsets.only(bottom: 10, top: 10),
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            titleTextFormatter: (date, locale) =>
                '${Utils.getMonthName(date.month)} ${date.year}',
          ),
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 90)),
          focusedDay: initialDate,
          calendarFormat: CalendarFormat.month,
          onDaySelected: (selectedDay, focusedDay) {
            onDaySelected(selectedDay);
            Navigator.pop(context);
          },
        ),
      );
    },
  );

  return Future.value();
}

Widget specialistWidget(
    {required BuildContext context,
    required SpecialistModel? specialist,
    required PatientModel? patientModel,
    required bool isPatient}) {
  if (patientModel!.specialist == null) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01,
            vertical: MediaQuery.of(context).size.height * 0.01),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                'No hay un especialista asignado, has click para encontrar uno',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Especialista: ${patientModel.specialist!.name}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'Correo: ${patientModel.specialist!.email}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'Telefono: ${patientModel.specialist!.phone}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Icon(
            Icons.person,
            size: MediaQuery.of(context).size.width * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
        ],
      ),
    );
  }
}
