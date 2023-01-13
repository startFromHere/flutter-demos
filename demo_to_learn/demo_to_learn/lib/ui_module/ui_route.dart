import 'package:flutter/material.dart';

class UIRoute extends StatefulWidget {
  const UIRoute({super.key});

  @override
  State<UIRoute> createState() => _UIRouteState();
}

class _UIRouteState extends State<UIRoute> {
  @override
  Widget build(BuildContext context) {
    final widgetNames = [
      "renderObjectWidgets",
      "Flex",
      "WrapAndFlow",
      "StackAndPositioned",
      "Align",
      "LayoutBuilderAndAfterLayout",
    ];
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("widget 学习"),
      ),
      body: ListView.separated(
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(widgetNames[i]),
              onTap: () {
                Navigator.pushNamed(context, "/" + widgetNames[i]);
              },
            );
          },
          separatorBuilder: (context, i) {
            return const Divider(
              color: Colors.red,
            );
          },
          itemCount: widgetNames.length),
    );
  }
}
