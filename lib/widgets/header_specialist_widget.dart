import '../helpers/paths.dart';

class HeaderSpecialistWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final bool isForReturn;
  final Widget? action;
  final BuildContext context;
  const HeaderSpecialistWidget({
    super.key,
    required this.title,
    required this.isForReturn,
    this.action,
    required this.context,
  });

  @override
  State<HeaderSpecialistWidget> createState() => _HeaderSpecialistWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(
        MediaQuery.of(context).size.height * 0.1,
      );
}

class _HeaderSpecialistWidgetState extends State<HeaderSpecialistWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              widget.isForReturn
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : const SizedBox(),
              const Spacer(),
              widget.action ?? const SizedBox(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
            ],
          ),
          Text(widget.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
    );
  }
}
