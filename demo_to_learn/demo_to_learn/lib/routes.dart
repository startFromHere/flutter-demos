import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_demo/analyze_module/analyze_route.dart';
import 'package:route_demo/analyze_module/animation_test_route.dart';
import 'package:route_demo/analyze_module/async_builder_route.dart';
import 'package:route_demo/analyze_module/data_communicate_page.dart';
import 'package:route_demo/analyze_module/gesture_route.dart';
import 'package:route_demo/analyze_module/notification_test_route.dart';
import 'package:route_demo/analyze_module/provider/provider_page.dart';
import 'package:route_demo/analyze_module/value_listenable.dart';
import 'package:route_demo/analyze_module/websocket_route.dart';
import 'package:route_demo/dart_module/dart_route.dart';
import 'package:route_demo/mine_module/mine_route.dart';
import 'package:route_demo/mine_module/settings_route.dart';
import 'package:route_demo/ui_module/color_theme_route.dart';
import 'package:route_demo/ui_module/custom_scrollview_route.dart';
import 'package:route_demo/ui_module/custom_widget_route.dart';
import 'package:route_demo/ui_module/dialog_test_route.dart';
import 'package:route_demo/ui_module/nested_scrollview_route.dart';
import 'package:route_demo/ui_module/pageview_route.dart';
import 'package:route_demo/ui_module/renderable_widgets_route.dart';
import 'package:route_demo/ui_module/slivers_route.dart';
import 'package:route_demo/ui_module/ui_route.dart';

Map<String, WidgetBuilder> app_routes(BuildContext context) {
  return {
    "UI": (context) => UIRoute(),
    "dart_learn": (context) => DartLenrnRoute(),
    'analyze': (context) => AnalyzeRoute(),
    'mine': (context) => MineRoute(),
    '/settings': (context) => SettingsRoute(),
    "/renderObjectWidgets": (context) => VisiableWidgetsRoute(),
    "/PageView": (context) => PageViewRoute(),
    "/CustomScrollView": (context) => CustomScrollViewRoute(),
    "/SliversRoute": (context) => SliversRoute(),
    "/NestedScrollView": (context) => NestedScrollViewRoute(),
    "/LayoutBuilderAndAfterLayout": (context) => SettingsRoute(),
    "/InheritedWidget": (context) => DataSharePage(),
    "/Provider": (context) => ProviderTestPage(),
    "/ColorAndTheme": (context) => ThemeTestRoute(),
    "/ValueListenable": (context) => ValueListenableRoute(),
    "/AsyncBuilder": (context) => AsyncBuilderRoute(),
    "/Dialog": (context) => DialogTestRoute(),
    "/Gesture": (context) => GestureTestRoute(),
    "/Notification": (context) => NotificationTestRoute(),
    "/Animation": (context) => AnimationTestRoute(),
    "/CustomWidget": (context) => CustomWidgetRoute(),
    "/Websocket": (context) => WebSocketRoute()
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
