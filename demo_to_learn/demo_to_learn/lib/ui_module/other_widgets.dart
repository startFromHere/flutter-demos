// import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OtherWidgetsRoute extends StatefulWidget {
  const OtherWidgetsRoute({super.key});

  @override
  State<OtherWidgetsRoute> createState() => _OtherWidgetsRouteState();
}

class _OtherWidgetsRouteState extends State<OtherWidgetsRoute>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      // return SingleChildScrollView(
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 2,
            crossAxisCount: 2,
            children: [
              MyTransformWidget1(),
              MyTransformWidget2(),
              MyTransformWidget3(),
              MyTransformWidget4(),
              MyRotateBox(),
              MyContainer(),
              MyClipWidget()
            ],
          ),
          MyRow(text: " 00000000000000000 "),
          MyFittedRow(text: " 00000000000000000 "),
          MyRow(text: " 111 "),
          MyFittedRow(text: " 111 "),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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

class MyTransformWidget4 extends StatelessWidget {
  const MyTransformWidget4({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.scale(
          scale: 1.5,
          child: Text("hello world"),
        ),
      ),
    );
  }
}

class MyRotateBox extends StatelessWidget {
  const MyRotateBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text("hello world"),
            ),
          ),
          Text("dart")
        ],
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        transform: Matrix4.rotationZ(0.5),
        width: 100,
        height: 100,
        alignment: Alignment.center,
        // color: Color(Gradient.linear(
        //     Point(0, 0), Point(1, 1), [Colors.red, Colors.yellow])),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red, Colors.yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(2, 2), blurRadius: 4)
            ]),
        child: Text("5.20"),
      ),
    );
  }
}

class MyClipWidget extends StatelessWidget {
  const MyClipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
            width: 40,
            height: 40,
            color: Colors.orange,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            width: 20,
            height: 20,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}

class MyRow extends StatelessWidget {
  const MyRow({super.key, this.text = "--"});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text(this.text), Text(this.text), Text(this.text)],
    );
  }
}

class MyFittedRow extends MyRow {
  const MyFittedRow({super.key, super.text});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return FittedBox(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
              minWidth: constraints.maxWidth, maxWidth: double.infinity),
          child: super.build(context),
        ),
      );
    });
  }
}
