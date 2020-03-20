import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///Flutter中的手势识别引入了一个Arena的概念，Arena直译为“竞技场”的意思，
///每一个手势识别器（GestureRecognizer）都是一个“竞争者”（GestureArenaMember），
///当发生滑动事件时，他们都要在“竞技场”去竞争本次事件的处理权，而最终只有一个“竞争者”会胜出(win)。
///
/// 手势冲突只是手势级别的，而手势是对原始指针的语义化的识别，所以在遇到复杂的冲突场景时，
/// 都可以通过Listener直接识别原始指针事件来解决冲突。
class SampleGestureTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势识别"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SampleGestureDetector1()));
            },
            child: Text("点击、双击、长按"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => _DragTest()));
            },
            child: Text("拖动、滑动"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => _ScaleGestureTest()));
            },
            child: Text("缩放"),
          )
        ],
      ),
    );
  }
}

//检测手势按下、长按、双击等；
class SampleGestureDetector1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SampleGestureDetector1State();
  }
}

class _SampleGestureDetector1State extends State<SampleGestureDetector1> {
  String _operation = "no operation";

  TapGestureRecognizer _recognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector"),
      ),
      body: Column(children: [
        GestureDetector(
          child: Container(
            width: 200,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              _operation,
              style: TextStyle(color: Colors.white),
            ),
          ),
          onTap: () => _updateText("Tap"),
          onDoubleTap: () => _updateText("Double Tap"),
          onLongPress: () => _updateText("LongPress"),
        ),

        ///GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，
        ///而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，
        ///GestureRecognizer是一个抽象类，一种手势的识别器对应一个GestureRecognizer的子类，
        ///Flutter实现了丰富的手势识别器，可以直接使用。
        Text.rich(TextSpan(children: [
          TextSpan(text: "你好世界"),
          TextSpan(
              text: "点我变色",
              style: TextStyle(
                  color: _toggle ? Colors.blue : Colors.red, fontSize: 24),
              recognizer: _recognizer
                ..onTap = () {
                  setState(() {
                    _toggle = !_toggle;
                  });
                })
        ]))
      ]),
    );
  }

  void _updateText(String text) {
    setState(() {
      _operation = text;
    });
  }

  @override
  void dispose() {
    //使用GestureRecognizer后一定要调用其dispose()方法来释放资源（主要是取消内部的计时器）
    _recognizer.dispose();
    super.dispose();
  }
}

//检测手势拖动、滑动
class _DragTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DragTestState();
  }
}

class _DragTestState extends State<_DragTest> {
  double _left = 0.0; //距左边的偏移
  double _top = 0.0; //距顶部的偏移
  double _topVertical = 0.0; //仅竖直方向移动的widget距离顶部的距离
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "可任意方向拖拽",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              //手指按下时触发此回调
              //DragDownDetails.globalPosition：当用户按下时，此属性为用户按下的位置
              // 相对于屏幕（而非父组件）原点(左上角)的偏移。
              onPanDown: (details) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${details.globalPosition}");
              },
              //手指滑动时会出触发此回调
              onPanUpdate: (details) {
                setState(() {
                  _top += details.delta.dy;
                  _left += details.delta.dx;
                });
              },
              onPanEnd: (details) {
                //打印滑动结束时在x、y轴上的速度
                //DragEndDetails.velocity：该属性代表用户抬起手指时的滑动速度(包含x、y两个轴的），
                // 示例中并没有处理手指抬起时的速度，常见的效果是根据用户抬起手指时的速度做一个减速动画
                print(details.velocity);
              },
            ),
          ),

          //GestureDetector可以只识别特定方向的手势事件
          Positioned(
            top: _topVertical,
            child: GestureDetector(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "仅垂直方向拖拽",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                //垂直方向拖动事件
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _topVertical += details.delta.dy;
                  });
                }),
          )
        ],
      ),
    );
  }
}

class _ScaleGestureTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleGestureTestState();
  }
}

class _ScaleGestureTestState extends State<_ScaleGestureTest> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("缩放手势"),
      ),
      body: Center(
        child: GestureDetector(
          child: Image.asset(
            "assets/ic_avatar.png",
            width: _width,
          ),
          onScaleUpdate: (details) {
            setState(() {
              _width = 200 * details.scale.clamp(.8, 3);
            });
          },
        ),
      ),
    );
  }
}
