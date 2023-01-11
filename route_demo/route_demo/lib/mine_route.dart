import 'package:flutter/material.dart';

class MineRoute extends StatefulWidget {
  const MineRoute({super.key});

  @override
  State<MineRoute> createState() => _MineRouteState();
}

class _MineRouteState extends State<MineRoute> {
  @override
  Widget build(BuildContext context) {
    print("mine build了");
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Initial Route"),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("mine"),
      ),
      body: Column(
        children: [
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pop("dismissed");
          //   },
          //   child: Text("回到首页"),
          // ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/settings",
                  arguments: {"theme": "light", "language": "english"});
            },
            child: Text("进入设置页面"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.of(context).pop("dismissed");
    // });
  }
}
