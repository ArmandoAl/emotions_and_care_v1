import 'package:emotions_and_care_v1/helpers/paths.dart';
import 'package:emotions_and_care_v1/modules/patients_request/presentation/logic/patient_request_cubit.dart';
import 'package:emotions_and_care_v1/modules/patients_request/presentation/ui/patient_request_detail_screen.dart';
import 'package:emotions_and_care_v1/modules/patients_request/presentation/ui/patient_request_screen.dart';

class PatientsRequestController extends StatefulWidget {
  final int idUser;
  const PatientsRequestController({super.key, required this.idUser});

  @override
  State<PatientsRequestController> createState() =>
      _PatientsRequestControllerState();
}

class _PatientsRequestControllerState extends State<PatientsRequestController> {
  @override
  void initState() {
    context.read<PatientsRequestCubit>().getPatientsRequestList(widget.idUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientsRequestCubit, PatientsRequestsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.status == PatientsRequestsStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final patientsRequest = state.patientsRequest;

        if (patientsRequest.isEmpty) {
          return const Scaffold(
              appBar: HeaderWidget(
                  title: "Solicitudes de pacientes", isForReturn: true),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'No tienes solicitudes de pacientes pendientes, puedes dirigirte a la seccion de configuracion para ver tu codigo de vinculacion y compartirlo con tus pacientes',
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
        }

        return PatientRequestScreen(
            patientsRequest: patientsRequest,
            userId: widget.idUser,
            onItemTap: (PatientRequest patientRequest) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientRequestDetail(
                          specialistId: widget.idUser,
                          patientRequest: patientRequest)));
            });
      },
    );
  }
}
