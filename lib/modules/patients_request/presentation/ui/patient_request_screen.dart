import 'package:emotions_and_care_v1/helpers/paths.dart';
import 'package:emotions_and_care_v1/modules/patients_request/presentation/logic/patient_request_cubit.dart';
import 'package:emotions_and_care_v1/widgets/header_specialist_widget.dart';

class PatientRequestScreen extends StatefulWidget {
  final List<PatientRequest> patientsRequest;
  final Function(PatientRequest) onItemTap;
  final int userId;
  const PatientRequestScreen(
      {super.key,
      required this.patientsRequest,
      required this.onItemTap,
      required this.userId});

  @override
  State<PatientRequestScreen> createState() => _PatientRequestScreenState();
}

class _PatientRequestScreenState extends State<PatientRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSpecialistWidget(
          title: "Solicitudes de pacientes",
          isForReturn: true,
          context: context),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            context
                .read<PatientsRequestCubit>()
                .getPatientsRequestList(widget.userId);
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: ListView(
              children: itemsRequestList(
                context,
                widget.patientsRequest,
                widget.onItemTap,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> itemsRequestList(BuildContext context,
    List<PatientRequest> patientsRequest, Function onTap) {
  final List<Widget> items = [];

  items.add(SizedBox(
    height: MediaQuery.of(context).size.height * 0.02,
  ));
  for (final PatientRequest patientRequest in patientsRequest) {
    items.add(containerItem(
      context,
      Colors.white,
      patientRequest.patient.name!,
      patientRequest.patient.email!,
      patientRequest.patient.sex ?? '',
      () {
        onTap(patientRequest);
      },
    ));

    items.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    ));
  }
  return items;
}
