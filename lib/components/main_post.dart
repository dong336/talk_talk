import 'package:flutter/material.dart';

class MainPost extends StatelessWidget {

  const MainPost({
    super.key,
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
        title: const Text(
          'Flutter 기본 화면 구성',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '카테고리: Flutter',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  '2024-12-14 09:07:55',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
            SizedBox(height: 4.0), // 간격 추가
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          print('게시물 클릭: Flutter 기본 화면 구성');
        },
      ),
    );
  }
}
