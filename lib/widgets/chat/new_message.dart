import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userId = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _message,
        'createdAt': Timestamp.now(),
        'userId': userId.uid,
        'userAvatarPath': userData['userAvatarPath'],
        'username': userData['username'],
      },
    );

    _message = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Say something',
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              cursorColor: Colors.yellow,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {
                setState(() => _message = value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: _message.trim().isEmpty ? null : () => _sendMessage(),
          ),
        ],
      ),
    );
  }
}
