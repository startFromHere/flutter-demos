import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_demo/empty_page.dart';
import 'package:route_demo/lessons_route.dart';
import 'package:route_demo/mine_route.dart';
import 'package:route_demo/settings_route.dart';
import 'package:route_demo/study_route.dart';
import 'package:route_demo/welcome_route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  void _handleTap() {
    print("clicked");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      // initialRoute: "/init",
      // initialRoute: "/welcome",
      routes: {
        // "/welcome": (context) => WelcomeRoute(),
        "lessons": (context) => LessonsRoute(),
        "mine": (context) => MineRoute(),
        'study': (context) => StudyRoute(),
        // '/settings': (context) => SettingsRoute(),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (context) {
      //     return EmptyPage();
      //   });
      // },
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
  List<Widget> listScreens = [LessonsRoute(), StudyRoute(), MineRoute()];

  final _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _tabIndex != 0,
            // child: TabNavigator(navigatorKey: _navigatorKeys[0]!, idx: 0),
            child: Navigator(
                key: _navigatorKeys[0]!,
                initialRoute: 'lessons',
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(builder: (context) {
                    if (settings.name == "/settings") {
                      return SettingsRoute();
                    } else {
                      return listScreens[_tabIndex];
                    }
                  });
                }),
          ),
          Offstage(
            offstage: _tabIndex != 1,
            // child: TabNavigator(navigatorKey: _navigatorKeys[1]!, idx: 1),
            child: Navigator(
                key: _navigatorKeys[1]!,
                initialRoute: 'study',
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(builder: (context) {
                    if (settings.name == "/settings") {
                      return SettingsRoute();
                    } else {
                      return listScreens[_tabIndex];
                    }
                  });
                }),
          ),
          Offstage(
            key: _navigatorKeys[2]!,
            offstage: _tabIndex != 2,
            // child: TabNavigator(navigatorKey: _navigatorKeys[2]!, idx: 1),
            child: Navigator(
                initialRoute: 'mine',
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(builder: (context) {
                    if (settings.name == "/settings") {
                      return SettingsRoute();
                    } else {
                      return listScreens[_tabIndex];
                    }
                  });
                }),
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     Navigator(
      //         key: _navigatorKeys[0]!,
      //         initialRoute: 'lessons',
      //         onGenerateRoute: (settings) {
      //           return MaterialPageRoute(builder: (context) {
      //             if (settings.name == "/settings") {
      //               return SettingsRoute();
      //             } else {
      //               return listScreens[_tabIndex];
      //             }
      //           });
      //         }),
      //     Navigator(
      //         key: _navigatorKeys[1]!,
      //         initialRoute: 'study',
      //         onGenerateRoute: (settings) {
      //           return MaterialPageRoute(builder: (context) {
      //             if (settings.name == "/settings") {
      //               return SettingsRoute();
      //             } else {
      //               return listScreens[_tabIndex];
      //             }
      //           });
      //         }),
      //     Navigator(
      //         initialRoute: 'mine',
      //         onGenerateRoute: (settings) {
      //           return MaterialPageRoute(builder: (context) {
      //             if (settings.name == "/settings") {
      //               return SettingsRoute();
      //             } else {
      //               return listScreens[_tabIndex];
      //             }
      //           });
      //         }),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
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
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "lessons"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "study"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "mine"),
          ]),
    );
  }
}
