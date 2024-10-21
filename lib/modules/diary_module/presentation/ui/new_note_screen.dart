import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/paths.dart';

class NewNoteScreen extends StatefulWidget {
  final int id;
  final PatientModel patientModel;
  final Function(NoteModel, int) onNoteCreated;
  final Function(bool) onVisible;
  const NewNoteScreen({
    super.key,
    required this.onNoteCreated,
    required this.id,
    required this.patientModel,
    required this.onVisible,
  });

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  EmotionModel? _selectedIcon;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    context.read<DailyCubit>().changeVisibility(
          widget.patientModel.settings!.diaryActivated,
        );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyCubit, DailyState>(
      listener: (context, state) {
        if (state.result == DailyResult.error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error al cargar las emociones'),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Nueva nota'),
              actions: [
                Switch(
                  activeColor: const Color(0xff2CB5E0),
                  value: state.visible,
                  thumbIcon: WidgetStateProperty.all(
                    Icon(
                      state.visible ? Icons.lock : Icons.lock_open,
                      color: state.visible ? Colors.black : Colors.white,
                    ),
                  ),

                  onChanged: (visible) {
                    widget.onVisible(visible);
                  },
                  //put an icon here
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Proteger nota'),
                          content: const Text(
                              'Cuando te vincules con una especialista, el/ella puede acceder a tu diario para ayudarte en tu progreso, sin embargo, con el seguro de nota activado, no podrá ver esta nota. Asi que si deseas que tu especialista no vea esta nota, activa el seguro de nota. La idea es que cuando tu especialista quiera que escribas algo sobre un tema, este pueda ver esa nota, pero no las demás.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Salir'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.info)),
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Título',
                            border: InputBorder.none, //no border
                          ),
                          //no border
                        ),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          showEmotionsDialog(
                            context: context,
                            onEmotionSelected: (icon) {
                              setState(() {
                                _selectedIcon = icon;
                              });
                            },
                          );
                        },
                        icon: _selectedIcon != null
                            ? Text(_selectedIcon!.icon!,
                                style: TextStyle(
                                    fontSize: 30,
                                    foreground: Paint()
                                      ..style = PaintingStyle.fill
                                      ..color =
                                          emotionColors[_selectedIcon!.name]!))
                            : const Icon(Icons.emoji_emotions_outlined),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: TextField(
                      controller: contentController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: 'Contenido',
                        border: InputBorder.none, //no border
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              elevation: 10,
              backgroundColor: titleController.text.isNotEmpty &&
                      contentController.text.isNotEmpty &&
                      _selectedIcon != null
                  ? const Color(0xff2CB5E0)
                  : Colors.grey,
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    contentController.text.isEmpty ||
                    _selectedIcon == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Por favor, completa todos los campos'),
                  ));
                  return;
                }

                if (_selectedIcon == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Por favor, selecciona una emoción'),
                  ));
                  return;
                }

                setState(() {
                  loading = true;
                });

                final note = NoteModel(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  content: contentController.text,
                  emotion: _selectedIcon!,
                  createdAt: DateTime.now(),
                  visible: state.visible,
                );

                await widget.onNoteCreated(note, widget.id);

                setState(() {
                  loading = false;
                });

                if (context.mounted) Navigator.pop(context);
              },
              child: loading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
            ));
      },
    );
  }
}

void showEmotionsDialog({
  required BuildContext context,
  required Function(EmotionModel) onEmotionSelected,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Selecciona una emoción',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: BlocBuilder<EmotionCubit, EmotionState>(
              bloc: context.read<EmotionCubit>(),
              builder: (context, state) {
                if (state.status == EmotionStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == EmotionStatus.loaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.emotions.length,
                    itemBuilder: (context, index) {
                      final emotion = state.emotions[index];
                      return InkWell(
                        onTap: () {
                          onEmotionSelected(emotion);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(emotion.icon!,
                                style: TextStyle(
                                    fontSize: 30,
                                    foreground: Paint()
                                      ..style = PaintingStyle.fill
                                      ..color = Colors.black)),
                            Text(emotion.name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Error al cargar las emociones'),
                  );
                }
              },
            )),
      );
    },
  );
}
