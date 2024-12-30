import 'package:flutter/material.dart';
import 'package:talk_talk/model/post_simple.dart';

class MainPost extends StatelessWidget {
  final PostSimple postSimple;

  const MainPost({
    super.key,
    required this.postSimple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        title: Text(
          postSimple.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '카테고리: ${postSimple.category}',
                  style: const TextStyle(fontSize: 14.0),
                ),
                Text(
                  postSimple.createdAt,
                  style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
            const SizedBox(height: 4.0), // 간격 추가
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/post/detail',
            arguments: {
              'postId': postSimple.id,
            },
          );
        },
      ),
    );
  }
}
