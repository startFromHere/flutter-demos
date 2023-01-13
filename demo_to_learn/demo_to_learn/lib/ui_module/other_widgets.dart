import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class OtherWidgetsRoute extends StatefulWidget {
  const OtherWidgetsRoute({super.key});

  @override
  State<OtherWidgetsRoute> createState() => _OtherWidgetsRouteState();
}

class _OtherWidgetsRouteState extends State<OtherWidgetsRoute> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 2,
        crossAxisCount: 2,
        children: [MyTransformWidget1(), MyTransformWidget2()],
      ),
    );
  }
}

class MyTransformWidget1 extends StatelessWidget {
  const MyTransformWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0.3),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.deepOrange,
            child: Text(
              'Apartment for rent!',
            ),
          ),
        ),
      ),
    );
  }
}

class MyTransformWidget2 extends StatelessWidget {
  const MyTransformWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.translate(
          offset: Offset(-20.0, -5.0),
          child: Text("Hello world"),
        ),
      ),
    );
  }
}

class MyTransformWidget3 extends StatelessWidget {
  const MyTransformWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Text("Hello world"),
        ),
      ),
    );
  }
}
