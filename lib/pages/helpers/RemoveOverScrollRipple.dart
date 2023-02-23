import 'package:flutter/material.dart';

class RemoveOverScrollRipple extends ScrollBehavior{  //覆蓋上下拉到底的水波紋效果
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          //不顯示頭部水波紋
          showLeading: false,
          //不顯示尾部水波紋
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,  //強調色
        );
    }
    return null;
  }
}