import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final int timeStamp;
  final bool isMessageAuthor;
  const MessageBubble(this.message, this.isMessageAuthor, this.timeStamp,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    return isMessageAuthor
        ? Container(
            child: Card(
              color: Colors.grey,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 15.0,
                  right: 25.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Text(
                      '${time.hour}:${time.minute}',
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            child: Card(
              color: Colors.grey.shade800,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 15.0,
                  right: 25.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Text(
                      '${time.hour}:${time.minute}',
                      style: const TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
