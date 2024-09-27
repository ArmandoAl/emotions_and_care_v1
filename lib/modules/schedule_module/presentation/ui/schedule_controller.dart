import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../config/assets/assets.dart';
import '../../../../helpers/paths.dart';

class ScheduleController extends StatefulWidget {
  final PatientModel? patientModel;
  final Function? changeIndex;
  final bool isPattient;
  final SpecialistModel? especialistaModel;
  const ScheduleController(
      {super.key,
      required this.patientModel,
      required this.changeIndex,
      required this.isPattient,
      required this.especialistaModel});

  @override
  State<ScheduleController> createState() => _ScheduleControllerState();
}

class _ScheduleControllerState extends State<ScheduleController> {
  @override
  void initState() {
    super.initState();
    if (widget.isPattient == false) {
      context
          .read<ScheduleCubit>()
          .getDatesForSpecialist(widget.especialistaModel!.id!);
    } else {
      context.read<ScheduleCubit>().getSchedule(widget.patientModel!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      bloc: context.read<ScheduleCubit>(),
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        if (state.status == ScheduleStatus.error) {
          return const Scaffold(
            body: Center(
              child: Text(
                  'Error al cargar las citas, intente de nuevo haciendo scroll hacia abajo',
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.none)),
            ),
          );
        }
        return Scaffold(
          // appBar: widget.isPattient
          //     ? HeaderWidget(
          //         title: 'Agenda',
          //         isForReturn: !widget.isPattient,
          //         action: null)
          //     : AppBar(
          //         title: const Text('Agenda'),
          //         actions: [
          //           IconButton(
          //             icon: const Icon(Icons.help),
          //             color: Colors.black,
          //             onPressed: () {
          //               showDialog(
          //                 context: context,
          //                 builder: (context) {
          //                   return const AlertDialog(
          //                     title: Text('Ayuda'),
          //                     content: Text(
          //                         'En esta pantalla podrá ver las citas que tiene programadas, si desea ver más detalles de una cita, solo debe dar clic en la cita que desea ver.'),
          //                   );
          //                 },
          //               );
          //             },
          //           ),
          //         ],
          //       ),

          body: state.status == ScheduleStatus.loading
              ? Center(
                  child: Lottie.asset(Assets.brainLoading),
                )
              : ScheduleScreen(
                  dates: state.dates,
                  isPatient: widget.isPattient,
                  patient: widget.patientModel,
                  specialist: widget.especialistaModel,
                  onDateTap: (DateModel date) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DateDetailScreen(
                          dateModel: date,
                          isPattient: widget.isPattient,
                          patientModel: widget.patientModel,
                          especialistaModel: widget.especialistaModel,
                        ),
                      ),
                    );
                  },
                  onRefresh: () async {
                    if (widget.isPattient == false) {
                      context
                          .read<ScheduleCubit>()
                          .getDatesForSpecialist(widget.especialistaModel!.id!);
                    } else {
                      context
                          .read<ScheduleCubit>()
                          .getSchedule(widget.patientModel!.id!);
                    }
                  },
                ),
        );
      },
    );
  }
}
