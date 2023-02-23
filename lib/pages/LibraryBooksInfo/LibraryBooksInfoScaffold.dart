import 'package:flutter/material.dart';
import 'file:///C:/Users/Arthur/Documents/Flutter/Exercise/ProjectExercise/nchu_lib/lib/testFile/CustomWidgets.dart';
import '../../customWidgets/CustomAppBar.dart';

class LibraryBooksInfoScaffold extends StatelessWidget {

  final String title;
  LibraryBooksInfoScaffold({Key key, this.title}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithoutBack(title: title,),
    );
  }
}