import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;

  // 이미지 선택 및 반환
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Uint8List 형식으로 읽기
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("이미지 선택")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 이미지 미리보기
            _imageBytes != null
                ? Image.memory(
              _imageBytes!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            )
                : Text("이미지가 선택되지 않았습니다."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _pickImage();
                if (_imageBytes != null) {
                  Navigator.pop(context, _imageBytes); // 이미지 데이터를 반환
                }
              },
              child: Text("이미지 선택"),
            ),
          ],
        ),
      ),
    );
  }
}
