import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nchu_lib/customWidgets/CustomAppBar.dart';

import 'BookedList.dart';
import 'DemeritList.dart';

class BookStatusPage extends StatelessWidget {
  BookStatusPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithoutBack(
        title: title,
      ),
      body: ListView(
        //TODO 待改
        //physics: NeverScrollableScrollPhysics(),
        children: [
          DemeritList(),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: //TODO 待改
            //     MediaQuery.of(context).size.height -
            //         kToolbarHeight -
            //         kBottomNavigationBarHeight -
            //         MediaQuery.of(context).padding.top -
            //         MediaQuery.of(context).padding.bottom -
            //         15,
            decoration: BoxDecoration(
              color: Color(0xFFC7B7AF), //TAUPE
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Text(
                          '已預約',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  BookedList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
