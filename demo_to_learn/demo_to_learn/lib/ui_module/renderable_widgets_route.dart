import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisiableWidgetsRoute extends StatefulWidget {
  const VisiableWidgetsRoute({super.key});

  @override
  State<VisiableWidgetsRoute> createState() => _VisiableWidgetsRouteState();
}

class _VisiableWidgetsRouteState extends State<VisiableWidgetsRoute> {
  ScrollController controller = ScrollController();

  bool _boxSelected = false;
  bool _switchOpenned = false;

  void _handleSwitch(openned) {
    setState(() {
      _switchOpenned = openned;
    });
  }

  void _handleBox(selected) {
    setState(() {
      _boxSelected = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: DefaultTabController(
    //       length: 3,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           TabBar(
    //               labelColor: Colors.lightBlue,
    //               dividerColor: Colors.red,
    //               indicatorPadding:
    //                   EdgeInsets.symmetric(vertical: 0, horizontal: 20),
    //               tabs: ["1", "2", "3"]
    //                   .map((e) => Tab(
    //                         text: e,
    //                       ))
    //                   .toList()),
    //           Flexible(
    //             child: TabBarView(children: [
    //               Center(
    //                 child: Icon(Icons.directions_car),
    //               ),
    //               Center(child: Icon(Icons.directions_transit)),
    //               Center(child: Icon(Icons.directions_bike)),
    //             ]),
    //           )
    //         ],
    //       )),
    // );

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                text: "基础控件",
              ),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ]),
          ),
          body: TabBarView(children: [
            BasicWidgets(
              switchOpenned: _switchOpenned,
              checkboxSelected: _boxSelected,
              handleCheckboxSelect: _handleBox,
              handleSwitchValueChange: _handleSwitch,
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ]),
        ));
  }
}

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

    return Column(
      children: [
        gridView,
        MyTextfieldWidget(),
      ],
    );
  }

  late GridView gridView = GridView(
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
}
