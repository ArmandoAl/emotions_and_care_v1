import 'package:emotions_and_care_v1/widgets/header_specialist_widget.dart';
import 'package:lottie/lottie.dart';
import '../../../../helpers/paths.dart';

class ScheduleController extends StatefulWidget {
  final bool isPattient;
  const ScheduleController({
    super.key,
    required this.isPattient,
  });

  @override
  State<ScheduleController> createState() => _ScheduleControllerState();
}

class _ScheduleControllerState extends State<ScheduleController> {
  PatientModel? patientModel;
  SpecialistModel? especialistaModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isPattient == false) {
        especialistaModel = getIt<BegginCubit>().state.specialistModel;
        patientModel = null;
        if (context.read<ScheduleCubit>().state.dates.isEmpty) {
          context
              .read<ScheduleCubit>()
              .getDatesForSpecialist(especialistaModel!.id!);
        }
      } else {
        patientModel = getIt<BegginCubit>().state.patientModel;
        especialistaModel = getIt<BegginCubit>().state.patientModel!.specialist;
        context.read<ScheduleCubit>().getSchedule(patientModel!.id!);
      }
    });
  }

  //didChangeDependencies
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.isPattient == false) {
      especialistaModel = getIt<BegginCubit>().state.specialistModel;
      patientModel = null;
      if (context.read<ScheduleCubit>().state.dates.isEmpty) {
        context
            .read<ScheduleCubit>()
            .getDatesForSpecialist(especialistaModel!.id!);
      }
    } else {
      patientModel = getIt<BegginCubit>().state.patientModel;
      especialistaModel = null;
      context.read<ScheduleCubit>().getSchedule(patientModel!.id!);
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
          appBar: widget.isPattient
              ? null
              : HeaderSpecialistWidget(
                  title: 'Agenda',
                  isForReturn: true,
                  context: context,
                  actions: [
                      IconButton(
                          onPressed: () async {
                            if (widget.isPattient == false) {
                              especialistaModel =
                                  getIt<BegginCubit>().state.specialistModel;

                              await showLoadingdialog("Cargando datos", context,
                                  () async {
                                await context
                                    .read<ScheduleCubit>()
                                    .getDatesForSpecialist(
                                        especialistaModel!.id!,
                                        reloading: true);

                                if (context.mounted) {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }
                              });
                            } else {
                              patientModel =
                                  getIt<BegginCubit>().state.patientModel;

                              await showLoadingdialog("Cargando datos", context,
                                  () async {
                                await context.read<ScheduleCubit>().getSchedule(
                                    patientModel!.id!,
                                    reloading: true);

                                if (context.mounted) {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }
                              });
                            }
                          },
                          icon: Icon(
                            Icons.refresh,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      IconButton(
                        icon: Icon(Icons.help,
                            color: Theme.of(context).colorScheme.secondary),
                        color: Colors.black,
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text('Ayuda'),
                                content: Text(
                                    'En esta pantalla podrá ver las citas que tiene programadas, si desea ver más detalles de una cita, solo debe dar clic en la cita que desea ver.'),
                              );
                            },
                          );
                        },
                      )
                    ]),
          body: state.status == ScheduleStatus.loading
              ? Center(
                  child: Lottie.asset(Assets.brainLoading),
                )
              : ScheduleScreen(
                  dates: state.dates,
                  isPatient: widget.isPattient,
                  onDateTap: (DateModel date) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DateDetailScreen(
                          dateModel: date,
                          isPattient: widget.isPattient,
                          patientModel: patientModel,
                          especialistaModel: especialistaModel,
                        ),
                      ),
                    );
                  },
                  onRefresh: () async {
                    if (widget.isPattient == false) {
                      context
                          .read<ScheduleCubit>()
                          .getDatesForSpecialist(especialistaModel!.id!);
                    } else {
                      context
                          .read<ScheduleCubit>()
                          .getSchedule(patientModel!.id!);
                    }
                  },
                ),
        );
      },
    );
  }
}
