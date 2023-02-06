import 'package:flutter/material.dart';

class ValueListenableRoute extends StatefulWidget {
  const ValueListenableRoute({Key? key}) : super(key: key);

  @override
  State<ValueListenableRoute> createState() => _ValueListenableState();
}

class _ValueListenableState extends State<ValueListenableRoute> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ValueListenableBuilder<int>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                child!,
                Text(
                  '$value 次',
                  textScaleFactor: 1.5,
                )
              ],
            );
          },
          valueListenable: _counter,
          child: const Text(
            "点击了",
            textScaleFactor: 1.5,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.value += 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}
