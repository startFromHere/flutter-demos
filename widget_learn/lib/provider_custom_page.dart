import 'dart:collection';

import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({
    required this.data,
    required Widget child,
  }) : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    return true;
  }
}

class CustomChangeNotifierProvider<T extends ChangeNotifier>
    extends StatefulWidget {
  CustomChangeNotifierProvider({
    Key? key,
    required this.data,
    required this.child,
  });

  final Widget child;
  final T data;

  static T? of<T>(BuildContext context) {
    // final type = _typeof<InheritedProvider<T>>();
    final provider =
        context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider?.data;
  }

  @override
  _CustomChangeNotifierProviderState<T> createState() =>
      _CustomChangeNotifierProviderState<T>();
}

class _CustomChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<CustomChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(CustomChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

class Item {
  Item(this.price, this.count);

  double price;
  int count;
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  // UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  const ProviderRoute({super.key});

  @override
  State<ProviderRoute> createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      appBar: AppBar(),
      body: Center(
        child: CustomChangeNotifierProvider(
          data: CartModel(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Builder(builder: (context) {
                var cart = CustomChangeNotifierProvider.of<CartModel>(context);
                return Text("总价：${cart?.totalPrice ?? 0}");
              }),
              Builder(builder: (context) {
                print("ElevateButton build");
                return ElevatedButton(
                    child: Text("添加商品"),
                    onPressed: () {
                      CartModel? cardModel =
                          CustomChangeNotifierProvider.of<CartModel>(context);
                      if (cardModel != null) {
                        cardModel.add(Item(20.0, 1));
                      }
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
