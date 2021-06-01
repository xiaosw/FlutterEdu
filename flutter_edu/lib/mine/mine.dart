import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Mine")
            ],
          ),
        ),
      ),
      body: _MineLayout(),
    );
  }

}

class _MineLayout extends StatefulWidget {

  final String title;

  _MineLayout({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MineLayoutState();
  }

}

class _MineLayoutState extends State<_MineLayout> {

  void _onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(width: double.infinity, height: 100, color: Colors.red,),
            Container(width: double.infinity, height: 100, color: Colors.blue,),
            Container(width: double.infinity, height: 100, color: Colors.red,),
            Container(width: double.infinity, height: 100, color: Colors.blue,),
            Container(width: double.infinity, height: 100, color: Colors.red,),
            Container(width: double.infinity, height: 100, color: Colors.blue,),
            Container(width: double.infinity, height: 100, color: Colors.red,),
            Container(width: double.infinity, height: 100, color: Colors.blue,),
            Container(width: double.infinity, height: 100, color: Colors.red,),
            Container(width: double.infinity, height: 100, color: Colors.blue,),
            Container(width: double.infinity, height: 100, color: Colors.red,),
            Container(width: double.infinity, height: 100, color: Colors.blue,)
          ],
        ),
      )
    );
  }

}