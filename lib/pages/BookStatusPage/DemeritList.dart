import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nchu_lib/pages/helpers/InternetHelper.dart';
import 'dart:convert';
//import '../helpers/NotUseInternetHelper.dart';

class DemeritList extends StatelessWidget {

  static final InternetHelper internetHelper = InternetHelper.instance;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '違規紀錄',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          FutureBuilder(
              future: internetHelper.getDemeritList(),
              builder: (context,snap) {

                /*多筆資料測試用*/
                // var temp = [];
                // temp.add(snap.data[0]['resdata'][0]);
                // temp.add(snap.data[0]['resdata'][0]);
                // temp.add(snap.data[0]['resdata'][0]);
                // print('temp : $temp');
                /*多筆資料測試用*/

                if (!snap.hasData) {
                  return Text('載入中...');
                } else if (snap.data[0]['resdata'] == null) {
                  return Center(
                    child: Text('查無違規紀錄',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  );
                } else if(snap.data[0]['resdata'].length == 1){
                  return Container(
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    height: (MediaQuery.of(context).size.width - 50) / 4,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snap.data[0]['resdata'][0]['mdate'].split(' ')[0]),  //原本 : 2021/02/22 10:17:20
                          Text(
                              snap.data[0]['resdata'][0]['spacetypename']+' '+
                                  snap.data[0]['resdata'][0]['devname']
                          ),
                          Text(
                              snap.data[0]['resdata'][0]['reason']
                          ),

                          /*多筆資料測試用*/
                          // Text(temp[0]['mdate'].split(' ')[0]),
                          // //原本 : 2021/02/22 10:17:20
                          // Text(
                          //     temp[0]['spacetypename'] + ' ' +
                          //         temp[0]['devname']
                          // ),
                          // Text(
                          //     temp[0]['reason']
                          // ),
                          /*多筆資料測試用*/

                        ],
                      ),
                    ),
                  );
                } else {
                  //print('snap.data : ${snap.data[0]['resdata']}');
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio:  snap.data[0]['resdata'].length == 3 ? 1.3 : 2,  /*temp.length*/
                        maxCrossAxisExtent: (MediaQuery
                            .of(context)
                            .size
                            .width - 50) / snap.data[0]['resdata'].length ,  /*temp.length*/
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      shrinkWrap: true,
                      itemCount: snap.data[0]['resdata'].length,

                      /*多筆資料測試用*/
                      //itemCount: temp.length,
                      /*多筆資料測試用*/

                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(snap.data[0]['resdata'][index]['mdate'].split(' ')[0]),  //原本 : 2021/02/22 10:17:20
                              Text(
                                snap.data[0]['resdata'][index]['spacetypename']+' '+
                                    snap.data[0]['resdata'][index]['devname'],
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  snap.data[0]['resdata'][index]['reason']
                              ),

                              /*多筆資料測試用*/
                              // Text(temp[index]['mdate'].split(' ')[0]),
                              // //原本 : 2021/02/22 10:17:20
                              // Text(
                              //     temp[index]['spacetypename'] + ' ' +
                              //         temp[index]['devname']
                              // ),
                              // Text(
                              //     temp[index]['reason']
                              // ),
                              /*多筆資料測試用*/

                            ],
                          ),
                        );
                      }
                  );
                }
              }
          ),
        ],
      ),
    );
  }
}
