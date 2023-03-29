import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.yellow,
                    // style: const TextStyle(color: Colors.yellow),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text('Username'),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Not registered? Touch to Signup'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
