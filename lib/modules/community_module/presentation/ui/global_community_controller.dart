import 'package:emotions_and_care_v1/helpers/paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalCommunityController extends StatefulWidget {
  final Function(int) changeIndex;
  final PatientModel? patientModel;
  final SpecialistModel? specialistModel;
  final bool isPatient;

  const GlobalCommunityController(
      {super.key,
      required this.changeIndex,
      this.patientModel,
      this.specialistModel,
      required this.isPatient});

  @override
  State<GlobalCommunityController> createState() =>
      _GlobalCommunityControllerState();
}

class _GlobalCommunityControllerState extends State<GlobalCommunityController> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Scaffold(
          appBar: widget.isPatient
              ? const HeaderWidget(title: "Comunidad", isForReturn: false)
              : AppBar(
                  title: const Text("Comunidad"),
                  centerTitle: true,
                ),
          drawer: widget.isPatient
              ? DrawerWidget(
                  currentIndex: 3,
                  changeIndex: widget.changeIndex,
                )
              : null,
          body: CommunityMenuScreen(
            onCartsTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommunityCartsControoler(
                            patient: widget.patientModel,
                            specialist: widget.specialistModel,
                            isPatient: widget.isPatient,
                          )));
            },
            onPostsTap: () {
              // context.read<CommunityCubit>().getPosts();
            },
            onCartFromUserTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserCartsController(
                            patientModel: widget.patientModel,
                            isPatient: widget.isPatient,
                          )));
            },
          ),
        );
      },
    );
  }
}
