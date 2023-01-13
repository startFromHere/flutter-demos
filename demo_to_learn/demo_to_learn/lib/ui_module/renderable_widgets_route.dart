import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_demo/ui_module/container_widget_page.dart';
import 'package:route_demo/ui_module/leaf_widgets.dart';

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
              Tab(
                text: "布局、容器",
              ),
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
            ContainerWidgetPage(),
            Icon(Icons.directions_bike),
          ]),
        ));
  }
}
