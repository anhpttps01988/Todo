import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/animation_icon.dart';

import 'callback.dart';
import 'todo_list_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {'todo_list': (_) => new TodoListPage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controllerAddItem;
  Animation _animationAddBtn;

  AnimationController _controllerIconAdd;
  Animation _animationIconAdd;

  Animation _animationCircleAddItem;
  Animation _animationCircleBox;

  bool isTransformCircle = false;
  bool isTransformBtn = false;
  bool isActiveTick = false;
  bool isResult = false;

  @override
  void initState() {
    super.initState();
    _controllerIconAdd = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _controllerAddItem = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _animationCircleBox = IntTween(
      begin: 0,
      end: 270,
    ).animate(
      CurvedAnimation(
        parent: _controllerAddItem,
        curve: Curves.ease,
      ),
    );

    Animation curveBtnAdd = new CurvedAnimation(
        parent: _controllerAddItem, curve: Curves.decelerate);
    _animationAddBtn = new IntTween(begin: 0, end: 150).animate(curveBtnAdd);

    _animationCircleAddItem = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(75.0),
    ).animate(
      CurvedAnimation(
        parent: _controllerAddItem,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _controllerAddItem.dispose();
    _controllerIconAdd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                            tag: 'title',
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'todo\n',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    letterSpacing: 1.0,
                                  )),
                            )),
                        Hero(
                          tag: 'date',
                          child: RichText(
                            textAlign: TextAlign.center,
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
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(text: '', children: [
                        TextSpan(
                            text: 'What do you want to do today?\n',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            )),
                        TextSpan(
                            text: 'Start adding items to your to-do list.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ))
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                  animation: _controllerAddItem,
                  builder: (context, widget) {
                    return LayoutBuilder(
                      builder: (context, box) {
                        final double width = box.maxWidth;
                        Animation curveIconAdd = new CurvedAnimation(
                            parent: _controllerIconAdd,
                            curve: Curves.decelerate);
                        _animationIconAdd =
                            new IntTween(begin: 0, end: width ~/ 3)
                                .animate(curveIconAdd)
                                  ..addStatusListener((status) {
                                    if (status == AnimationStatus.reverse) {
                                      setState(() {
                                        isActiveTick = true;
                                      });
                                    }
                                  });

                        return Hero(
                          tag: 'add',
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: <Widget>[btnControls()],
                          ),
                        );
                      },
                    );
                  }),
            ),
            Align(
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (context, box) {
                  return Container(
                    width: isTransformBtn ? box.maxWidth / 2 : 0.0,
                    height: 0.0,
                    child: TextField(
                      autofocus: false,
                      decoration: new InputDecoration(border: InputBorder.none),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconAnimation(isActiveTick,(bool) {
                setState(() {
                  isResult = bool;
                  isTransformCircle = false;
                  isTransformBtn = false;
                  isActiveTick = false;
                  _controllerAddItem.forward();
                });
              }),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer btnControls() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: containerSuccess(),
      decoration: BoxDecoration(
          color: !isTransformCircle || isResult
              ? !isTransformBtn || isResult ? Colors.black : Colors.white
              : Colors.black,
          border: !isTransformBtn ? null : Border.all(color: Colors.grey[200]),
          borderRadius: !isTransformCircle || isResult
              ? BorderRadius.all(Radius.circular(40.0))
              : _animationCircleAddItem.value),
    );
  }

  Material containerSuccess() {
    return new Material(
      child: new InkWell(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
        splashColor: Colors.white,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            isResult = false;
            _controllerAddItem.forward();
            _controllerIconAdd.forward();
            isTransformBtn = true;
          });
        },
        child: buildAnimatedContainer(),
      ),
      color: Colors.transparent,
    );
  }

  AnimatedContainer buildAnimatedContainer() {
    return new AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      width: isResult
          ? 340.0 - _animationAddBtn.value
          : !isTransformCircle
              ? 190.0 + _animationAddBtn.value
              : 190.0 + _animationAddBtn.value - _animationCircleBox.value,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildAnimatedMoveIconAdd(),
          buildVisibilityBtn(),
        ],
      ),
    );
  }

  Container buildVisibilityBtn() {
    return !isTransformCircle || isResult
        ? Container(
            margin: EdgeInsets.only(left: 11.0),
            child: RichText(
              text: TextSpan(text: '', children: [
                TextSpan(
                    text: !isTransformBtn || isResult ? 'Add item' : '',
                    style: TextStyle(letterSpacing: 1.0, fontSize: 16.0))
              ]),
            ),
          )
        : Container();
  }

  AnimatedBuilder buildAnimatedMoveIconAdd() {
    return AnimatedBuilder(
        animation: _controllerIconAdd,
        builder: (context, widget) {
          return Transform(
            transform: Matrix4.translationValues(
                1.0 * _animationIconAdd.value, 0.0, 0.0),
            child: GestureDetector(
              onTap: () {
                _listenerReverseAnimation();
              },
              child: Container(
                  child: new Icon(Icons.add,
                      color: !isTransformCircle || isResult
                          ? !isTransformBtn || isResult
                              ? Colors.white
                              : Colors.black
                          : Colors.transparent)),
            ),
          );
        });
  }

  void _listenerReverseAnimation() {
    setState(() {
      isTransformCircle = true;
      _controllerAddItem = AnimationController(
          duration: const Duration(milliseconds: 500), vsync: this);
      _animationCircleBox = IntTween(
        begin: 0,
        end: 270,
      ).animate(
        CurvedAnimation(
          parent: _controllerAddItem,
          curve: Curves.ease,
        ),
      );
      _controllerAddItem.forward();
      _controllerIconAdd.reverse();
    });
  }
}
