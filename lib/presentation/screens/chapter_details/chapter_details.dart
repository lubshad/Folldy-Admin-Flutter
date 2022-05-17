import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';

class ChapterDetails extends StatelessWidget {
  const ChapterDetails({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(chapter.name)),
      body: ListView.builder(
          itemBuilder: ((context, index) => const ListTile(
                title: Text("data"),
              ))),
    );
  }
}
