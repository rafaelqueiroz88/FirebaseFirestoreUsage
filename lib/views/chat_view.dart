import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
        backgroundColor: Colors.grey.shade700,
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert, color: Colors.yellow),
            items: [
              DropdownMenuItem(
                value: 'Logout',
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ],
                ),
              )
            ],
            onChanged: (identifier) {
              if (identifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
        ),
        child: Column(
          children: const [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
