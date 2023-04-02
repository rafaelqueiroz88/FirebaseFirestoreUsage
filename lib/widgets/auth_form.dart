import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_resources/widgets/pickers/user_image_picker.dart';

class AuthFormWidget extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitForm;
  final bool isLoading;

  const AuthFormWidget(this.submitForm, this.isLoading, {super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _username = '';
  String _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit(BuildContext ctx) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an Image to Proceed'),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitForm(
        _userEmail.trim(),
        _userPassword.trim(),
        _username.trim(),
        _userImageFile!,
        _isLogin,
        ctx,
      );
    }
  }

  Widget buildSizedHeightBox(double? height) {
    return SizedBox(
      height: height,
    );
  }

  Widget buildTextInput(String keyValue, String textLabel) {
    return TextFormField(
      key: ValueKey(keyValue),
      obscureText: keyValue == 'password' ? true : false,
      validator: (value) {
        if (keyValue == 'username') {
          if (value == null || (value.isEmpty || value.length < 3)) {
            return 'Username must have 4 characters or more';
          }
        } else if (keyValue == 'email') {
          if (value == null || (value.isEmpty || !value.contains('@'))) {
            return 'E-mail must be a valid one';
          }
        } else if (keyValue == 'password') {
          if (value == null || (value.isEmpty || value.length < 3)) {
            return 'Password must have at least 4';
          }
        }

        return null;
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        label: Text(textLabel),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      onSaved: (value) {
        if (keyValue == 'username') {
          _username = value!;
        } else if (keyValue == 'email') {
          _userEmail = value!;
        } else if (keyValue == 'password') {
          _userPassword = value!;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  buildSizedHeightBox(10),
                  const Text(
                    'Identify Yourself',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  buildSizedHeightBox(10),
                  if (!_isLogin) buildTextInput('username', 'Username'),
                  buildTextInput('email', 'E-mail'),
                  buildTextInput('password', 'Password'),
                  buildSizedHeightBox(20),
                  if (widget.isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.yellow),
                    ),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: () => _trySubmit(context),
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  buildSizedHeightBox(5),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() => _isLogin = !_isLogin);
                      },
                      child: Text(
                        _isLogin
                            ? 'Not registered? Touch to Signup'
                            : 'Already have an account? Touch to Login',
                      ),
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
