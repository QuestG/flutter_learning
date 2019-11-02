import 'package:flutter/material.dart';

//当指针按下时，Flutter会对应用程序执行命中测试(Hit Test)，以确定指针与屏幕接触的位置存在
//哪些组件（widget）， 指针按下事件（以及该指针的后续事件）然后被分发到由命中测试发现的最
//内部的组件，然后从那里开始，事件会在组件树中向上冒泡，这些事件会从最内部的组件被分发到组件
//树根的路径上的所有组件，
//只有通过命中测试的组件才能触发事件,Flutter中可以使用Listener来监听原始触摸事件
class PointerEventTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PointerEventTestState();
  }
}

//PointerDownEvent、PointerMoveEvent、PointerUpEvent都是PointerEvent的一个子类，PointerEvent类中包括当前指针的一些信息，如：
//
//position：它是鼠标相对于全局坐标的偏移。
//delta：两次指针移动事件（PointerMoveEvent）的距离。
//pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
//orientation：指针移动方向，是一个角度值。
//上面只是PointerEvent一些常用属性，除了这些它还有很多属性,可以查看API文档。
class _PointerEventTestState extends State<PointerEventTest> {
  PointerEvent _event; //保存当前指针位置
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PointerEvent"),
      ),
      body: Column(
        children: <Widget>[
          Listener(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 300,
              height: 150,
              child: Text(
                _event?.toString() ?? "",
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPointerDown: (event) => setState(() => _event = event),
            onPointerMove: (event) => setState(() => _event = event),
            onPointerUp: (event) => setState(() => _event = event),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Listener(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(300, 200)),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Listener(
                        child: UnconstrainedBox(
                          child: SizedBox(
                            width: 200,
                            height: 100,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.red),
                              child: Text("左上角200*100范围内非文本区域点击"),
                            ),
                          ),
                        ),
                        onPointerDown: (event) => print("down1"),
                        behavior: HitTestBehavior.opaque,
//                        behavior: HitTestBehavior.translucent,
                      ),
                    ),
                  ),
                  onPointerDown: (event) => print("down0"),
                ),
              ],
            ),
          ),
          //假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，
          // 这两个组件都能阻止子树接收指针事件，不同之处在于AbsorbPointer本身会参与命中测试，
          // 而IgnorePointer本身不会参与，这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以。
          Listener(
            child: AbsorbPointer(
              child: Listener(
                child: Container(
                  color: Colors.red,
                  width: 200.0,
                  height: 100.0,
                ),
                onPointerDown: (event) => print("in"),
              ),
            ),
            onPointerDown: (event) => print("up"),
          )
        ],
      ),
    );
  }
}
