import 'package:flutter/cupertino.dart';

//import '../helpers/NotUseInternetHelper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../BottomNavigationBarPage.dart';
import '../helpers/InternetHelper.dart';

class BookedList extends StatefulWidget {
  @override
  _BookedListState createState() => _BookedListState();
}

class _BookedListState extends State<BookedList> {
  static final InternetHelper internetHelper = InternetHelper.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: internetHelper.getBookedInfoList(),
        builder: (context, snap) {
          //print(snap.data[0]['resdata'].length);  有幾筆(沒資料會噴錯)
          //print(snap.data[0]['resdata']); 資料(沒資料會噴錯)
          if (!snap.hasData) {
            return Text('loading');
          } else if (snap.data[0]['resdata'] == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      '查無預約紀錄 ...',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Image(
                    image: AssetImage('images/bear.png'),
                  ),
                  SizedBox(height: 30,),
                  AddNewFunctionButton(),
                ],
              ),
            );
          } else {
            return ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snap.data[0]['resdata'].length,
                  itemBuilder: (context, index) {
                    /*資料處理*/
                    var tempSnapDataCarrier = snap.data[0]['resdata'][index];
                    String spaceTypeName = tempSnapDataCarrier['spacetypename'];
                    String zoneName = tempSnapDataCarrier['zonename'];
                    String zoneID = tempSnapDataCarrier['devname'];
                    String userName = tempSnapDataCarrier['username'];
                    String bookedDate = tempSnapDataCarrier['bookedatetime']
                            .substring(0, 4) +
                        '/' +
                        tempSnapDataCarrier['bookedatetime'].substring(4, 6) +
                        '/' +
                        tempSnapDataCarrier['bookedatetime'].substring(6, 8);
                    String bookedTime =
                        tempSnapDataCarrier['bookedatetime'].substring(9, 26);
                    String statusName = tempSnapDataCarrier['statusname'];

                    return Slidable(
                      actionExtentRatio: 0.20, //拉除來的刪除icon 與 整個資訊欄的比例 (越接近1越大)
                      showAllActionsThreshold: 0.3, //icon拉出來多少比例就全部顯示
                      //movementDuration: Duration(milliseconds: 100), //拉超過預定比例，彈回去的時長
                      //direction: Axis.vertical, //拉的方向
                      key:
                          UniqueKey(), //解決 Dismissing a Dismissible with Flutter/Dart 必須，參考 : https://www.codenong.com/47735143/
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          margin: EdgeInsets.fromLTRB(
                              0, 15, 0, 25), //消除與 Delete widget 間的空隙
                          child: IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,


                            onTap: () async {
                              bool isNeedToDelete = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteAlertDialog();
                                  });
                              isNeedToDelete == null ? isNeedToDelete = false : isNeedToDelete = isNeedToDelete;
                              //print('isNeedToDelete : $isNeedToDelete');
                              if (isNeedToDelete) {
                                var status = await internetHelper.getBookDel(tempSnapDataCarrier['bookid']);
                                if(status[0]['rescode'] == '1'){
                                  final snackBar = new SnackBar(content: new Text('刪除成功 ! '));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                                setState(() {});
                              }
                              //TODO Add Animation
                            },


                          ),
                        ),
                      ],
                      dismissal: SlidableDismissal(
                        closeOnCanceled: true,
                        //拉到底刪除
                        dismissThresholds: {
                          SlideActionType.secondary: 0.4,
                        },
                        child: SlidableDrawerDismissal(),

                        onDismissed: (context) async {

                          print('onDismissed');
                          bool isNeedToDelete = await showDialog(
                              context: this.context,
                              builder: (context) {
                                return DeleteAlertDialog();
                              });
                          isNeedToDelete == null ? isNeedToDelete = false : isNeedToDelete = isNeedToDelete;
                          //print('isNeedToDelete : $isNeedToDelete');
                          if (isNeedToDelete) {
                            var status = await internetHelper.getBookDel(tempSnapDataCarrier['bookid']);
                            if(status[0]['rescode'] == '1'){
                              final snackBar = new SnackBar(content: new Text('刪除成功 ! '));
                              Scaffold.of(this.context).showSnackBar(snackBar);
                            }
                          }else{
                            setState(() {});
                          }
                        },


                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        margin: EdgeInsets.fromLTRB(
                            0, 0, 0, 15), //消除與 Delete widget 間的空隙
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                spaceTypeName,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                      flex: 10,
                                      child: Text(
                                        zoneName,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )),
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                      flex: 7,
                                      child: Text(
                                        '編號 : ' + zoneID,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )),
                                  Expanded(flex: 1, child: Container()),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                      flex: 18,
                                      child: Text(
                                        bookedDate + '  -  ' + bookedTime,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                  Expanded(flex: 1, child: Container()),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                    flex: 13,
                                    child: Text(
                                      '預約人員 : $userName',
                                      style: TextStyle(
                                        fontSize: userName.length > 6 ? 14 : 16,
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        statusName,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                  Expanded(flex: 1, child: Container()),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                AddNewFunctionButton(),
              ],
            );
          }
        });
  }
}

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        backgroundColor: Color(0xFFEBE7E1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text('確定要刪除此預約嗎 ?',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('取消',
              style: TextStyle(
                //color: Colors.grey
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text('確定',
              style: TextStyle(
                  //color: Colors.black87
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }
}

class AddNewFunctionButton extends StatelessWidget {
  const AddNewFunctionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70, //PEACH BLUSH
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        onTap: () {

        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  '新增預約',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Icon(
                  Icons.add,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
