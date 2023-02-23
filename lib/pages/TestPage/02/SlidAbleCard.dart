import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidAbleCard extends StatefulWidget {
  @override
  _SlidAbleCardState createState() => _SlidAbleCardState();
}


class _SlidAbleCardState extends State<SlidAbleCard> {

  List test = ['a','b','c','d','e'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [

          Text('完整的拖動刪除+按鈕刪除'),
          ListView.builder(
            key: UniqueKey(),
            shrinkWrap: true,
            itemCount: test.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(index),
                actionPane: SlidableDrawerActionPane(),

                secondaryActions: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    margin: EdgeInsets.fromLTRB(0, 4, 0, 14),
                    child: IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: (){
                        setState(() {
                          test.remove(test[index]);
                        });
                      },
                    ),
                  ),
                ],
                dismissal: SlidableDismissal(   //拉到底刪除
                  child: SlidableDrawerDismissal(),
                  onDismissed: (context){
                    setState(() {  //沒setState間格空白會流著
                      test.remove(test[index]);
                    });
                  },
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.fromLTRB(4, 0, 0, 10),
                  child: ListTile(
                    title: Text('${test[index]}'),
                  ),
                ),
              );
            },
          ),

          Text('Test List : $test'),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context,int index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Text(('the_leading')),
                        title: Text(('the_title')),
                        trailing: Text(('the_trailing')),
                        subtitle: Text(('the_subtitle')),
                      ),
                    ),
                    actions: <Widget>[   //左隱藏
                      IconSlideAction(
                        caption: 'Archive',
                        color: Colors.blue,
                        icon: Icons.archive,
                        onTap: () {print('archive');},
                      ),
                      IconSlideAction(
                        caption: 'Share',
                        color: Colors.indigo,
                        icon: Icons.share,
                        onTap: () {print('share');},
                      ),
                    ],
                    secondaryActions: <Widget>[  //右隱藏
                      IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: ()  {print('more');},
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {print('delete');},
                      ),
                    ],


                  );
                }),
          ),


        ],
      ),
    );
  }
}




