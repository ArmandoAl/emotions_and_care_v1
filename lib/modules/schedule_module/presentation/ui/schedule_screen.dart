import 'package:table_calendar/table_calendar.dart';

import '../../../../helpers/paths.dart';

class ScheduleScreen extends StatefulWidget {
  static const String route = 'schedule';
  final List<DateModel> dates;
  final bool isPatient;
  final PatientModel? patient;
  final SpecialistModel? specialist;
  final Function? onDateTap;
  final Future<void> Function() onRefresh;
  const ScheduleScreen(
      {super.key,
      required this.dates,
      required this.isPatient,
      this.patient,
      this.specialist,
      this.onDateTap,
      required this.onRefresh});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateModel? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.onRefresh();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                  rightChevronIcon: const Icon(
                    Icons.chevron_right,
                  ),
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                  ),
                  headerMargin: const EdgeInsets.only(bottom: 10, top: 10),
                  titleTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  titleTextFormatter: (date, locale) =>
                      '${Utils.getMonthName(date.month)} ${date.year}',
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                focusedDay: DateTime.now(),
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                eventLoader: (day) {
                  return widget.dates
                      .where((element) =>
                          element.date!.day == day.day &&
                          element.date!.month == day.month &&
                          element.date!.year == day.year)
                      .toList();
                },
                onDaySelected: (selectedDay, focusedDay) {
                  for (var date in widget.dates) {
                    if (date.date!.day == selectedDay.day &&
                        date.date!.month == selectedDay.month &&
                        date.date!.year == selectedDay.year) {
                      setState(() {
                        _selectedDate = date;
                      });

                      widget.onDateTap!(date);

                      return;
                    }
                  }
                },
                selectedDayPredicate: (day) {
                  return _selectedDate != null &&
                      day.day == _selectedDate!.date!.day &&
                      day.month == _selectedDate!.date!.month &&
                      day.year == _selectedDate!.date!.year;
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
                child: Padding(
              padding: widget.isPatient
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _selectedDate == null
                      ? const Color.fromARGB(255, 86, 128, 140)
                      : Colors.deepPurple[900]!,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: containerContentWidget(
                    context,
                    _selectedDate,
                    widget.isPatient,
                    widget.patient,
                    widget.specialist,
                    widget.dates),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
