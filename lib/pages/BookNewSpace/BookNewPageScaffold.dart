import 'package:flutter/material.dart';
import 'package:nchu_lib/customWidgets/CustomAppBar.dart';
import 'BuildPageBottomWaveAnimation.dart';
import 'RemainAreaList.dart';



class BookNewSpacePage extends StatelessWidget {

  BookNewSpacePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBarWithoutBack(title: title,),
      body: Stack(  //背景的堆疊
        alignment: AlignmentDirectional.bottomCenter,   //向下對齊
        children: [
          Container(  //最下層漸層背景色
            height: MediaQuery.of(context).size.height * 0.3, //高度
            decoration: BoxDecoration(  //線性漸變顏色的樣式
              gradient: LinearGradient(
                //線性漸變的方向
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xFFE0647B), Color(0xFFFCDD89)]),
            ),
          ),
          BuildPageBottomWaveAnimation(  //跟主背景色相同波浪擋住漸層，營造是有色波浪的效果(目前波浪只能在下方)
              size : Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height
                    - kToolbarHeight - kBottomNavigationBarHeight
                    - MediaQuery.of(context).padding.top
                    - MediaQuery.of(context).padding.bottom,
              )
          ),
          RemainAreaList(),
        ],
      ),
    );
  }
}





