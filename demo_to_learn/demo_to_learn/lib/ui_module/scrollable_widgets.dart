import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ScrollableWidgetRoute extends StatelessWidget {
  const ScrollableWidgetRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return InfiniteListView();
  }
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];
  ScrollController scrollController = ScrollController();
  bool _showToTopBtn = false;
  String _progress = "0%";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      print(scrollController.offset);
      if (scrollController.offset < 1000 && _showToTopBtn) {
        setState(() {
          _showToTopBtn = false;
        });
      } else if (scrollController.offset >= 1000 && _showToTopBtn == false) {
        setState(() {
          _showToTopBtn = true;
        });
      }
    });
  }

  void _retrieveData() {
    Future.delayed(Duration(milliseconds: 20)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(1).map((e) => e.asPascalCase).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        double progress =
            notification.metrics.pixels / notification.metrics.maxScrollExtent;
        progress = min(max(progress, 0), 1);
        setState(() {
          _progress = "${(progress * 100).toInt()}%";
        });
        return true;
      },
      child: Stack(
        children: [
          ListView.separated(
            controller: scrollController,
            itemCount: _words.length,
            itemBuilder: (context, index) {
              if (_words[index] == loadingTag) {
                if (_words.length - 1 < 50) {
                  _retrieveData();
                  if (index == 0) {
                    return ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("MyPageViewRoute");
                        },
                        child: Text("go PageView"));
                    Navigator.of(context).pushNamed("MyPageViewRoute");
                  } else if (index == 1) {
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    );
                  }
                } else {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "没有更多了",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              }
              return ListTile(title: Text(_words[index]));
            },
            separatorBuilder: (context, index) => Divider(
              height: .0,
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 30,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            ),
          ),
          Builder(builder: (context) {
            return Positioned(
              bottom: 20,
              right: 20,
              child: Visibility(
                visible: _showToTopBtn,
                child: ElevatedButton(
                    onPressed: () {
                      scrollController.animateTo(.0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    child: Text("回到顶部")),
              ),
            );
          })
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }
}
