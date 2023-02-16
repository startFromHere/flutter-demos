import 'package:flutter/material.dart';

class GestureTestRoute extends StatefulWidget {
  const GestureTestRoute({super.key});

  @override
  State<GestureTestRoute> createState() => _GestureTestRouteState();
}

class _GestureTestRouteState extends State<GestureTestRoute> {
  String _operation = "No Gesture detected!";
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;
  double _top1 = 20.0;
  double _left1 = 10.0;
  double _radius = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 200,
              height: 100,
              child: Text(
                _operation,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => updateText("Tap"),
            onDoubleTap: () => updateText("DoubleTap"),
            onLongPress: () => updateText("LongPress"),
          ),
          GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
          Flexible(
              child: Container(
            color: Colors.amber,
            child: Stack(
              children: [
                // SizedBox(width: 200, height: 300),
                Positioned(
                  top: _top1,
                  left: _left1,
                  // width: _width,
                  // height: _height,
                  child: GestureDetector(
                    child: CircleAvatar(
                      child: Text("A"),
                      radius: _radius,
                    ),

                    // onPanUpdate: (details) {
                    //   setState(() {
                    //     _left1 += details.delta.dx;
                    //     _top1 += details.delta.dy;
                    //   });
                    // },
                    onScaleUpdate: (details) {
                      setState(() {
                        print("scale:${details.scale}");
                        _radius = 40.0 * details.scale;
                      });
                    },
                  ),
                )
              ],
            ),
          )),
          Text("this is the bottom")
        ],
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}
