import 'package:flutter/material.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({super.key});

  @override
  State<SettingsRoute> createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  @override
  Widget build(BuildContext context) {
    Map? args = ModalRoute.of(context)?.settings.arguments as Map?;
    return Scaffold(
      appBar: AppBar(
        title: Text("settings"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text("语言"),
                Spacer(),
                Text(args?['language'] ?? "中文"),
              ],
            ),
            Divider(
              height: 5,
            ),
            Row(
              children: [
                Text("主题"),
                Spacer(),
                Text(args?['theme'] ?? "白天"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
