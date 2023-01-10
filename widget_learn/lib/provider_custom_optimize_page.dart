import 'dart:collection';

import 'package:flutter/material.dart';

class Consumer<T> extends StatelessWidget {
  const Consumer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      OptimizedChangeNotifierProvider.of<T>(context),
    );
  }
}

class OptimizedInheritedProvider<T> extends InheritedWidget {
  OptimizedInheritedProvider({
    required this.data,
    required Widget child,
  }) : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(OptimizedInheritedProvider<T> old) {
    return true;
  }
}

class OptimizedChangeNotifierProvider<T extends ChangeNotifier>
    extends StatefulWidget {
  OptimizedChangeNotifierProvider({
    Key? key,
    required this.data,
    required this.child,
  });

  final Widget child;
  final T data;

  static T? of<T>(BuildContext context, {bool listen = true}) {
    // final type = _typeof<InheritedProvider<T>>();
    final provider = listen
        ? context
            .dependOnInheritedWidgetOfExactType<OptimizedInheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<
                OptimizedInheritedProvider<T>>()
            ?.widget as OptimizedInheritedProvider<T>;
    return provider?.data;
  }

  @override
  _OptimizedChangeNotifierProviderState<T> createState() =>
      _OptimizedChangeNotifierProviderState<T>();
}

class _OptimizedChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<OptimizedChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(OptimizedChangeNotifierProvider<T> oldWidget) {
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
    return OptimizedInheritedProvider<T>(
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

class OptimizedCartModel extends ChangeNotifier {
  final List<Item> _items = [];

  // UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class OptimizedProviderRoute extends StatefulWidget {
  const OptimizedProviderRoute({super.key});

  @override
  State<OptimizedProviderRoute> createState() => _OptimizedProviderRouteState();
}

class _OptimizedProviderRouteState extends State<OptimizedProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      appBar: AppBar(),
      body: Center(
        child: OptimizedChangeNotifierProvider(
            data: OptimizedCartModel(),
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Builder(builder: (context) {
                  //   var cart = ChangeNotifierProvider.of<CartModel>(context);
                  //   return Text("总价：${cart?.totalPrice ?? 0}");
                  // }),
                  Consumer<OptimizedCartModel>(
                      builder: (context, cart) =>
                          Text("总价: ${cart!.totalPrice}")),
                  Builder(builder: (context) {
                    print("ElevateButton build");
                    return ElevatedButton(
                        child: Text("添加商品"),
                        onPressed: () {
                          OptimizedCartModel? cardModel =
                              OptimizedChangeNotifierProvider.of<
                                  OptimizedCartModel>(context, listen: false);
                          if (cardModel != null) {
                            cardModel.add(Item(20.0, 1));
                          }
                        });
                  }),
                ],
              );
            })),
      ),
    );
  }
}
