import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicWidgets extends StatelessWidget {
  BasicWidgets(
      {super.key,
      this.checkboxSelected = false,
      this.switchOpenned = false,
      required this.handleSwitchValueChange,
      required this.handleCheckboxSelect});

  final bool switchOpenned;
  final bool checkboxSelected;

  final ValueChanged handleSwitchValueChange;
  final ValueChanged handleCheckboxSelect;

  @override
  Widget build(BuildContext context) {
    // return gridView;

    return SingleChildScrollView(
      child: Column(
        children: [
          gridView,
          // MyTextfieldWidget(),
          // Text("form"),
          MyFormWidget(),
          MyProgressIndicator()
        ],
      ),
    );
  }

  late GridView gridView = GridView(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, childAspectRatio: 1.3),
    children: [
      WidgetCell(widget: Text("Text")),
      WidgetCell(
          widget: TextButton(onPressed: () {}, child: Text("TextButton"))),
      WidgetCell(
        widget: ElevatedButton(
            onPressed: () {},
            child: Text(
              "ElevatedButton",
              textAlign: TextAlign.center,
            )),
      ),
      WidgetCell(
          widget:
              OutlinedButton(onPressed: () {}, child: Text("OutlinedButton"))),
      WidgetCell(
        widget: IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        label: "IconButton",
      ),
      WidgetCell(
          widget: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.info),
              label: Text("text icon button"))),
      WidgetCell(
          widget: Image(
        image: AssetImage("images/pen.jpg"),
        // width: 50,
        // height: 60,
        fit: BoxFit.contain,
      )),
      WidgetCell(
          widget: Image.network(
        "https://pic3.zhimg.com/v2-a9c98958bd0ca01c2213221c8b6847a6_250x0.jpg?source=172ae18b",
        // width: 50,
        fit: BoxFit.contain,
      )),
      WidgetCell(
        widget: Text(
          "\uE03e \uE237 \uE287",
          style: TextStyle(
              fontFamily: "MaterialIcons", fontSize: 24.0, color: Colors.green),
        ),
        label: "icon font",
      ),
      WidgetCell(
          widget: Switch(
              value: switchOpenned,
              onChanged: (value) {
                handleSwitchValueChange(value);
              })),
      WidgetCell(
          widget: Checkbox(
              value: checkboxSelected,
              onChanged: (value) {
                handleCheckboxSelect(value);
              })),
    ],
  );
}

class WidgetCell extends StatelessWidget {
  WidgetCell({Key? key, required this.widget, this.label}) : super(key: key);
  final Widget widget;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: label == null ? [widget] : [widget, Text(label!)],
          ),
        ));
  }
}

class MyTextfieldWidget extends StatefulWidget {
  const MyTextfieldWidget({super.key});

  @override
  State<MyTextfieldWidget> createState() => _MyTextfieldWidgetState();
}

class _MyTextfieldWidgetState extends State<MyTextfieldWidget> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _nameController,
          decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: "密码",
            hintText: "您的登录密码",
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.addListener(() {
      print(_nameController.text);
    });
    _passwordController.addListener(() {
      print(_passwordController.text);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }
}

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({super.key});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          // Divider(height: 20),
          // Container(
          //   height: 20,
          // ),
          TextFormField(
            autofocus: true,
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              icon: Icon(Icons.person),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "用户名不能为空";
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (v) {
              return v!.trim().length > 5 ? null : "密码不能少于6位";
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("登录"),
                  ),
                  onPressed: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      print("要提交了");
                    }
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyProgressIndicator extends StatefulWidget {
  const MyProgressIndicator({super.key});

  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late AnimationController _animationController;
  late Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("indicator"),
        LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          // valueColor: _animationController
          //     .drive(ColorTween(begin: Colors.red, end: Colors.blue))
        ),
        LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            // valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
            // value: _progress,
            valueColor: ColorTween(begin: Colors.red, end: Colors.blue)
                .animate(_animationController),
            value: _animationController.value),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: _progress,
            ),
            CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: ColorTween(begin: Colors.red, end: Colors.blue)
                    .animate(_animationController),
                value: _animationController.value),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress > 1) {
          _progress = 0;
        }
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() {
          if (_animationController.isCompleted) {
            _animationController.repeat();
          }
        }));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
