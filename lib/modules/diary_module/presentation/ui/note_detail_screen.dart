import '../../../../helpers/paths.dart';

class NoteDetailScreen extends StatelessWidget {
  final NoteModel note;
  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: emotionColors[note.emotion.name]!.withOpacity(0.1),
        title: Text(
            'Fecha: ${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: emotionColors[note.emotion.name]!.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(note.emotion.icon!,
                    style: const TextStyle(
                      fontSize: 30,
                    )),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                note.content,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                Text("Visible para especialista: ${note.visible ? 'Sí' : 'No'}")
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
