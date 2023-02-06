import 'dart:ffi';

import 'package:flutter/material.dart';

class DialogTestRoute extends StatefulWidget {
  const DialogTestRoute({super.key});

  @override
  State<DialogTestRoute> createState() => _DialogTestRouteState();
}

class _DialogTestRouteState extends State<DialogTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          TextButton(
              onPressed: () async {
                bool? delete = await showDeleteCOnfirmDialog1();
                if (delete == null) {
                  print("取消删除");
                } else {
                  print("已确认删除");
                }
              },
              child: Text("dialog1")),
        ]),
      ),
    );
  }

  Future<bool?> showDeleteCOnfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗？"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("取消1")),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("删除2")),
          ],
        );
      },
    );
  }

  Future<void> changeLanguage() async {
    int? i = await showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('请选择留言'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text("中文简体"),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('美国英语'),
              ),
            )
          ],
        );
      },
    );
  }
}
