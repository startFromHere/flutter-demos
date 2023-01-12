
import 'package:flutter/material.dart';

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
      body: Center(
          child: Column(
        children: [
          Text("study"),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/keyTest");
              },
              child: Text("测试"))
        ],
      )),
    );
  }
}
