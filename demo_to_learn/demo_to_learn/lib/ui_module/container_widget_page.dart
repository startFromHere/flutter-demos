import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerWidgetPage extends StatefulWidget {
  const ContainerWidgetPage({super.key});

  @override
  State<ContainerWidgetPage> createState() => _ContainerWidgetPageState();
}

class _ContainerWidgetPageState extends State<ContainerWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("1"),
          Text("111111"),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 20, maxWidth: 10),
            child: Container(
              width: 20,
              height: 5,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 80,
            height: 40,
            // child: UnconstrainedBox(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     width: 40,
            //     height: 40,
            //     color: Colors.blue,
            //   ),
            // ),

            child: Align(
              // alignment: Alignment.centerLeft,
              child: Container(
                width: 40,
                height: 40,
                color: Colors.blue,
              ),
            ),
          ),
          MyFlex(),
          MyStack(),
          DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ],
                color: Colors.red),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          MyColumn(),
        ],
      ),
    );
  }
}

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      // textDirection: TextDirection.rtl,
      // fit: StackFit.passthrough,
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
        Positioned(
            left: 50,
            top: 50,
            right: 20,
            bottom: 20,
            // width: 10,
            // height: 10
            child: Container(
              width: 50,
              height: 50,
              color: Colors.white,
            )),
        Container(
          // height: 120,
          // width: 120,
          color: Colors.blue.shade50,
          child: Align(
            // alignment: Alignment.topRight,
            alignment: Alignment(1, -1),
            widthFactor: 2,
            heightFactor: 2,
            child: FlutterLogo(size: 60),
          ),
        ),
      ],
    );
  }
}

class MyFlex extends StatelessWidget {
  const MyFlex({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("11"),
        Wrap(
          runSpacing: 5,
          spacing: 100,
          verticalDirection: VerticalDirection.up,
          children: [Text("22"), Text("33"), Text("44")],
        ),
        Text("55"),
        Flow(
          delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
          children: <Widget>[
            Container(
              width: 140.0,
              height: 80.0,
              color: Colors.red,
            ),
            Container(
              width: 80.0,
              height: 80.0,
              color: Colors.green,
            ),
            Container(
              width: 80.0,
              height: 80.0,
              color: Colors.blue,
            ),
            Container(
              width: 80.0,
              height: 80.0,
              color: Colors.yellow,
            ),
            Container(
              width: 80.0,
              height: 80.0,
              color: Colors.brown,
            ),
            Container(
              width: 80.0,
              height: 80.0,
              color: Colors.purple,
            ),
          ],
        )
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class MyColumn extends StatelessWidget {
  const MyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(10, Text("A"));
    return Column(
      children: [
        SizedBox(
          width: 190,
          child: ResponsiveColumn(children: _children),
        ),
        ResponsiveColumn(children: _children),
        LayoutLogPrint(child: Text("xx"))
      ],
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 200) {
        return Column(children: children, mainAxisSize: MainAxisSize.min);
      } else {
        var _children = <Widget>[];
        for (var i = 0; i < children.length; i += 2) {
          if (i + 1 < children.length) {
            _children.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [children[i], children[i + 1]],
              mainAxisSize: MainAxisSize.max,
            ));
          } else {
            _children.add(children[i]);
          }
        }
        return Column(
          children: _children,
          mainAxisSize: MainAxisSize.min,
        );
      }
    });
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({
    Key? key,
    this.tag,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
