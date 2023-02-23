import 'package:flutter/material.dart';
import 'file:///C:/Users/Arthur/Documents/Flutter/Exercise/ProjectExercise/nchu_lib/lib/testFile/CustomWidgets.dart';
import '../../customWidgets/CustomAppBar.dart';

class LibraryInfoScaffold extends StatefulWidget {

  final String title;
  LibraryInfoScaffold({Key key, this.title}):super(key: key);

  @override
  _LibraryInfoScaffoldState createState() => _LibraryInfoScaffoldState();
}

class _LibraryInfoScaffoldState extends State<LibraryInfoScaffold> {

  //bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithoutBack(title: widget.title,),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Placeholder(
              fallbackHeight: (MediaQuery.of(context).size.width-50)/1.4,
              fallbackWidth: MediaQuery.of(context).size.width-50,
              color: Colors.black12,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              //color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Placeholder(
              fallbackHeight: (MediaQuery.of(context).size.width-50)/1.4,
              fallbackWidth: MediaQuery.of(context).size.width-50,
              color: Colors.black12,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Placeholder(
              fallbackHeight: (MediaQuery.of(context).size.width-50)/1.4,
              fallbackWidth: MediaQuery.of(context).size.width-50,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}
