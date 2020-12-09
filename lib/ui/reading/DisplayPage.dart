
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuedu_hd/ui/reading/DisplayConfig.dart';
import 'package:yuedu_hd/ui/reading/PageBreaker.dart';
import 'package:yuedu_hd/ui/reading/event/ReloadEvent.dart';
import 'package:yuedu_hd/ui/reading/TextPage.dart';
import 'package:yuedu_hd/ui/widget/space.dart';

//todo 颜色，单双页
//单双页，页眉页脚，左右中间间距
class DisplayPage extends StatelessWidget{
  static const STATUS_LOADING = 11;
  static const STATUS_ERROR = 12;
  static const STATUS_SUCCESS = 13;


  final int status;
  final YDPage text;
  final YDPage text2;
  final int chapterIndex;
  final int currPage;
  final int maxPage;
  final int viewPageIndex;//指代在pagerView里面的序号
  final bool fromEnd;

  DisplayPage(this.status, this.text,{this.text2, this.chapterIndex, this.currPage, this.maxPage, this.viewPageIndex, this.fromEnd}):super(key: ValueKey(text));

  @override
  Widget build(BuildContext context) {

    var config = DisplayConfig.getDefault();
    return Container(
      color: Color(config.backgroundColor),
      child: Stack(
        children: [
          if(status == STATUS_SUCCESS)
            _buildContent(context),
          if(status == STATUS_LOADING)
            Container(
              child: Center(//占位内容
                child: Text('加载中'),
              ),
            ),
          if(status == STATUS_ERROR)
            _buildError(),
        ],
      ),
    );
  }

  Widget _buildError(){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('加载失败/(ㄒoㄒ)/~~'),
          VSpace(20),
          RaisedButton(onPressed: (){
            ReloadEvent.getInstance().reload(viewPageIndex);
          },child: Text('重新加载'),)
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context){
    var theme = Theme.of(context);
    var config = DisplayConfig.getDefault();
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(config.margin),
          child:TextPage(ydPage: text,),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text('$currPage/$maxPage',style: TextStyle(color: Colors.grey),),
          ),
        )

      ],
    );

  }

}