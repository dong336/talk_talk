import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk_talk/widgets/custom_image_box.dart';
import 'package:talk_talk/widgets/custom_text_field.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  TextEditingController titleController = TextEditingController();
  List<Map<String, dynamic>> contents = [];

  List<Widget> dynamicWidgets = [
    CustomTextField(
        isVisible: true,
        lineNumber: 1,
        textEditingController: TextEditingController()),
  ];
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
                _fetchCreatePost();
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
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

        // 비어있는 인풋은 자동삭제
        dynamicWidgets = dynamicWidgets
            .where((widget) =>
                widget is CustomImageBox ||
                widget is CustomTextField &&
                    widget.textEditingController.text.isNotEmpty)
            .toList();

        dynamicWidgets.add(
          CustomTextField(
            isVisible: true,
            lineNumber: dynamicWidgets.length + 1,
            textEditingController: TextEditingController(),
          ),
        );
      });
    }
  }

  Future<void> _fetchCreatePost() async {
    final url = Uri.parse('https://localhost:8080/test');
    final Map<String, dynamic> data = {
      'title': titleController.value,
      'contents': dynamicWidgets,
    };

    try {
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print('post error');
    }
  }
}
