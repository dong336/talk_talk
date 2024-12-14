import 'package:flutter/material.dart';

import 'package:talk_talk/components/main_post.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('톡톡 소통해요'),
          ],
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          // 검색 영역
          Container(
            color: Colors.pinkAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '제목/카테고리/내용/작성자',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MainPost(),
                MainPost(),
                MainPost(),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: AppBar().preferredSize.height,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                ),
                child: null,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0), // 간격
              child: ListTile(
                title: Text('Option 1'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle Option 1 Click
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0), // 간격
              child: ListTile(
                title: Text('Option 2'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle Option 1 Click
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0), // 간격
              child: ListTile(
                title: Text('Option 3'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle Option 1 Click
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
