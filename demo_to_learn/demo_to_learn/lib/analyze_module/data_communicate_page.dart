import 'package:flutter/material.dart';

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  final int data;

  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}

class DataSharePage extends StatefulWidget {
  const DataSharePage({super.key});

  @override
  State<DataSharePage> createState() => _DataSharePageState();
}

class _DataSharePageState extends State<DataSharePage> {
  int count = 0;
  int count2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data share test'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                setState(() {
                  count2 += 1;
                });
                print("修改 count2");
              },
              child: Text("count2: ${count2}")),
          TextButton(
              onPressed: () {
                setState(() {
                  count += 2;
                });
                print("通过 inherit widget 修改 count");
              },
              child: Text("通过 inherit widget 修改 count")),
          ShareDataWidget(data: count, child: _TestWidget()),
        ],
      ),
    );
  }
}

// class DataSharePage extends StatefulWidget {
//   const DataSharePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('data share test'),
//       ),
//       body: ShareDataWidget(data: 0, child: _TestWidget()),
//     );
//   }
// }

class _TestWidget extends StatefulWidget {
  const _TestWidget({super.key});

  @override
  State<_TestWidget> createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(ShareDataWidget.of(context)!.data.toString()),
        TextButton(
            onPressed: () {
              print("点击了button");
            },
            child: Text("通过子 widget 修改父 widget 的数据")),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependencies change");
  }
}
