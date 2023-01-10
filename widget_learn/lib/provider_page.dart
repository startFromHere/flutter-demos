import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_learn/main.dart';

class Truck extends ChangeNotifier {
  final List<LTBox> _items = [];

  UnmodifiableListView<LTBox> get items => UnmodifiableListView(_items);
  int get totalPrice => _items.length * 42;

  void add(LTBox item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}

class LTBox {
  LTBox(this.price, this.height);

  double price;
  int height;
}

class ProviderTestPage extends StatelessWidget {
  const ProviderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Consumer<Bag>(builder: (context, truck, child) {
          return Stack(
            children: [
              if (child != null) child,
              Text("总价：${truck.totalPrice}"),
            ],
          );
        }),
        Consumer(builder: (context, truck, child) {
          return ElevatedButton(
              onPressed: () {
                Provider.of<Bag>(context, listen: false).removeAll();
              },
              child: Text("clear"));
        }),
        Consumer(builder: (context, truck, child) {
          return ElevatedButton(
              onPressed: () {
                Provider.of<Bag>(context, listen: false)
                    .add(Gem(Random().nextInt(20), 1));
              },
              child: Text("add"));
        })
      ]),
    );
  }
}
