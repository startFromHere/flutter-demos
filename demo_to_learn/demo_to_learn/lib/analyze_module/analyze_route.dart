import 'package:flutter/material.dart';

class AnalyzeRoute extends StatefulWidget {
  const AnalyzeRoute({super.key});

  @override
  State<AnalyzeRoute> createState() => _AnalyzeRouteState();
}

class _AnalyzeRouteState extends State<AnalyzeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("analyze"),
      ),
    );
  }
}
