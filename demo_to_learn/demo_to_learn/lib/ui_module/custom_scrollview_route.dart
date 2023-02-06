import 'package:flutter/material.dart';

class CustomScrollViewRoute extends StatelessWidget {
  const CustomScrollViewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildTwoListView(),
    );
  }

  // Widget buildTwoListView() {
  //   var listView = ListView.builder(
  //     itemCount: 20,
  //     itemBuilder: (_, index) => ListTile(title: Text('$index')),
  //   );

  //   return Column(
  //     children: [
  //       Expanded(child: listView),
  //       Divider(
  //         color: Colors.grey,
  //       ),
  //       Expanded(child: listView),
  //     ],
  //   );
  // }

  Widget buildTwoListView() {
    var listView = SliverFixedExtentList(
      itemExtent: 56,
      delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('$index')),
          childCount: 30),
    );

    return CustomScrollView(
      slivers: [listView, listView],
    );
  }
}
