import 'package:flutter/material.dart';
import 'package:todo_app/tick_anim_canvas.dart';
import 'package:todo_app/todo_list_page.dart';

import 'callback.dart';

class IconAnimation extends StatefulWidget {
  final bool isTransform;

  final Function(bool) callback;

  IconAnimation(this.isTransform, this.callback);

  @override
  _IconAnimationState createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> _animation2;
  double _fraction = 0.0;
  bool isData = false;
  TickCanvas _tickCanvas;

  @override
  void initState() {
    super.initState();

    _tickCanvas = TickCanvas();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    _animation = new Tween(begin: 0.0, end: 21.0).animate(_animationController)
      ..addListener(() {
        setState(() {
          this._fraction = _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _navigateDisplayTodoList(context);
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTransform) {
      _tickCanvas.fractionLeft = 0.0;
      _animationController.forward();

      if(isData){
        _animation2 = new Tween(begin: 0.0, end: 21.0).animate(_animationController)
          ..addListener((){
            print('_animation2');
          });
      }

    } else {
      _tickCanvas.animCircle = 0.0;
      _tickCanvas.anim1 = 0.0;
      _tickCanvas.anim2 = 0.0;
      _tickCanvas.anim3 = 0.0;
      _tickCanvas.fractionLeft = 0.0;
    }
    _tickCanvas.isTransform = widget.isTransform;
    return GestureDetector(
      onTap: () {
        _navigateDisplayTodoList(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 6.0),
        width: 30.0,
        height: 30.0,
        child: LayoutBuilder(
          builder: (context, box) {
            _tickCanvas.width = box.maxWidth;
            _tickCanvas.height = box.maxHeight;
            _tickCanvas.fractionLeft = _fraction;
            return CustomPaint(
              painter: _tickCanvas,
            );
          },
        ),
        decoration: BoxDecoration(shape: BoxShape.circle),
      ),
    );
  }

  _navigateDisplayTodoList(BuildContext context) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (_) {
      return TodoListPage();
    }));
    isData = result;
    widget.callback(result);
  }
}
