import 'package:flutter/material.dart';

import 'package:talk_talk/utils/html_editor_util.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {

  @override
  Widget build(BuildContext context) {
    return HtmlEditorUtil(
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
    );
  }
}
