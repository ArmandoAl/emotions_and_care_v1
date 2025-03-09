import 'package:emotions_and_care_v1/modules/patients_module/presentation/ui/specialiste_patients_items_screen.dart';

import '../../../../helpers/paths.dart';

class SpecialistPattientsController extends StatefulWidget {
  final int idUser;
  const SpecialistPattientsController({
    super.key,
    required this.idUser,
  });

  @override
  State<SpecialistPattientsController> createState() =>
      _SpecialistPattientsControllerState();
}

class _SpecialistPattientsControllerState
    extends State<SpecialistPattientsController> {
  @override
  void initState() {
    if (context.read<PattientsCubit>().state.patients.isEmpty) {
      context.read<PattientsCubit>().getPattients(widget.idUser);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PattientsCubit, PattientsState>(
        bloc: context.read<PattientsCubit>(),
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.status == PattientsStatus.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final patients = state.patients;

          if (patients.isEmpty) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Pacientes'),
                ),
                body: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Aun no tienes pacientes asignados, puedes dirigirte a la seccion de configuracion para ver tu codigo de vinculacion y compartirlo con tus pacientes.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ));
          }

          return SpecialisPattientsScreen(
            title: 'Pacientes',
            pattients: patients,
            userId: widget.idUser,
            onItemTap: (PatientModel patient) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientDetail(
                            patient: patient,
                          )));
            },
          );
        });
  }
}
