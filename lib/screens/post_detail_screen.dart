import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('톡톡 게시물'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    'This is a Title This is a Title This is a Title This is a Title',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],

              ),
            ),
            const Divider(
              color: Colors.grey, // 구분선 색상
              thickness: 1.0,     // 두께
              indent: 10.0,       // 시작 위치 여백
              endIndent: 10.0,    // 끝 위치 여백
            ),
          ],
        ),
      ),
    );
  }
}
