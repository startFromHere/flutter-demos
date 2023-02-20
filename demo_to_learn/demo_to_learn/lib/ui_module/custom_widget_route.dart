import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:web_socket_channel/io.dart';

class CustomWidgetRoute extends StatefulWidget {
  const CustomWidgetRoute({super.key});

  @override
  State<CustomWidgetRoute> createState() => _CustomWidgetRouteState();
}

class _CustomWidgetRouteState extends State<CustomWidgetRoute>
    with SingleTickerProviderStateMixin {
  double _turns = .0;

  late AnimationController _circleProgressAnimationController;

  String _text = "";
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _circleProgressAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    bool isForward = true;
    _circleProgressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _circleProgressAnimationController.reverse();
        } else {
          _circleProgressAnimationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _circleProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _circleProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GradientButton(
                colors: [Colors.orange, Colors.red],
                child: Text('Submit'),
                onPressed: onTap,
              ),
              TurnBox(
                  turns: _turns,
                  speed: 500,
                  child: Icon(
                    Icons.refresh,
                    size: 50,
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _turns += 0;
                    });
                  },
                  child: Text("顺时针旋转1/5圈")),
              RepaintBoundary(child: CustomPaintWidget()),
              AnimatedBuilder(
                animation: _circleProgressAnimationController,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(children: [
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: [
                          GradientCircularProgressIndicator(
                              colors: [Colors.blue, Colors.red],
                              radius: 50.0,
                              strokeWidth: 20.0,
                              strokeCapRound: true,
                              value: _circleProgressAnimationController.value)
                        ],
                      )
                    ]),
                  );
                },
              ),
              // CustomCheckbox()
              ElevatedButton(
                child: Text(_loading ? "loading..." : _text),
                onPressed: () {
                  requestData((s) => {
                        setState(() {
                          _text = s;
                        })
                      });
                },
              ),
              Expanded(child: FlutterBuilderRouteState()),
            ],
          ),
        ),
      ),
    );
  }

  onTap() {
    print("button click");
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key,
      this.colors,
      this.width,
      this.height,
      this.onPressed,
      this.borderRadius,
      required this.child})
      : super(key: key);

  final List<Color>? colors;

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          // highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  const TurnBox(
      {Key? key, this.turns = .0, this.speed = 200, required this.child})
      : super(key: key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  State<TurnBox> createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: widget.child);
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed ?? 200),
          curve: Curves.easeOut);
    }
  }
}

class CustomPaintWidget extends StatelessWidget {
  const CustomPaintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: MyPainter(),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print("paint");
    var rect = Offset.zero & size;

    drawChessboard(canvas, rect);
    drawPieces(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void drawChessboard(Canvas canvas, Rect rect) {
  var paint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Color(0xFFDCC48C);
  canvas.drawRect(rect, paint);

  paint
    ..style = PaintingStyle.stroke
    ..color = Colors.black38
    ..strokeWidth = 1.0;

  for (int i = 0; i <= 15; i++) {
    double dy = rect.top + rect.height / 15 * i;
    canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
  }

  for (int i = 0; i <= 15; i++) {
    double dx = rect.left + rect.width / 15 * i;
    canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
  }
}

void drawPieces(Canvas canvas, Rect rect) {
  double eWidth = rect.width / 15;
  double eHeight = rect.height / 15;

  var paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.black;

  canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint);

  paint.color = Colors.white;
  canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint);
}

class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    Key? key,
    this.strokeWidth = 2.0,
    required this.radius,
    required this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    this.value,
  }) : super(key: key);

  final double strokeWidth;
  final double radius;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final double totalAngle;
  final List<Color> colors;
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
            strokeWidth: strokeWidth,
            strokeCapRound: strokeCapRound,
            backgroundColor: backgroundColor,
            value: value,
            total: totalAngle,
            radius: radius,
            colors: _colors),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth = 10.0,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.radius,
      this.total = 2 * pi,
      required this.colors,
      this.stops,
      this.value});

  final double strokeWidth;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double? radius;
  final List<double>? stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius!);
    }
    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
              startAngle: 0.0, endAngle: _value, colors: colors, stops: stops)
          .createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// class CustomCheckbox extends LeafRenderObjectWidget {
//   const CustomCheckbox({
//     Key? key,
//     this.strokeWidth = 2.0,
//     this.value = false,
//     this.strokeColor = Colors.white,
//     this.fillColor = Colors.blue,
//     this.radius = 2.0,
//     this.onChanged,
//   }) : super(key: key);

//   final double strokeWidth; // “勾”的线条宽度
//   final Color strokeColor; // “勾”的线条宽度
//   final Color? fillColor; // 填充颜色
//   final bool value; //选中状态
//   final double radius; // 圆角
//   final ValueChanged<bool>? onChanged; // 选中状态发生改变后的回调

//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return RenderCustomCheckbox(
//       strokeWidth,
//       strokeColor,
//       fillColor ?? Theme.of(context).primaryColor,
//       value,
//       radius,
//       onChanged,
//     );
//   }

//   @override
//   void updateRenderObject(context, RenderCustomCheckbox renderObject) {
//     if (renderObject.value != value) {
//       renderObject.animationStatus =
//           value ? AnimationStatus.forward : AnimationStatus.reverse;
//     }
//     renderObject
//       ..strokeWidth = strokeWidth
//       ..strokeColor = strokeColor
//       ..fillColor = fillColor ?? Theme.of(context).primaryColor
//       ..radius = radius
//       ..value = value
//       ..onChanged = onChanged;
//   }
// }

// mixin RenderObjectAnimationMixin on RenderObject {
//   double _progress = 0;
//   int? _lastTimeStamp;

//   // 动画时长，子类可以重写
//   Duration get duration => const Duration(milliseconds: 200);
//   AnimationStatus _animationStatus = AnimationStatus.completed;
//   // 设置动画状态
//   set animationStatus(AnimationStatus v) {
//     if (_animationStatus != v) {
//       markNeedsPaint();
//     }
//     _animationStatus = v;
//   }

//   double get progress => _progress;
//   set progress(double v) {
//     _progress = v.clamp(0, 1);
//   }

//   @override
//   void paint(PaintingContext context, Offset offset) {
//     doPaint(context, offset); // 调用子类绘制逻辑
//     _scheduleAnimation();
//   }

//   void _scheduleAnimation() {
//     if (_animationStatus != AnimationStatus.completed) {
//       SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
//         if (_lastTimeStamp != null) {
//           double delta = (timeStamp.inMilliseconds - _lastTimeStamp!) /
//               duration.inMilliseconds;

//           //在特定情况下，可能在一帧中连续的往frameCallback中添加了多次，导致两次回调时间间隔为0，
//           //这种情况下应该继续请求重绘。
//           if (delta == 0) {
//             markNeedsPaint();
//             return;
//           }

//           if (_animationStatus == AnimationStatus.reverse) {
//             delta = -delta;
//           }
//           _progress = _progress + delta;
//           if (_progress >= 1 || _progress <= 0) {
//             _animationStatus = AnimationStatus.completed;
//             _progress = _progress.clamp(0, 1);
//           }
//         }
//         markNeedsPaint();
//         _lastTimeStamp = timeStamp.inMilliseconds;
//       });
//     } else {
//       _lastTimeStamp = null;
//     }
//   }

//   // 子类实现绘制逻辑的地方
//   void doPaint(PaintingContext context, Offset offset);
// }

// class RenderCustomCheckbox extends RenderBox with RenderObjectAnimationMixin {
//   bool value;
//   int pointerId = -1;
//   double strokeWidth;
//   Color strokeColor;
//   Color fillColor;
//   double radius;
//   ValueChanged<bool>? onChanged;

//   RenderCustomCheckbox(this.strokeWidth, this.strokeColor, this.fillColor,
//       this.value, this.radius, this.onChanged) {
//     progress = value ? 1 : 0;
//   }

//   @override
//   bool get isRepaintBoundary => true;

//   //背景动画时长占比（背景动画要在前40%的时间内执行完毕，之后执行打勾动画）
//   final double bgAnimationInterval = .4;

//   @override
//   void doPaint(PaintingContext context, Offset offset) {
//     Rect rect = offset & size;
//     _drawBackground(context, rect);
//     _drawCheckMark(context, rect);
//   }

//   void _drawBackground(PaintingContext context, Rect rect) {
//     Color color = value ? fillColor : Colors.grey;
//     var paint = Paint()
//       ..isAntiAlias = true
//       ..style = PaintingStyle.fill //填充
//       ..strokeWidth
//       ..color = color;

//     // 我们对矩形做插值
//     final outer = RRect.fromRectXY(rect, radius, radius);
//     var rects = [
//       rect.inflate(-strokeWidth),
//       Rect.fromCenter(center: rect.center, width: 0, height: 0)
//     ];
//     var rectProgress = Rect.lerp(
//       rects[0],
//       rects[1],
//       min(progress, bgAnimationInterval) / bgAnimationInterval,
//     )!;

//     final inner = RRect.fromRectXY(rectProgress, 0, 0);
//     // 画背景
//     context.canvas.drawDRRect(outer, inner, paint);
//   }

//   //画 "勾"
//   void _drawCheckMark(PaintingContext context, Rect rect) {
//     // 在画好背景后再画前景
//     if (progress > bgAnimationInterval) {
//       //确定中间拐点位置
//       final secondOffset = Offset(
//         rect.left + rect.width / 2.5,
//         rect.bottom - rect.height / 4,
//       );
//       // 第三个点的位置
//       final lastOffset = Offset(
//         rect.right - rect.width / 6,
//         rect.top + rect.height / 4,
//       );

//       // 我们只对第三个点的位置做插值
//       final _lastOffset = Offset.lerp(
//         secondOffset,
//         lastOffset,
//         (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
//       )!;

//       // 将三个点连起来
//       final path = Path()
//         ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
//         ..lineTo(secondOffset.dx, secondOffset.dy)
//         ..lineTo(_lastOffset.dx, _lastOffset.dy);

//       final paint = Paint()
//         ..isAntiAlias = true
//         ..style = PaintingStyle.stroke
//         ..color = strokeColor
//         ..strokeWidth = strokeWidth;

//       context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
//     }
//   }

//   @override
//   void performLayout() {
//     // 如果父组件指定了固定宽高，则使用父组件指定的，否则宽高默认置为 25
//     size = constraints.constrain(
//       constraints.isTight ? Size.infinite : const Size(25, 25),
//     );
//   }

//   // 必须置为true，否则不可以响应事件
//   @override
//   bool hitTestSelf(Offset position) => true;

//   // 只有通过点击测试的组件才会调用本方法
//   @override
//   void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
//     if (event.down) {
//       pointerId = event.pointer;
//     } else if (pointerId == event.pointer) {
//       // 判断手指抬起时是在组件范围内的话才触发onChangea
//       if (size.contains(event.localPosition)) {
//         onChanged?.call(!value);
//       }
//     }
//   }
// }

requestData(Function(String s) complete) async {
  Dio dio = Dio();
  Response response = await dio.get("www.baidu.com");
  String s = response.data.toString();
  print("s:${s}");
  complete(s);
}

class FlutterBuilderRouteState extends StatefulWidget {
  const FlutterBuilderRouteState({super.key});

  @override
  State<FlutterBuilderRouteState> createState() =>
      _FlutterBuilderRouteStateState();
}

class _FlutterBuilderRouteStateState extends State<FlutterBuilderRouteState> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data as Response;
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return ListView(
              children: response.data
                  .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                  .toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

download() async {
  var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
  var savePath = "./example/HBuilder.9.0.2.macosx_64.dmg";
  await downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
    if (total != 1) {
      print("${(received / total * 100).floor()}%");
    }
  });
}

Future downloadWithChunks(
  url,
  savePath, {
  ProgressCallback? onReceiveProgress,
}) async {
  const firstChunkSize = 102;
  const maxChunk = 3;

  int total = 0;
  var dio = Dio();
  var progress = <int>[];

  createCallback(no) {
    return (int received, _) {
      progress[no] = received;
      if (onReceiveProgress != null && total != 0) {
        onReceiveProgress(progress.reduce((a, b) => a + b), total);
      }
    };
  }

  Future<Response> downloadChunk(url, start, end, no) async {
    progress.add(0);
    --end;
    return dio.download(
      url,
      savePath + "temp$no",
      onReceiveProgress: createCallback(no),
      options: Options(
        headers: {"range": "bytes=$start-$end"},
      ),
    );
  }

  Future mergeTempFiles(chunk) async {
    File f = File(savePath + "temp0");
    IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead());
      await _f.delete();
    }
    await ioSink.close();
    await f.rename(savePath);
  }

  Response response = await downloadChunk(url, 0, firstChunkSize, 0);
  if (response.statusCode == 206) {
    total = int.parse(response.headers
        .value(HttpHeaders.contentRangeHeader)!
        .split("/")
        .last);
    int reserved = total -
        int.parse(response.headers.value(HttpHeaders.contentLengthHeader)!);
    int chunk = (reserved / firstChunkSize).ceil() + 1;
    if (chunk > 1) {
      int chunkSize = firstChunkSize;
      if (chunk > maxChunk + 1) {
        chunk = maxChunk + 1;
        chunkSize = (reserved / maxChunk).ceil();
      }
      var futures = <Future>[];
      for (int i = 0; i < maxChunk; ++i) {
        int start = firstChunkSize + i * chunkSize;
        futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
      }
      await Future.wait(futures);
    }
    await mergeTempFiles(chunk);
  }
}
