import 'package:flutter/material.dart';

class AnalyzeRoute extends StatefulWidget {
  const AnalyzeRoute({super.key});

  @override
  State<AnalyzeRoute> createState() => _AnalyzeRouteState();
}

class _AnalyzeRouteState extends State<AnalyzeRoute> {
  @override
  Widget build(BuildContext context) {
    const pages = [
      "InheritedWidget",
      "Provider",
      "ValueListenable",
      "AsyncBuilder"
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Expanded(
          child: ListView.builder(
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(pages[index]),
                onTap: () {
                  Navigator.pushNamed(context, "/" + pages[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
