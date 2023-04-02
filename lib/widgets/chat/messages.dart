import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    bool isAuthor(String receivedId) {
      if (receivedId == userId) {
        return true;
      } else {
        return false;
      }
    }

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, messageSnapshot) {
        if (messageSnapshot.connectionState == ConnectionState.waiting ||
            messageSnapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        final documents = messageSnapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, index) => Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: MessageBubble(
                documents[index]['text'],
                isAuthor(documents[index]['userId']),
                documents[index]['createdAt'].seconds,
                documents[index]['userAvatarPath'],
                key: ValueKey(documents[index].id),
              ),
            ),
          ),
        );
      },
    );
  }
}
