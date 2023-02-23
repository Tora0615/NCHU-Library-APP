/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets.dart';
import 'package:flutter_picker/flutter_picker.dart';


String leftEye = '-0.00';
String rightEye = '-0.00';

class SelectNearSightDegreePage extends StatefulWidget {

  final String title;
  SelectNearSightDegreePage({Key key, this.title}) : super(key: key);
  @override
  _SelectNearSightDegreePageState createState() => _SelectNearSightDegreePageState();
}

class _SelectNearSightDegreePageState extends State<SelectNearSightDegreePage> {
  List<Widget> renderCell() {
    //List a = [1,2,3,4];
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return str.split("")
        .map((item) => ListTile(
          title: Text('字母$item'),
          subtitle: Text('這是字母列表'),
         leading: Icon(Icons.wifi),
    )).toList();
  }

  test(context){
    showModalBottomSheet(  //底部資訊表，背景屏蔽
        backgroundColor: Colors.transparent,  //圓角外透明
        context: context,
        builder: (context) {
          // 子元件
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: 250,
            child: Center(
              child: Column(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 1,
                    child: Scrollbar(
                      child: ListView(
                        itemExtent: 60,
                        cacheExtent: 100,
                        addAutomaticKeepAlives: false,
                        children: renderCell(),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container())
                ],
              ),
            ),
          );
        }
    );
  }

  showPickerModal(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: [-1.00,-1.50,-2.00,-2.50,-3.00,-3.50,-4.00]),
        changeToFirst: false,
        hideHeader: false,

        /*按下確定*/
        onConfirm: (Picker picker, List value) {
          //print(value.toString());
          print(picker.adapter.text);
          rightEye = picker.adapter.text;
          setState(() {

          });
        },

        /*每換一個值都會顯示出來*/
        /*onSelect: (Picker picker, int index, List value){

        },*/

    ).showModal(context); //_scaffoldKey.currentState);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 98, 203, 225),
      appBar: CustomAppBar(title: widget.title,),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.asset('asset/neko-unscreen.gif'),
              flex: 1,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('左眼',
                        style: TextStyle(
                          color: Color.fromARGB(255, 35, 116, 187),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      FlatButton(
                        minWidth: 100,
                        color: Color.fromARGB(255, 35, 116, 187),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        onPressed: (){
                          test(context);
                          //showPickerModal(context);
                        },
                        child: Text(
                          '-1.00',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40,),
                  Column(
                    children: [
                      Text('右眼',
                        style: TextStyle(
                          color: Color.fromARGB(255, 35, 116, 187),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      FlatButton(
                        minWidth: 100,
                        color: Color.fromARGB(255, 35, 116, 187),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        onPressed: (){
                          //test(context);
                          showPickerModal(context);
                        },
                        child: Text(
                          rightEye,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatButton(
        onPressed: (){

        },
      ),
    );
  }
}


//showBottomSheet 底部資訊表，背景可點
//showModalBottomSheet  //底部資訊表，背景不可點
//-1.00~-4.00 , 0.5 each

 */