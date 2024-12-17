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
    CustomTextField(),
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
      setState(() {
        imageFile = File(image.path);
        print(image.name);

        dynamicWidgets.add(
          CustomImageBox(imageFile: imageFile),
        );
        dynamicWidgets = removeEmptyTextFields(dynamicWidgets);
        dynamicWidgets.add(
          CustomTextField(),
        );
      });
    }
  }

  List<Widget> removeEmptyTextFields(List<Widget> dynamicWidgets) {
    dynamicWidgets = dynamicWidgets.where((widget) {
      if (widget is CustomTextField) {
        return widget.textEditingController?.text.isNotEmpty ?? false;
      }
      return true;
    }).toList();

    return dynamicWidgets;
  }

}
