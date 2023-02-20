import 'package:flutter/material.dart';

class LocalizeTestRoute extends StatelessWidget {
  const LocalizeTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [Text("1"), Text("2"), Text("3")],
        ),
      ),
    );
  }
}
