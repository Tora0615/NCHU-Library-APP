import 'ImageBanner.dart';
import 'package:flutter/material.dart';
import '../../customWidgets/CustomAppBar.dart';
import 'BookingCards.dart';
import 'LatestNews.dart';

class MainPage extends StatefulWidget {

  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  //need online image url
  final List<String> _imgData = [
    "http://www.lib.nchu.edu.tw/images/slider/20210209_0502_insect.jpg",
    "http://www.lib.nchu.edu.tw/images/slider/20210119_0227_reading.jpg",
    "http://www.lib.nchu.edu.tw/modules/mod_vina_awesome_image_slider/libs/timthumb.php?a=c&q=99&z=0&w=1200&h=450&src=http://www.lib.nchu.edu.tw/images/slider/20210115_0215_OA.png",
    "http://www.lib.nchu.edu.tw/modules/mod_vina_awesome_image_slider/libs/timthumb.php?a=c&q=99&z=0&w=1200&h=450&src=http://www.lib.nchu.edu.tw/images/slider/20201207_20210331_news47.jpg",
    "http://www.lib.nchu.edu.tw/modules/mod_vina_awesome_image_slider/libs/timthumb.php?a=c&q=99&z=0&w=1200&h=450&src=http://www.lib.nchu.edu.tw/images/slider/20200107_0228_redenvelope.jpg",
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWithoutBack(title: widget.title,),
        body: Column(
          children: [
            Expanded(  //上半部分
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          child: ImageBanner(_imgData),
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        ),
                      ),
                      flex: 3,
                    ),

                    Expanded(
                      child: Center(
                          child: BookingCards(),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(  //下半部分
              flex: 5,
              child: Center(
                child: LatestNews(),
              ),
            )
          ],
        ),
    );
  }
}

