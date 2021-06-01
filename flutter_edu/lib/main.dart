import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_edu/anim/transition.dart';
import 'package:flutter_edu/mine/mine.dart';
import 'package:flutter_edu/standard.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      home: MainViewPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainViewPage extends StatefulWidget {
  MainViewPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MainViewPageState createState() => _MainViewPageState();
}

class _MainViewPageState extends State<MainViewPage> {
  int _counter = 0;
  var log = MethodChannel("${Global.NATIVE_PLUGIN_PREFIX}/log");
  BasicMessageChannel _messageChannel;
  PageController _pageController = PageController(initialPage: 0);
  Timer _timer;
  var mCurrentItem = 0;
  @override
  void initState() {
    super.initState();
    mCurrentItem = _pageController.initialPage;
    // _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //   mCurrentItem++;
    //   _pageController.animateToPage(mCurrentItem % 5,
    //       duration: Duration(microseconds: 300),
    //       curve: Curves.linear);
    // });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      if (Utils.isNull(_messageChannel)) {
        print("register message receiver");
        _messageChannel = BasicMessageChannel("com.xsw.flutter.message/global", StringCodec());
        _messageChannel.setMessageHandler((message) async {
          print("receiver message------------------------>$message");
        });
      }
      PlatformLog.e("main", "$_counter");
      // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new MinePage()));
      Fluttertoast.showToast(
          msg: "Toast",
          backgroundColor: Colors.black45);
      // Navigator.of(context).push(SlidingAroundRoute(MinePage()));
    });
  }

  void _onPageChange(int position) {
    PlatformLog.e("main", "position = $position");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'FlutterEdu',
              )
            ],
          ),
        ),
      ),
      body: PageView(
        onPageChanged: _onPageChange,
        controller: _pageController,
        children: [
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Image.asset('images/test.jpeg'),
                Expanded(child: Align(
                  alignment: FractionalOffset.center,
                  child: AndroidView(viewType: '${Global.NATIVE_PLUGIN_PREFIX}/round_image_view',
                      creationParams: {
                        "width" : 100,
                        "height" : 100,
                        "forceCircle":true,
                        "resizeClip":false,
                        "background":"#ff00ff"
                      },
                      creationParamsCodec: StandardMessageCodec()
                  ),
                )),
                WillPopScope(
                    child: Text("motion back")
                    , onWillPop: () async {
                      Fluttertoast.showToast(msg: "back");
                      return false;
                })
              ],
            ),
          ),
          Image.network("https://i1.mifile.cn/f/i/2019/micc9/summary/specs-02.png"),
          Image.network("https://i1.mifile.cn/f/i/2019/micc9/summary/specs-03.png"),
          Image.network("https://i1.mifile.cn/f/i/2019/micc9/summary/specs-04.png"),
          Image.network("https://i1.mifile.cn/f/i/2019/micc9/summary/specs-05.png"),
          Image.network("https://i1.mifile.cn/f/i/2019/micc9/summary/specs-06.png")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "label", activeIcon: Text("设置")),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "label", activeIcon: Text("设置")),
        ],
      ),
    );
  }
}
