import 'package:flutter/material.dart';

class WelcomeRoute extends StatefulWidget {
  const WelcomeRoute({super.key});

  @override
  State<WelcomeRoute> createState() => _WelcomeRouteState();
}

class _WelcomeRouteState extends State<WelcomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(30),
            child: Center(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text("欢迎来到flutter"),
                ),
              ),
            )),
      ),
    );
  }
}
