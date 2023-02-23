import 'package:flutter/material.dart';
import 'dart:math';

class BuildPageBottomWaveAnimation extends StatefulWidget {
  @override
  _BuildPageBottomWaveAnimationState createState() => _BuildPageBottomWaveAnimationState();
  BuildPageBottomWaveAnimation({Key key, this.size}) : super(key: key);
  final Size size;
}

class _BuildPageBottomWaveAnimationState extends State<BuildPageBottomWaveAnimation> with SingleTickerProviderStateMixin{
  ///動畫控制器
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    //建立動畫控制器
    _animationController = AnimationController(
      //預設的初始值
      value: 0.0,
      //執行時間
      duration: Duration(seconds: 10),
      //值變化範圍
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    );
    //重複執行
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //繫結動畫控制器
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        //裁剪元件
        return ClipPath(
          //自定義裁剪路徑
          clipper: HeaderClipper(_animationController.value),
          //裁剪的子Widget
          child: Container(
            //高度
            height: widget.size.height * 0.5,
            //線性漸變顏色的樣式
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     //線性漸變的方向
            //       begin: Alignment.bottomLeft,
            //       end: Alignment.topRight,
            //       colors: [Color(0xFFE0647B), Color(0xFFFCDD89)]),
            // ),
            color: Color(0xFFEBE7E1),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    //銷燬
    _animationController.dispose();
    super.dispose();
  }
}



///自定義 Clipper
class HeaderClipper extends CustomClipper<Path> {
  ///取值為 -1 ~ 1.0
  double moveFlag = 0;

  HeaderClipper(this.moveFlag);

  @override
  Path getClip(Size size) {
    double heightRatio = 0.6;  //用來統一更改取線所在高度，越高越下面
    //建立 Path
    Path path = Path();
    //移動到點 P0點 也是曲線的起點
    path.lineTo(0, size.height * heightRatio);
    //計算控制點 P1 的座標
    double xCenter = size.width * 0.5 +
        (size.width * 0.6 + 1) * sin(moveFlag * pi);
    double yCenter = size.height * heightRatio + 69 * cos(moveFlag*pi);
    //構建 二階貝塞爾曲線
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * (heightRatio - 0.05) );

    path.lineTo(size.width, 0);
    return path;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    //重新整理
    return true;
  }
}

//參考 : https://www.mdeditor.tw/pl/pwGV/zh-tw