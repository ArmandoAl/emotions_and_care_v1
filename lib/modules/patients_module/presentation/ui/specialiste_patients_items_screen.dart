import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/paths.dart';

class SpecialisPattientsScreen extends StatefulWidget {
  final String title;
  final List<PatientModel> pattients;
  final Function(PatientModel) onItemTap;
  final int userId;
  const SpecialisPattientsScreen(
      {super.key,
      required this.title,
      required this.onItemTap,
      required this.pattients,
      required this.userId});

  @override
  State<SpecialisPattientsScreen> createState() =>
      _SpecialisPattientsScreenState();
}

class _SpecialisPattientsScreenState extends State<SpecialisPattientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE3EDF3),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<PattientsCubit>().getPattients(widget.userId);
          },
          child: ListView(
            children: itemsList(context, widget.pattients, widget.onItemTap),
          ),
        ),
      ),
    );
  }
}

List<Widget> itemsList(
    BuildContext context, List<PatientModel> pattients, Function onTap) {
  final List<Widget> list = [];

  list.add(SizedBox(
    height: MediaQuery.of(context).size.height * 0.02,
  ));
  for (final PatientModel pattient in pattients) {
    list.add(containerItem(
      context,
      Colors.white,
      Icon(
        Icons.person,
        color: const Color(0xFF71D5FF),
        size: MediaQuery.of(context).size.width * 0.1,
      ),
      pattient.name,
      pattient.sex,
      () {
        onTap(pattient);
      },
    ));

    list.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    ));
  }
  return list;
}
