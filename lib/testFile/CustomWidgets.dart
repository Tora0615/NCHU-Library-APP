import 'package:flutter/material.dart';


/// 自訂義AppBar  //已用
class CustomAppBar extends StatelessWidget with PreferredSizeWidget{

  final String title;
  CustomAppBar({Key key, this.title}) : super(key: key);  //接輸入的title

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); //自定義appbar必要

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 35, 116, 187),
      leading: SizedBox.fromSize(size: Size(1, 1),), //隨意，似乎不會超過原本預留的位置
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


/// 自定義懸浮按鈕
class CustomFloatButton extends StatefulWidget {
  @override
  _CustomFloatButtonState createState() => _CustomFloatButtonState();

  /*新增傳入Function的功能*/
  final Function onPressed ;
  CustomFloatButton({Key key, this.onPressed}) : super(key: key);
}

class _CustomFloatButtonState extends State<CustomFloatButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: FloatingActionButton(
            child: Text(
              '確認',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 35, 116, 187),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(5),
              ),
            ),
            onPressed: widget.onPressed, //call此Function
          ),
        ),
      ],
    );
  }
}