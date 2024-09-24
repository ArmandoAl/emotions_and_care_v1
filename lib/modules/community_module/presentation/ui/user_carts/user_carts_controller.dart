import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../helpers/paths.dart';

class UserCartsController extends StatefulWidget {
  final PatientModel? patientModel;
  final SpecialistModel? specialistModel;
  final bool isPatient;
  const UserCartsController(
      {super.key,
      this.patientModel,
      this.specialistModel,
      required this.isPatient});

  @override
  State<UserCartsController> createState() => _UserCartsControllerState();
}

class _UserCartsControllerState extends State<UserCartsController> {
  int index = 0;

  void updateIndex(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  void initState() {
    context.read<CommunityCubit>().getCartFromUser(
        widget.isPatient
            ? widget.patientModel!.id!
            : widget.specialistModel!.id!,
        widget.isPatient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == CommunityStatus.loading) {
          return const Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final userId = widget.isPatient
            ? widget.patientModel!.id
            : widget.specialistModel!.id;
        //cartas en las que el usuario es el autor
        final sentCarts = state.cartFromUser
            .where((element) =>
                element.respuestas!.isNotEmpty &&
                element.respuestas!
                    .any((element) => element.idReceptor == userId))
            .toList();
        //cambiar, se tiene que agregar en el CartaModel un idReceptor para poder hacer la comparacion
        final recievedCarts = state.cartFromUser
            .where((element) => element.idEmisor == userId)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: UserCartsScreen(
            carts: index == 1 ? sentCarts : recievedCarts,
            index: index,
            updateIndex: updateIndex,
            userId: userId!,
          ),
        );
      },
    );
  }
}
