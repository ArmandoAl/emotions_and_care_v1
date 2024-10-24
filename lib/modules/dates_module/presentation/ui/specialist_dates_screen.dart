// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        title: const Text("Citas de los pacientes"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            context
                .read<PattientsDatesCubit>()
                .getPattientsDates(widget.userId);
          },
          child: ListView(
            children: itemsList(
              context,
              dates,
              widget.onItemTap,
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
    list.add(containerItem(
      context,
      Colors.white,
      Icon(
        Icons.person,
        color: const Color(0xFF71D5FF),
        size: MediaQuery.of(context).size.width * 0.1,
      ),
      date != null
          ? "${date.patient!.name}: ${date.date!.day}/${date.date!.month}/${date.date!.year} ${date.hour}"
          : "",
      "",
      () {
        onTap(date);
      },
    ));

    list.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    ));
  }
  return list;
}
