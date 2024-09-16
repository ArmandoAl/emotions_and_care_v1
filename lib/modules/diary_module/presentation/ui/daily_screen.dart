import '../../../../helpers/paths.dart';

class DailyScreen extends StatefulWidget {
  static const String route = 'daily';
  final List<NoteModel> notes;
  final void Function(NoteModel note) onNoteTap;
  final void Function(NoteModel note) onLongTap;
  final Future<void> Function() reload;
  const DailyScreen(
      {super.key,
      required this.notes,
      required this.onNoteTap,
      required this.onLongTap,
      required this.reload});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.reload();
        },
        child: ListView.builder(
          itemCount: widget.notes.length,
          itemBuilder: (context, index) {
            final item = widget.notes[index];
            return GestureDetector(
              onTap: () {
                widget.onNoteTap(item);
              },
              onLongPress: () {
                _showRemoveNoteDialog(context, item, (note) {
                  widget.onLongTap(note);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: emotionColors[item.emotion.name]!.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(item.emotion.icon!,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(item.content,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showRemoveNoteDialog(
    BuildContext context, NoteModel note, Function(NoteModel note) onRemove) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminar nota'),
        content: const Text('¿Estás seguro de que quieres eliminar esta nota?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              onRemove(note);
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );
}
