import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_demo/analyze_module/analyze_route.dart';
import 'package:route_demo/dart_module/dart_route.dart';
import 'package:route_demo/empty_page.dart';
import 'package:route_demo/analyze_module/key_route.dart';
import 'package:route_demo/mine_module/mine_route.dart';
import 'package:route_demo/mine_module/settings_route.dart';
import 'package:route_demo/routes.dart';
import 'package:route_demo/ui_module/ui_route.dart';
import 'package:route_demo/welcome_route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      // initialRoute: "/init",
      // initialRoute: "/welcome",
      routes: app_routes(context),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return EmptyPage();
        });
      },
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  static int _tabIndex = 0;
  List<Widget> mainRoutes = [
    UIRoute(),
    DartLenrnRoute(),
    AnalyzeRoute(),
    MineRoute()
  ];

  List<Widget> navigators = [
    Offstage(
      // offstage: _tabIndex != 0,
      offstage: false,
      // child: TabNavigator(navigatorKey: _navigatorKeys[0]!, idx: 0),
      child: Navigator(
          key: GlobalKey<NavigatorState>(),
          initialRoute: 'ui',
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) {
              if (settings.name == "/settings") {
                return SettingsRoute();
              } else {
                return UIRoute();
              }
            });
          }),
    ),
    Offstage(
      // offstage: _tabIndex != 1,
      offstage: false,
      // child: TabNavigator(navigatorKey: _navigatorKeys[1]!, idx: 1),
      child: Navigator(
          key: GlobalKey<NavigatorState>(),
          initialRoute: 'study',
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) {
              if (settings.name == "/keyTest") {
                return PositionedTiles();
              } else {
                return DartLenrnRoute();
              }
            });
          }),
    ),
    Offstage(
      key: GlobalKey<NavigatorState>(),
      // offstage: _tabIndex != 2,
      offstage: false,
      // child: TabNavigator(navigatorKey: _navigatorKeys[2]!, idx: 1),
      child: Navigator(
          initialRoute: 'analyze',
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) {
              if (settings.name == "/settings") {
                return SettingsRoute();
              } else {
                return AnalyzeRoute();
              }
            });
          }),
    ),
    Offstage(
      key: GlobalKey<NavigatorState>(),
      // offstage: _tabIndex != 2,
      offstage: false,
      // child: TabNavigator(navigatorKey: _navigatorKeys[2]!, idx: 1),
      child: Navigator(
          initialRoute: 'mine',
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) {
              if (settings.name == "/settings") {
                return SettingsRoute();
              } else {
                return MineRoute();
              }
            });
          }),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainRoutes[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _tabIndex,
          onTap: (value) {
            setState(() {
              _tabIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.draw_outlined), label: "ui"),
            BottomNavigationBarItem(icon: Icon(Icons.code), label: "dart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_mark), label: "analyze"),
            BottomNavigationBarItem(
                icon: Icon(Icons.data_array), label: "mine"),
          ]),
    );
  }
}
