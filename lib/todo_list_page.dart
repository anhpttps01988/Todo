import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {


  @override
  _TodoListPageState createState() => _TodoListPageState();


}

class _TodoListPageState extends State<TodoListPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black26))),
                  child: Hero(
                      tag: 'title',
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'todo',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                letterSpacing: 1.0,
                                height: 1.5)),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.0, top: 40.0),
                  alignment: Alignment.centerLeft,
                  child: Hero(
                      tag: 'date',
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            text: '${formatDate(DateTime.now(), [
                              DD,
                              ' ',
                              d,
                              ' ',
                              M,
                              ' ',
                              yyyy
                            ])}',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0)),
                      )),
                ),
              ],
            ),
            Hero(tag: 'add',
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context,true);
                    },
                    child:
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 65.0, right: 20.0),
                        width: 65.0,
                        height: 65.0,
                        decoration:
                        BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        child:
                        Icon(Icons.add,color: Colors.white,)
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}
