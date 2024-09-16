import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../helpers/paths.dart';

class SearchSpecialistController extends StatefulWidget {
  final PatientModel? patientModel;
  const SearchSpecialistController({super.key, required this.patientModel});

  @override
  State<SearchSpecialistController> createState() =>
      _SearchSpecialistControllerState();
}

class _SearchSpecialistControllerState
    extends State<SearchSpecialistController> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ScheduleCubit>();
    if (context.read<ScheduleCubit>().state.specialists.isEmpty) {
      context.read<ScheduleCubit>().getSpecialists();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Buscar especialista"),
          ),
          body: SearchSpecialistScreen(
            patientModel: null,
            controller: controller,
            searchController: searchController,
            searchFunction: (value) {
              context.read<ScheduleCubit>().searchSpecialisInTime(value);
            },
            specislist: state.specialists,
            onTapSpecialist: (specialist) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SpecialistDetailScreen(
                    patientModel: widget.patientModel,
                    specialistModel: specialist,
                    syncByCode: (code) async {
                      final res = await context
                          .read<UserProvider>()
                          .syncByCode(widget.patientModel!.id, code);

                      return res;
                    },
                  ),
                ),
              );
            },
            onFilterTap: () {
              showFilterialog(context);
            },
            syncByCode: (code) async {
              final res = await context
                  .read<UserProvider>()
                  .syncByCode(widget.patientModel!.id, code);

              return res;
            },
          ),
        );
      },
    );
  }
}

void showFilterialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Filtrar especialistas"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Sexo: "),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: "Masculino",
                        child: Text("Masculino"),
                      ),
                      DropdownMenuItem(
                        value: "Femenino",
                        child: Text("Femenino"),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Especialidad: "),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: "Psicologo",
                        child: Text("Psicologo"),
                      ),
                      DropdownMenuItem(
                        value: "Psiquiatra",
                        child: Text("Psiquiatra"),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Filtrar"),
          ),
        ],
      );
    },
  );
}
