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
          ///Flutter中可以使用Listener来监听原始触摸事件
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
                        //behavior属性，它决定子组件如何响应命中测试，它的值类型为HitTestBehavior，这是一个枚举类，有三个枚举值：
                        //1)deferToChild：子组件会一个接一个的进行命中测试，如果子组件中有测试通过的，则当前组件通过，这就意味着，如果指针事件作用于子组件上时，其父级组件也肯定可以收到该事件。
                        //2)opaque：在命中测试时，将当前组件当成不透明处理(即使本身是透明的)，最终的效果相当于当前Widget的整个区域都是点击区域。
                        //3)translucent：当点击组件透明区域时，可以对自身边界内及底部可视区域都进行命中测试，这意味着点击顶部组件透明区域时，顶部组件和底部组件都可以接收到事件
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
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    width: 200.0,
                    height: 100.0,
                    child: Text("此Widget不响应指针事件"),
                  ),
                  onPointerDown: (event) => print("in"),
                ),
              ),
              onPointerDown: (event) => print("up"),
            ),
          )
        ],
      ),
    );
  }
}
