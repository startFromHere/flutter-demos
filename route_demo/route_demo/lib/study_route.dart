import 'package:flutter/material.dart';

class StudyRoute extends StatefulWidget {
  const StudyRoute({super.key});

  @override
  State<StudyRoute> createState() => _StudyRouteState();
}

class _StudyRouteState extends State<StudyRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("study"),
      ),
    );
  }
}
