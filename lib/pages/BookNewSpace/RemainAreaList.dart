import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import '../helpers/InternetHelper.dart';
import '../helpers/RemoveOverScrollRipple.dart';

class RemainAreaList extends StatelessWidget {

  static final InternetHelper internetHelper = InternetHelper.instance;

  // 先呼叫 internetHelper.findSpaceType() 得資料，再用 then 傳入 generateAllSpaceList
  generateAllSpaceList(List spaceData){
    print('generateAllSpaceList called');
    final List allSpaceType = [];
    /*取得所有種類spaceTypeName*/
    for(int i=0 ; i<spaceData[0]['resdata'].length ; i++){
      if(allSpaceType.contains(spaceData[0]['resdata'][i]['spacetypename']) != true){
        allSpaceType.add(spaceData[0]['resdata'][i]['spacetypename'] );
      }
    }
    //print(allSpaceType);

    /*在list中宣告spaceTypeName數量的list (二維陣列)*/
    List test = [];
    for(int i=0;i<allSpaceType.length;i++){
      test.add([]);
    }

    /*比對 allSpaceType 跟 所有資料，同spaceTypeName的存入同一個List*/
    for(int i=0;i<allSpaceType.length;i++){
      for(int j=0;j<spaceData[0]['resdata'].length;j++){
        if(spaceData[0]['resdata'][j]['spacetypename'] == allSpaceType[i]){
          test[i].add(spaceData[0]['resdata'][j]);
        }
      }
    }

    // print(test[0]);
    // print(test[1]);
    //print(test[2]);
    // print(test);
    return test;
  }


  // getCanBookList(){
  //   // test[i]['spacetypename'] //讀者討論室
  //   // test[i]['count'] //讀者討論室
  // }

  @override
  Widget build(BuildContext context) {

    Map getTypeIdByTypeName;  //getTypeIdByTypeName['多媒體聆賞席'] : 3
    internetHelper.getCanBookSpaceType().then((value) => getTypeIdByTypeName = value);

    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Center(
        child: FutureBuilder(
          future: internetHelper.getRemainSpace().then((helperReturnSpaceData) => generateAllSpaceList(helperReturnSpaceData)),
          builder: (context, snap){
            if(!snap.hasData){
              return Container(
                child: Image(image : AssetImage('images/gooseScared.png')),
              );
            }
            //print(snap.data);
            return ScrollConfiguration(
              behavior: RemoveOverScrollRipple(),  //覆蓋ListView上下水波紋
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snap.data.length,
                itemBuilder: (listViewContext ,listViewIndex){
                  //print(snap.data.length);  //11   snap.data[L_index]
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 15,),
                      Text('${snap.data[listViewIndex][0]['spacetypename']}',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 15,),

                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate : SliverGridDelegateWithFixedCrossAxisCount(
                          //crossAxisCount: snap.data[L_index].length == 1 ? 1 : 2,
                          //childAspectRatio: snap.data[L_index].length == 1 ? 4.0 : 2.0, //寬:高
                          childAspectRatio: 2.0,
                          crossAxisCount: 2,

                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: snap.data[listViewIndex].length,  //=G_index
                        itemBuilder: (gridViewContext , gridViewIndex){
                          return Card(
                            elevation: 3,
                            color: getTypeIdByTypeName.containsKey(snap.data[listViewIndex][gridViewIndex]['spacetypename']) ? Colors.grey[100] : Colors.grey[400],
                            child: InkWell(
                              // 可預約才可以點擊
                              onTap: getTypeIdByTypeName.containsKey(snap.data[listViewIndex][gridViewIndex]['spacetypename']) ? (){
                                //print('listViewIndex:$listViewIndex' +' / '+ 'gridViewIndex:$gridViewIndex');  //listViewIndex:1 / gridViewIndex:1
                                // print(snap.data[listViewIndex][gridViewIndex]['zonename']); //3F-討論室
                                // print(snap.data[listViewIndex][gridViewIndex]['spacetypename']); //讀者討論室


                                String spaceTypeName = snap.data[listViewIndex][gridViewIndex]['spacetypename'];
                                String typeId = getTypeIdByTypeName[spaceTypeName];
                                print('SpaceTypeId : $typeId');
                                String zoneName = snap.data[listViewIndex][gridViewIndex]['zonename'];
                                String zoneNameId;
                                internetHelper.getZoneInfo(typeId).then((value) => print(value[zoneName]));
                                //print(zoneNameId);
                              } : null,
                              child: Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Text(snap.data[listViewIndex][gridViewIndex]['zonename'],
                                          style: TextStyle(
                                            fontSize: snap.data[listViewIndex][gridViewIndex]['zonename'].length > 9 ? 13 : 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text('尚有空間 : ${snap.data[listViewIndex][gridViewIndex]['count']}'
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 26,
                                    ),
                                    padding: EdgeInsets.all(0),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 15,),

                    ],
                  );
                },
              ),
            );

          },
        ),

      ),
    );
  }
}