import 'package:flutter/material.dart';
import 'package:route_demo/analyze_module/animation_test_route.dart';

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
      "AsyncBuilder",
      "Gesture",
      "Notification",
      "Animation",
      'Websocket'
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
                  if (pages[index] == "Animation") {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return FadeTransition(
                                opacity: animation,
                                child: AnimationTestRoute());
                          },
                        ));
                  } else {
                    Navigator.pushNamed(context, "/" + pages[index]);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
