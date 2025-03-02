import '../../../../../helpers/paths.dart';

class SearchSpecialistScreen extends StatefulWidget {
  final PatientModel? patientModel;
  final TextEditingController controller;
  final TextEditingController searchController;
  final Function(String) searchFunction;
  final List<SpecialistModel> specislist;
  final Function(SpecialistModel) onTapSpecialist;
  final Function onFilterTap;
  final Future<bool> Function(String) syncByCode;
  final Future<bool> Function(String) syncDirectByCode;
  //syncDirectByCode
  const SearchSpecialistScreen(
      {super.key,
      required this.patientModel,
      required this.controller,
      required this.searchController,
      required this.specislist,
      required this.onTapSpecialist,
      required this.onFilterTap,
      required this.searchFunction,
      required this.syncByCode,
      required this.syncDirectByCode});

  @override
  State<SearchSpecialistScreen> createState() => _SearchSpecialistScreenState();
}

class _SearchSpecialistScreenState extends State<SearchSpecialistScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.searchController,
                    decoration: const InputDecoration(
                      //sin bordes
                      border: InputBorder.none,
                      hintText: "Buscar especialista",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      widget.searchFunction(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.onFilterTap();
                  },
                  icon: const Icon(Icons.filter_alt),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.specislist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  widget.onTapSpecialist(widget.specislist[index]);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: widget.patientModel!.specialist != null &&
                              widget.specislist[index].id ==
                                  widget.patientModel!.specialist!.id
                          ? Colors.grey
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.05,
                            child: const Icon(Icons.person)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.specislist[index].name!,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05)),
                              Text("Sexo: ${widget.specislist[index].sex}",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035)),
                              Text("Edad: ${widget.specislist[index].age} años",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035)),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: MediaQuery.of(context).size.width * 0.05),
                      ],
                    )),
              );
            },
          )),
          const Divider(),
          requestByCodeWidget(
              context, widget.controller, widget.syncByCode, isLoading, () {
            setState(() {
              isLoading = !isLoading;
            });
          }),
        ],
      ),
    );
  }
}

Widget requestByCodeWidget(
    BuildContext context,
    TextEditingController controller,
    Future<bool> Function(String) syncByCode,
    bool isLoading,
    Function changeLoadingState) {
  return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text("Vincular con codigo",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.013),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Codigo",
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          ElevatedButton(
            onPressed: () async {
              changeLoadingState();
              bool result = await syncByCode(controller.text);
              changeLoadingState();
              if (result == true && context.mounted) {
                showConfirmialog(
                    context,
                    result
                        ? "Vinculacion exitosa"
                        : "Hubo un error al vincular, por favor revisa el codigo e intenta de nuevo");
              }

              controller.clear();
            },
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text("Vincular",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.045)),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ],
      ));
}

void showConfirmialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Vinculacion"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
