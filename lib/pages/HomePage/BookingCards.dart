import 'package:flutter/material.dart';

class BookingCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 15,),
        BookingCardOfRentBooks(),
        SizedBox(width: 15,),
        BookingCardOfRentSpace(),
        SizedBox(width: 15,),
      ],
    );
  }
}

class BookingCardOfRentBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        //TODO 顏色待決定
        //color: Color(0xFFF3EDE6),
        color: Colors.grey[50],

        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        clipBehavior: Clip.antiAlias,

        elevation: 3, // 陰影大小
        child: InkWell(
          onTap: (){
            print('tap');
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 45) / 2,
            height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  width: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618 * 2 / 3 - 15,  // 1/3 - 15
                  height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('30',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Center(
                        child: Text('日',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618 + 20,  //  1/2 + 20
                  height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('已借閱 27 本書',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text('最近到期日',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text('2021/03/18',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618 / 3 - 5 ,  //  1/6 -5
                  height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
                  child: Icon(Icons.chevron_right),
                  padding: EdgeInsets.all(0),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class BookingCardOfRentSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey[50],
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        clipBehavior: Clip.antiAlias,

        elevation: 3, // 陰影大小
        child: InkWell(
          onTap: (){
            print('tap');
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 45) / 2,
            height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  width: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618 / 3 - 10 ,  //  1/6 - 10
                  height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
                ),

                Container(
                  width: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618 / 3 * 4 + 15 ,  //  4/6 + 15
                  height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('已預約 :'),
                      Text('308 讀者討論室',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),



                Container(
                  width: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618 / 3 - 5 ,  //  1/6 -5
                  height: ((MediaQuery.of(context).size.width - 45) / 2.5 ) * 0.618,
                  child: Icon(Icons.chevron_right),
                  padding: EdgeInsets.all(0),
                ),
              ],
            ),
          ),
        )
    );
  }
}

