import 'package:flutter/material.dart';

class UserMessageWidget extends StatelessWidget {
  final String message;
  final String time;

  const UserMessageWidget({Key? key, required this.message, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                margin: const EdgeInsets.fromLTRB(20, 20, 40, 0),
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),

                //width: min(a, b),
                child: Text(message),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                alignment: Alignment.topLeft,
                child: Text(time),
              )
            ],
          ),
        ),
      ],
    );
  }
}
