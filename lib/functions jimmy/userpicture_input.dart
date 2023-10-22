import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const isWeb = kIsWeb; // Check if the platform is web

    return Column(
      children: [
        if (_image != null)
          isWeb
              ? Image.network(_image!.path, width: 250, height: 250) // Use Image.network for web
              : Image.file(_image!), // Use Image.file for mobile
        if (_image == null)
          Image.asset('assets/images/PetsCareLogo.png', width: 250, height: 250),
        ElevatedButton(
          onPressed: _getImage,
          child: const Text('Select Image'),
        ),
      ],
    );
  }
}
