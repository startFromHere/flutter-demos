// import 'dart:ffi';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DartLenrnRoute extends StatefulWidget {
  const DartLenrnRoute({super.key});

  @override
  State<DartLenrnRoute> createState() => _DartLenrnRouteState();
}

class _DartLenrnRouteState extends State<DartLenrnRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemExtent: 100,
            itemBuilder: (context, idx) {
              if (idx < 10) {
                return MyColumnText(text: idx.toString());
              }
            }));
    // body: SingleChildScrollView(
    //   child: Builder(
    //     builder: (context) {
    //       List<Widget> items = [];
    //       for (int i = 0; i < 20; i++) {
    //         items.add(MyColumnText(text: i.toString()));
    //       }
    //       return Column(children: items);
    //     },
    //   ),
    // ));
  }
}

class MyColumnText extends StatelessWidget {
  const MyColumnText({super.key, this.text = ""});
  final String text;

  @override
  Widget build(BuildContext context) {
    if (text == "9") {
      print("Aha");
    }
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: Text(text),
    );
  }
}
