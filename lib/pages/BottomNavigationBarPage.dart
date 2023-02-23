
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import '../testFile/CustomWidgets.dart';
import 'HomePage/HomePageScaffold.dart';
import '../customWidgets/CustomAppBar.dart';
import 'BookNewSpace/BookNewPageScaffold.dart';
import 'BookStatusPage/BookStatusPageScaffold.dart';
import 'TestPage/01/TestPageScaffold.dart';
import 'TestPage/02/SlidAbleCard.dart';
import 'TestPage/03/GetWightHighPage.dart';
import 'LibraryBooksInfo/LibraryBooksInfoScaffold.dart';
import 'LibraryInfo/LibraryInfoScaffold.dart';


class TestPage01 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithoutBack(title: 'page 1',),
      body: Container(
        //color: Colors.red,
        child: Center(
          child: Text(
              'TestPage01'
          ),
        ),
      ),
    );
  }
}
class TestPage02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithoutBack(title: 'page 2',),
      body: Container(
        //color: Colors.orange,
        child: Center(
          child: Text(
              'TestPage02'
          ),
        ),
      ),
    );
  }
}




class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() => _BottomNavigationBarPageState();
}
class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {

  int _currentIndex = 2;
  final pages = [
    BookNewSpacePage(title: 'NCHU Library',),
    BookStatusPage(title: 'NCHU Library',),
    MainPage(title: 'NCHU Library',),
    LibraryBooksInfoScaffold(title: 'NCHU Library',),
    LibraryInfoScaffold(title: 'NCHU Library',)
    //SlidAbleCard(),
    //MyHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 其他顏色
        //unselectedItemColor: Color(0xFF76819C),   //不用

        //選中顏色
        //selectedItemColor: Color(0xFFB48A47),  // GOLDEN MILK
        selectedItemColor: Color(0xFFB48A6F),  // GOLDEN MILK 改
        //selectedItemColor: Color(0xFF76819C), //PALE BLUE //也不錯
        //selectedItemColor: Color(0xEE364765), //PALE BLUE  //深藍降不透明度
        //selectedItemColor: Color(0xEE2A4646),

        backgroundColor: Color(0xFFEBE7E1),  //CREAMY SMOKE

        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: '新增預約'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              label: '預約現況'
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.home_outlined),
            label: '主頁',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark_outlined),
              label: '書籍資訊'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library_outlined),
            label: '圖書館',
          ),

        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

