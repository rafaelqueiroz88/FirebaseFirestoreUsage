import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../widgets/auth_form.dart';

const backgroundImage =
    'https://media.istockphoto.com/id/1284024960/pt/vetorial/smile-icon-pattern-happy-and-sad-faces-vector-abstract-background.jpg?s=1024x1024&w=is&k=20&c=D6wFWnaHwQtmaK7swu4hEHw6QzEM3EfkYsNPUIsTs5Y=';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    UserCredential userCredential;

    setState(() => _isLoading = true);

    try {
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            'username': username,
            'email': email,
          },
        );
      }
    } on FirebaseAuthException catch (err) {
      String message = 'An error occurred. Check your credentials';

      if (err.message != null) {
        message = err.message!;
      }

      setState(() => _isLoading = false);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (err) {
      setState(() => _isLoading = false);
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              backgroundImage,
            ),
          ),
        ),
        child: AuthFormWidget(
          _submitAuthForm,
          _isLoading,
        ),
      ),
    );
  }
}
