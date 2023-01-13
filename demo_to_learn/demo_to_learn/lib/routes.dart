import 'package:flutter/cupertino.dart';
import 'package:route_demo/analyze_module/analyze_route.dart';
import 'package:route_demo/dart_module/dart_route.dart';
import 'package:route_demo/mine_module/mine_route.dart';
import 'package:route_demo/mine_module/settings_route.dart';
import 'package:route_demo/ui_module/renderable_widgets_route.dart';
import 'package:route_demo/ui_module/ui_route.dart';

Map<String, WidgetBuilder> app_routes(BuildContext context) {
  return {
    "UI": (context) => UIRoute(),
    "dart_learn": (context) => DartLenrnRoute(),
    'analyze': (context) => AnalyzeRoute(),
    'mine': (context) => MineRoute(),
    '/settings': (context) => SettingsRoute(),
    "/renderObjectWidgets": (context) => VisiableWidgetsRoute(),
    "/Flex": (context) => VisiableWidgetsRoute(),
    "/WrapAndFlow": (context) => SettingsRoute(),
    "/StackAndPositioned": (context) => SettingsRoute(),
    "/Align": (context) => SettingsRoute(),
    "/LayoutBuilderAndAfterLayout": (context) => SettingsRoute(),
  };
}

// class APPRoute {
//   static const Map route = {
//     "UI": (context) => UIRoute(),
//     "dart_learn": (context) => DartLenrnRoute(),
//     'analyze': (context) => AnalyzeRoute(),
//     'mine': (context) => MineRoute(),
//     '/settings': (context) => SettingsRoute(),
//     "/RowsAndColumns": (context) => VisiableWidgetsRoute(),
//     "/Flex": (context) => VisiableWidgetsRoute(),
//     "/WrapAndFlow": (context) => SettingsRoute(),
//     "/StackAndPositioned": (context) => SettingsRoute(),
//     "/Align": (context) => SettingsRoute(),
//     "/LayoutBuilderAndAfterLayout": (context) => SettingsRoute(),
//   };
// }
