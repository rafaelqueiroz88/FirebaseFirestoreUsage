import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickingFunction;

  const UserImagePicker(this.imagePickingFunction, {super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _imagePicture;
  final ImagePicker _picker = ImagePicker();

  void _openImagePicker() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
      maxHeight: 150,
    );

    if (image != null) {
      setState(() => _imagePicture = File(image.path));

      widget.imagePickingFunction(_imagePicture!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.yellow,
          backgroundImage: _imagePicture == null
              ? null
              : FileImage(File(_imagePicture!.path)),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () => _openImagePicker(),
          icon: const Icon(Icons.image),
          label: const Text('Take a Pic!'),
        ),
      ],
    );
  }
}
