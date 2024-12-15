import 'package:flutter/material.dart';
import 'package:talk_talk/model/post_detail.dart';
import 'package:talk_talk/utils/html_editor_util.dart';

class PostDetailScreen extends StatefulWidget {
  final String id;

  const PostDetailScreen({super.key, required this.id});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late PostDetail postDetail;

  @override
  Widget build(BuildContext context) {
    return HtmlEditorUtil(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('톡톡 게시물'),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {

  }
}
