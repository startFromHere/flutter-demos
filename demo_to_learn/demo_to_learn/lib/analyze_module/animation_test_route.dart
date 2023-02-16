import 'package:flutter/material.dart';

class AnimationTestRoute extends StatefulWidget {
  const AnimationTestRoute({super.key});

  @override
  State<AnimationTestRoute> createState() => _AnimationTestRouteState();
}

class _AnimationTestRouteState extends State<AnimationTestRoute>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // animation = Tween(begin: 0.0, end: 300.0).animate(animation)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Image.asset("images/pen.jpg",
              width: animation.value, height: animation.value),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return HeroAnimationRouteA();
                  },
                ));
              },
              child: Text("goto pageA"))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            InkWell(
              child: Hero(
                tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
                child: ClipOval(
                  child: Image.asset(
                    "images/flutter.png",
                    width: 50.0,
                    height: 40.0,
                  ),
                ),
              ),
              onTap: () {
                //打开B路由
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (
                    BuildContext context,
                    animation,
                    secondaryAnimation,
                  ) {
                    return FadeTransition(
                      opacity: animation,
                      child: Scaffold(
                        appBar: AppBar(
                          title: const Text("原图"),
                        ),
                        body: HeroAnimationRouteB(),
                      ),
                    );
                  },
                ));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("点击头像"),
            )
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child: Image.asset("images/flutter.png"),
        ),
      ),
    );
  }
}
