import 'package:flutter/material.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

class AsyncBuilderRoute extends StatelessWidget {
  const AsyncBuilderRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // child: FutureBuilder<String>(
        //   future: mockNetworkData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasError) {
        //         return Text("Error: ${snapshot.error}");
        //       } else {
        //         return Text("Contents: ${snapshot.data}");
        //       }
        //     } else {
        //       return CircularProgressIndicator();
        //     }
        //   },
        // ),
        child: StreamBuilder<int>(
          stream: counter(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('没有stream');
              case ConnectionState.waiting:
                return Text("等待数据");
              case ConnectionState.active:
                return Text('active: ${snapshot.data}');
              case ConnectionState.done:
                return Text('Stream 已关闭');
            }
          },
        ),
      ),
    );
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}
