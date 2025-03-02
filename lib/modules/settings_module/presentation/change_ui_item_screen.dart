import 'package:flutter_svg/svg.dart';
import '../../../helpers/paths.dart';

class ChangeUiItemScreen extends StatefulWidget {
  final BegginCubit userProvider;
  final UICubit uiProvider;
  final ItemUiType itemType;
  final List<dynamic> items;
  final List<bool> blocks;
  const ChangeUiItemScreen(
      {super.key,
      required this.userProvider,
      required this.uiProvider,
      required this.itemType,
      required this.items,
      required this.blocks});

  @override
  State<ChangeUiItemScreen> createState() => _ChangeUiItemScreenState();
}

class _ChangeUiItemScreenState extends State<ChangeUiItemScreen> {
  dynamic selectedItem;
  int selectedTheme = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personalización'),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                widget.itemType == ItemUiType.colores
                    ? 'Selecciona una paleta de colores para tu aplicación'
                    : widget.itemType == ItemUiType.fondo
                        ? 'Selecciona un fondo de pantalla para tu jardín'
                        : widget.itemType == ItemUiType.jardin
                            ? 'Jardín'
                            : 'Flores',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: widget.itemType == ItemUiType.colores
                    ? ListView.builder(
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              // if (widget.blocks[index]) {
                              //   showDialogForAds(context);
                              //   return;
                              // }
                              setState(() {
                                selectedItem = widget.items[index];
                                selectedTheme = index;
                              });
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedItem == widget.items[index]
                                        ? const Color(0xFFD80DB6)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: selectedItem == widget.items[index]
                                          ? const Color(0xFFD80DB6)
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      color: widget.items[index].primaryColor,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      color: widget
                                          .items[index].colorScheme.primary,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      color: widget
                                          .items[index].colorScheme.secondary,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      color: widget
                                          .items[index].colorScheme.surface,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      color: widget
                                          .items[index].colorScheme.background,
                                    ),
                                  ],
                                )),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: widget.items.length + 1,
                        itemBuilder: (context, index) {
                          if (index == widget.items.length) {
                            return Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedItem = "null";
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: selectedItem == "null"
                                            ? WidgetStateProperty.all(
                                                const Color(0xFFD80DB6))
                                            : WidgetStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 27, 135, 198)),
                                      ),
                                      child: const Text('Color por defecto',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.3),
                              ],
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedItem = widget.items[index];
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.65,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedItem == widget.items[index]
                                      ? const Color(0xFFD80DB6)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: selectedItem == widget.items[index]
                                        ? const Color(0xFFD80DB6)
                                            .withOpacity(0.5)
                                        : Colors.transparent,
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                widget.items[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: selectedItem != null
            ? FloatingActionButton(
                onPressed: () {
                  if (widget.itemType == ItemUiType.colores) {
                    widget.uiProvider.setTheme(selectedTheme);
                    Navigator.pop(context);
                  } else if (widget.itemType == ItemUiType.fondo) {
                    widget.uiProvider.setSelectedBackground(selectedItem);
                    Navigator.pop(context);
                  } else if (widget.itemType == ItemUiType.jardin) {
                    //  widget.uiProvider.changeGarden(selectedItem);
                  } else {
                    // widget.uiProvider.changeFlower(selectedItem);
                  }
                },
                child: const Icon(Icons.check),
              )
            : null);
  }
}

Future<void> showDialogForAds(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(''),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
