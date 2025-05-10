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
          // state.status == PatientsRequestsStatus.loading
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final patientsRequest = state.patientsRequest;

        if (patientsRequest.isEmpty) {
          return Scaffold(
              appBar: HeaderWidget(
                title: "Solicitudes de pacientes",
                isForReturn: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.replay,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      context
                          .read<PatientsRequestCubit>()
                          .getPatientsRequestList(widget.idUser);
                    },
                  )
                ],
              ),
              body: const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "No tienes solicitudes de pacientes pendientes. Puedes dirigirte a la sección de configuración para ver tu código de vinculación y compartirlo con tus pacientes.",
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
