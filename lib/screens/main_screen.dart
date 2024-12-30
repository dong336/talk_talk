import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:talk_talk/utils/constants.dart' as constants;
import 'package:talk_talk/widgets/main_drawer.dart';
import 'package:talk_talk/widgets/main_post.dart';
import 'package:talk_talk/model/post_simple.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<PostSimple> postList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('톡톡 소통해요'),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/write');
              },
              icon: const Icon(Icons.create),
            ),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  color: Colors.pinkAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: '제목/카테고리/내용/작성자',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      final postSimple = postList[index];
                      return MainPost(postSimple: postSimple);
                    },
                  ),
                ),
              ],
            ),
      drawer: const MainDrawer(),
    );
  }

  Future<void> _fetchData() async {
    var url = Uri.parse('${constants.url}/post/list/all');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonData = convert.jsonDecode(response.body);
      postList = jsonData.map((data) => PostSimple.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
