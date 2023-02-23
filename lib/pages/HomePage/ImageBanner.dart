import 'dart:async';
import 'package:flutter/material.dart';

// 參考教學 : https://iter01.com/433793.html

class ImageBanner extends StatefulWidget {
  final List<String> _images;
  final double height;
  final ValueChanged<int> onTap;
  final Curve curve;

  ImageBanner(
      this._images, {
        this.height = 160,  //學校圖比例 1080:400
        this.onTap,
        this.curve = Curves.linear,
      }) : assert(_images != null);

  @override
  _ImageBannerState createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  PageController _pageController;
  int _curIndex;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _curIndex = widget._images.length * 5;
    _pageController = PageController(initialPage: _curIndex);
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildPageView(),  //banner 輪播圖
        _buildIndicator(),  //點點
      ],
    );
  }

  Widget _buildIndicator() {
    var length = widget._images.length;
    return Positioned(
      bottom: 0,  //從底部往上10(以container的底開始往上，此container的底有多延伸出25)
      right: 0,
      child: Row(
        children: widget._images.map((s) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Container(
                decoration: BoxDecoration(
                  /* 正在顯示頁面index對應的點，顯示高亮顏色，其餘顯示灰色 */
                  color: s == widget._images[_curIndex % length] ? Color(0xDDC7B7AF) : Colors.grey,
                  /* 正在顯示頁面index對應的點，由於高亮會稍微不清楚，再加上邊框，其餘不需要*/
                  border: s == widget._images[_curIndex % length]? Border.all(width: 1,color: Color(0xFFC7B7AF)) : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                /* 正在顯示頁面index對應的點，寬改為16，其餘顯示8 */
                width: s == widget._images[_curIndex % length] ? 16 : 8,
                height: 8,
              ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPageView() {
    var length = widget._images.length;
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),  //底部延伸
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _curIndex = index;
            if (index == 0) {
              _curIndex = length;
              _changePage();
            }
          });
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onPanDown: (details) {
              _cancelTimer();
            },
            // onTap: () {
            //   Scaffold.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text('當前在第 ${index % length} 頁'),
            //       duration: Duration(milliseconds: 500),
            //     ),
            //   );
            // },
            child: Image.network(
              widget._images[index % length],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  /// 點擊到圖片時取消定時任務
  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      _initTimer();
    }
  }

  /// 初始化定時任務
  _initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 5), (t) {
        _curIndex++;


        /*------------------------------------*/
        // 問題 : 在其他頁面時，遇到錯誤 Unhandled Exception: '_positions.isNotEmpty': ScrollController not attached to any scroll views.

        // 原因類似於 :
        //（向上滑动后这部分UI不显示了，所以flutter就不渲染了，_scrollController也就不存在了），所以报错了。
        // 解决方案是加一个判断，等向上滑动后UI不显示了，就不执行这部分代码就好了
        // 上面那个网站给出了是 if (_scrollController.hasClients){}

        // 解法 : 加 if 判斷式
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _curIndex,
            duration: Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut,
          );
        }
        // 參考資訊 : https://blog.csdn.net/csdnwr/article/details/107038824
        /*------------------------------------*/

      });
    }
  }

  /// 切換頁面，並刷新小圓點
  _changePage() {
    Timer(Duration(milliseconds: 350), () {
      _pageController.jumpToPage(_curIndex);
    });
  }
}