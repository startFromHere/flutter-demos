import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bag extends ChangeNotifier {
  final List<Gem> _items = [];

  UnmodifiableListView<Gem> get items => UnmodifiableListView(_items);
  int get totalPrice =>
      _items.fold(0, (previousValue, element) => previousValue + element.price);

  void add(Gem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}

class Gem {
  Gem(this.price, this.height);

  int price;
  int height;
}

class ProviderTestPage extends StatelessWidget {
  const ProviderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Column(children: [
    //     Consumer<Bag>(builder: (context, truck, child) {
    //       return Stack(
    //         children: [
    //           if (child != null) child,
    //           Text("总价：${truck.totalPrice}"),
    //         ],
    //       );
    //     }),
    //     Consumer(builder: (context, truck, child) {
    //       return ElevatedButton(
    //           onPressed: () {
    //             Provider.of<Bag>(context, listen: false).removeAll();
    //           },
    //           child: Text("clear"));
    //     }),
    //     Consumer(builder: (context, truck, child) {
    //       return ElevatedButton(
    //           onPressed: () {
    //             Provider.of<Bag>(context, listen: false)
    //                 .add(Gem(Random().nextInt(20), 1));
    //           },
    //           child: Text("add"));
    //     })
    //   ]),
    // );

    return ChangeNotifierProvider(
      create: (context) => Bag(),
      child: Scaffold(
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
      ),
    );
  }
}
