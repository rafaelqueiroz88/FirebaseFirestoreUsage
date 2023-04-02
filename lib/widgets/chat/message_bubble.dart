import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final int timeStamp;
  final bool isMessageAuthor;
  final String avatarUrl;
  const MessageBubble(
      this.message, this.isMessageAuthor, this.timeStamp, this.avatarUrl,
      {super.key});

  Widget buildMessageBody() {
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    double renderDynamicWidth() {
      if (message.length <= 30) {
        return message.length + 100;
      } else if (message.length > 30 && message.length <= 50) {
        return message.length + 200;
      } else if (message.length > 50) {
        return 300;
      }

      return 250;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMessageAuthor)
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.yellow,
            backgroundImage: NetworkImage(avatarUrl),
          ),
        if (isMessageAuthor)
          const SizedBox(
            width: 40,
          ),
        Container(
          width: isMessageAuthor ? 300 : renderDynamicWidth(),
          height: message.length + 70,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Card(
            color: isMessageAuthor ? Colors.grey : Colors.grey.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMessageAuthor ? 15 : 18),
                bottomRight: Radius.circular(isMessageAuthor ? 0 : 15),
                bottomLeft: Radius.circular(isMessageAuthor ? 15 : 0),
                topRight: Radius.circular(isMessageAuthor ? 8 : 15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 15.0,
                right: 25.0,
                bottom: 10,
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
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isMessageAuthor)
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.yellow,
            backgroundImage: NetworkImage(avatarUrl),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isMessageAuthor
        ? Stack(
            children: [
              buildMessageBody(),
            ],
          )
        // ? Container(
        //     width: 100,
        //     height: message.length + 30,
        //     decoration: const BoxDecoration(color: Colors.transparent),
        //     child: Card(
        //       color: Colors.grey,
        //       shape: const RoundedRectangleBorder(
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(15),
        //           bottomRight: Radius.circular(0),
        //           bottomLeft: Radius.circular(15),
        //           topRight: Radius.circular(18),
        //         ),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.only(
        //           top: 10.0,
        //           left: 15.0,
        //           right: 25.0,
        //           bottom: 10,
        //         ),
        //         child: Row(
        //           children: [
        //             Expanded(
        //               child: Text(
        //                 message,
        //                 style: const TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 17,
        //                 ),
        //               ),
        //             ),
        //             Text(
        //               '${time.hour}:${time.minute}',
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   )
        : Stack(
            children: [
              buildMessageBody(),
            ],
          );
  }
}
