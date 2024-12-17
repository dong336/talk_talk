import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk_talk/components/custom_image_box.dart';
import 'package:talk_talk/components/custom_text_field.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  List<Widget> dynamicWidgets = [
    CustomTextField(isVisible: true, lineNumber: 1),
  ];
  List<TextEditingController> controllers = [];
  final ImagePicker _imagePicker = ImagePicker();
  File? imageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('톡톡 글쓰기'),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                print('등록 버튼 눌림');
              },
              child: const Text('등록'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            hintText: '제목',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: dynamicWidgets.map((item) => item).toList(),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _pickAndInsertImage();
        },
        child: const Icon(Icons.image),
      ),
    );
  }

  Future<void> _pickAndInsertImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageFile = File(image.path);
      setState(() {
        dynamicWidgets.add(
          CustomImageBox(imageFile: imageFile),
        );

        dynamicWidgets.add(
          CustomTextField(
            isVisible: true,
            lineNumber: dynamicWidgets.length + 1
          ),
        );
      });
    }
  }

  // void _removeEmptyTextFields() {
  //   for (int i = 0; i < dynamicWidgets.length; i++) {
  //     final Widget widget = dynamicWidgets[i];
  //
  //     if (widget is CustomTextField) {
  //       final controllerText = widget.textEditingController.text.trim();
  //       if (controllerText.isEmpty && i != dynamicWidgets.length - 1) {
  //         dynamicWidgets.removeAt(i);
  //       }
  //     }
  //   }
  // }
}
