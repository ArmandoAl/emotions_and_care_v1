import 'package:flutter/material.dart';

Widget containerItem(BuildContext context, Color color, String text,
    String subText, String trailingText, Function onTap,
    {bool hasHeader = false, IconData icon = Icons.arrow_forward_ios}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: hasHeader == false
            ? const BorderRadius.all(Radius.circular(10))
            : const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: hasHeader == true
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.015,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      trailingText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                Text(subText,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      decoration: TextDecoration.none,
                    )),
              ],
            ),
          ),
          Icon(
            icon,
            color: Colors.black,
            size: MediaQuery.of(context).size.width * 0.06,
          ),
        ],
      ),
    ),
  );
}
