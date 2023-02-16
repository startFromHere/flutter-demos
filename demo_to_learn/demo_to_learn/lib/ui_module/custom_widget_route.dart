import 'dart:math';

import 'package:flutter/material.dart';

class CustomWidgetRoute extends StatefulWidget {
  const CustomWidgetRoute({super.key});

  @override
  State<CustomWidgetRoute> createState() => _CustomWidgetRouteState();
}

class _CustomWidgetRouteState extends State<CustomWidgetRoute> {
  double _turns = .0;

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
              ],
            ),
          ),
        ));
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
