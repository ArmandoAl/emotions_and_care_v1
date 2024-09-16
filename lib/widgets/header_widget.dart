import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isForReturn;
  final Widget? action;
  const HeaderWidget({
    Key? key,
    required this.title,
    required this.isForReturn,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //elevation: 1,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      title: Text(title),
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: isForReturn
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : IconButton(
                icon: Icon(Icons.menu,
                    color: const Color(0xff064ACB),
                    size: MediaQuery.of(context).size.width * 0.08),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
      ),
      actions: action != null
          ? [Padding(padding: const EdgeInsets.only(right: 10), child: action!)]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
