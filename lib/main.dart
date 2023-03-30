import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';
import './views/auth_view.dart';
import './views/chat_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      // home: const AuthView(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return const ChatView();
          }

          return const AuthView();
        },
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow,
        primarySwatch: Colors.grey,
        cardTheme: CardTheme(
          color: Colors.grey.shade700,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            enableFeedback: true,
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
            foregroundColor: MaterialStateProperty.all(Colors.yellow),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.yellow),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
