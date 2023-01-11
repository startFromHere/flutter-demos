import 'package:flutter/material.dart';

class LessonsRoute extends StatefulWidget {
  const LessonsRoute({super.key});

  @override
  State<LessonsRoute> createState() => _LessonsRouteState();
}

class _LessonsRouteState extends State<LessonsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lessons'),
      ),
      body: Center(child: Text("课程列表")),
    );
  }
}
