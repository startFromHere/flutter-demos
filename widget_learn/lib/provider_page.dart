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

class ChangeNotifierProvider<T extents ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key? key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  static T of<T>(BuildContext context) {
    // final type = _typeof<InheritedProvider<T>>();
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }
}

