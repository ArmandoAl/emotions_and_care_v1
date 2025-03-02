// ignore_for_file: unnecessary_null_comparison

import 'package:emotions_and_care_v1/widgets/header_specialist_widget.dart';

import '../../../../helpers/paths.dart';

class SpecialistDatesScreen extends StatefulWidget {
  final String title;
  final List<DateRequestModel> datesRequest;
  final Function(DateModel) onItemTap;
  final int userId;
  const SpecialistDatesScreen(
      {super.key,
      required this.title,
      required this.onItemTap,
      required this.datesRequest,
      required this.userId});

  @override
  State<SpecialistDatesScreen> createState() => _SpecialistDatesScreenState();
}

class _SpecialistDatesScreenState extends State<SpecialistDatesScreen> {
  List<DateModel> get dates {
    final List<DateModel> dates = [];
    for (final DateRequestModel dateRequest in widget.datesRequest) {
      if (dateRequest.date != null) {
        dates.add(dateRequest.date!);
      }
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSpecialistWidget(
          title: "Citas de los pacientes", isForReturn: true, context: context),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            context
                .read<PattientsDatesCubit>()
                .getPattientsDates(widget.userId);
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: ListView(
              children: itemsList(
                context,
                dates,
                widget.onItemTap,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> itemsList(
    BuildContext context, List<DateModel> dates, Function onTap) {
  final List<Widget> list = [];

  list.add(SizedBox(
    height: MediaQuery.of(context).size.height * 0.02,
  ));
  for (final DateModel date in dates) {
    list.add(GestureDetector(
      onTap: () {
        onTap(date);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.015,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          date != null ? getDateFormatWithText(date.date!) : "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.schedule, color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          date != null ? getTimeFormatWithText(date.hour!) : "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
                ],
              ),
            ),
            containerItem(
                context,
                Colors.white,
                date != null ? "${date.patient!.name}" : "",
                date != null ? "${date.patient!.email}" : '',
                "", () {
              onTap(date);
            }, hasHeader: true, icon: Icons.info_outline_rounded),
          ],
        ),
      ),
    ));

    list.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    ));
  }
  return list;
}
