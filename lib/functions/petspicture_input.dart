import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PetImagePickerWidget extends StatefulWidget {
  const PetImagePickerWidget({super.key});

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<PetImagePickerWidget> {
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
    return Column(
      children: [
        if (_image != null)
          Image.file(_image!), // On mobile, use Image.file
        if (_image == null)
          Image.asset('assets/images/PetsCareLogo.png', width: 250, height: 250),
        // On web, use Image.asset
       // ElevatedButton(
         // onPressed: _getImage,
        //  child: const Text('Select Image'),
      //  ),
      ],
    );
  }
}
