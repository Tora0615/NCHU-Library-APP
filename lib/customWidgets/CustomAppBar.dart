import 'package:flutter/material.dart';
import 'dart:async';

bool gooseTap = false;

/// 自訂義AppBar
class CustomAppBarWithoutBack extends StatelessWidget with PreferredSizeWidget{

  final String title;
  CustomAppBarWithoutBack({Key key, this.title}) : super(key: key);  //接輸入的title

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); //自定義appbar必要

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      actions: [
        CustomGooseImage(),
        Container(  //空白的
          height: kToolbarHeight,
          width: kToolbarHeight/5*3-25,
        ),
        IconButton(icon: Icon(Icons.search),
            onPressed: (){

            }
        ),
        IconButton(icon: Icon(Icons.person),
            onPressed: (){

            }
        ),
        Container(  //空白的
          height: kToolbarHeight,
          width: kToolbarHeight/2 - 5,
        ),

      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50)
        ),
      ),
    );
  }
}




class CustomGooseImage extends StatefulWidget {
  @override
  _CustomGooseImageState createState() => _CustomGooseImageState();
}

class _CustomGooseImageState extends State<CustomGooseImage> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      /*參考 : https://www.jianshu.com/p/97a8e026840b*/
      highlightColor: Colors.transparent,  //去除長按水波紋
      splashColor: Colors.transparent,  //去除點擊水波紋
      onPressed: (){
        setState(() {
          gooseTap = true;
        });
        Timer(Duration(seconds:1), (){
          gooseTap = false;
          setState(() {});
        });
      },
      child: Image(
        image: gooseTap ? AssetImage('images/gooseScared.png') : AssetImage('images/gooseIdle.png'),
      ),
    );
  }
}




// TODO CustomAppBarWithBackIcon尚未更改
class CustomAppBarWithBackIcon extends StatelessWidget with PreferredSizeWidget{

  final String title;
  CustomAppBarWithBackIcon({Key key, this.title}) : super(key: key);  //接輸入的title

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); //自定義appbar必要

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Color.fromARGB(255, 35, 116, 187),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
      ),//隨意，似乎不會超過原本預留的位置
      title: Text(
        this.title,
        textAlign: TextAlign.end,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50)
        ),
      ),
    );
  }
}