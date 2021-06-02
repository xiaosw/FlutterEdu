import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'com/doudou/gc/ui/feature/feature.dart';
import 'com/doudou/gc/ui/game/game.dart';
import 'com/doudou/gc/ui/mine/mine.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainViewPage()
    );
  }
}

class MainViewPage extends StatefulWidget {
  MainViewPage({Key key}) : super(key: key);

  @override
  _MainViewPageState createState() => _MainViewPageState();
}

class _MainViewPageState extends State<MainViewPage> {

  var _currentTab = 0;
  var _tabImages;
  var _pages = [GamePage(), FeaturePage(), MinePage()];

  @override
  void initState() {
    super.initState();
    _tabImages = [
      [_buildAssetImage('ic_app_list_dark.png', 24, 17), _buildAssetImage('ic_app_list_light.png', 24, 17)],
      [_buildAssetImage('ic_featured_dark.png', 21, 18), _buildAssetImage('ic_featured_light.png', 21, 18)],
      [_buildAssetImage('ic_mine_dark.png', 21, 18), _buildAssetImage('ic_mine_light.png', 21, 18)]
    ];
  }

  Image _buildAssetImage(String name, double width, double height) {
    return Image.asset('images/$name', width: 27, height: height,);
  }

  Image getTabImage(int position) {
    if (position == _currentTab) {
      return _tabImages[position][1];
    }
    return _tabImages[position][0];
  }

  void _onTabBarChange(int index) {
    if (_currentTab == index) {
      return;
    }
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF3FB4FF),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: _currentTab,
        onTap: _onTabBarChange,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: getTabImage(0), label: "游戏"),
          BottomNavigationBarItem(icon: getTabImage(1), label: "精选"),
          BottomNavigationBarItem(icon: getTabImage(2), label: "我的"),
        ],
      ),
    );
  }
}
