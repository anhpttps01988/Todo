import 'package:flutter/material.dart';
import 'hero_dialog_router.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: "hero1",
                child: Container(
                  height: 250.0,
                  width: 250.0,
                  child: Image.network(
                    'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
                  ),
                ),
              ),
            ),
            OutlineButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: "hero1",
                child: Container(
                  padding: EdgeInsets.only(top: 50.0),
                  height: 250.0,
                  width: 250.0,
                  child: Image.network(
                    'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Hero(
                tag: "hero2",
                child: Material(
                    color: Colors.transparent,
                    child: Text("Hero Text", style: TextStyle(fontSize: 40.0),)),
              ),
            ),
            OutlineButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}