import 'package:flutter/material.dart';

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}

class NotificationTestRoute extends StatefulWidget {
  const NotificationTestRoute({super.key});

  @override
  State<NotificationTestRoute> createState() => _NotificationTestRouteState();
}

class _NotificationTestRouteState extends State<NotificationTestRoute> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += (_msg == "" ? "" : ",") + notification.msg;
          });
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
//           ElevatedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    //按钮点击时分发通知
                    onPressed: () => MyNotification("Hi").dispatch(context),
                    child: Text("Send Notification"),
                  );
                },
              ),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    //按钮点击时分发通知
                    onPressed: () => MyNotification("你好").dispatch(context),
                    child: Text("Send Notification2"),
                  );
                },
              ),
              Text(_msg),
              NotificationListener<MyNotification>(
                onNotification: (notification) {
                  print(notification.msg);
                  return false;
                },
                child: NotificationListener<MyNotification>(
                  onNotification: (notification) {
                    print(notification.msg);
                    return true;
                  },
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                        //按钮点击时分发通知
                        onPressed: () => MyNotification("**").dispatch(context),
                        child: Text("Send Notification3"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
