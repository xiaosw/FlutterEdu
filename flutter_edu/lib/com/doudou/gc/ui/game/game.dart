import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_edu/com/doudou/gc/bean/app.dart';
import 'package:flutter_edu/com/doudou/gc/util/colors.dart';
import 'package:flutter_edu/com/doudou/gc/util/standard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GamePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }

}

class _GamePageState extends State<GamePage> {

  void _download(App app) {
    Fluttertoast.showToast(msg: "下载");
  }

  Widget _buildItem(BuildContext context, int index) {
    var source = _sources[index];
    if (Utils.isNull(source)) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Column(
          children: [
            Image.network(source.slog, width: double.infinity, height: 219, fit: BoxFit.cover,),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12.5, 10, 7.5, 9.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(source.slog, width: 59, height: 59, fit: BoxFit.cover,),
                    ),
                  ),
                  Container(
                    height: 59,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                          child: Text(source.name, style: TextStyle(color: AppColors.C_14191E, fontSize: 16, fontWeight: FontWeight.w900)),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4.5, 0, 4.5, 1),
                            child: Text(source.name, style: TextStyle(color: AppColors.C_8C9196, fontSize: 10), strutStyle: StrutStyle(
                              leading: 0,
                              forceStrutHeight: true,
                            )),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            border: Border.all(width: 0.5, color: AppColors.C_8C9196),
                          ),
                        ),
                        Text(source.name, style: TextStyle(color: AppColors.C_8C9196, fontSize: 10)),
                      ],
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      _download(source);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: AppColors.C_3FB4FF,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(9, 12, 9, 12),
                          child: Text("下载(88M)", style: TextStyle(color: AppColors.white, fontSize: 13),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _builderSeparator(BuildContext context, int index) {
    return Container(
      width: double.infinity,
      height: 15,
    );
  }

  var _sources = [];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    _sources.clear();
    for(int i = 0; i < 20; i++) {
      _sources.add(App('刺客传说',
          "https://c-ssl.duitang.com/uploads/item/201410/31/20141031050718_AGxJy.thumb.1000_0.jpeg"));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Text('Game', style: TextStyle(color: AppColors.C_14191E),)
                ],
              ),
            )
          ],
        ),
      ),
      body: ListView.separated(itemBuilder: _buildItem, separatorBuilder: _builderSeparator, itemCount: _sources.length),
    );
  }

}