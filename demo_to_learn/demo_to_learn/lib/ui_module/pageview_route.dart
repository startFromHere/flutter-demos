import 'package:flutter/material.dart';

class PageViewRoute extends StatelessWidget {
  const PageViewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("pageView")),
      body: PageView(
        scrollDirection: Axis.horizontal,
        reverse: false,
        pageSnapping: true,
        allowImplicitScrolling: true,
        children: [
          Page(text: "1"),
          Page(text: "2"),
          Page(text: "3"),
          Page(text: "4"),
          Page(text: "5"),
        ],
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return Center(
        child: Text(
      "${widget.text}",
      textScaleFactor: 5,
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
