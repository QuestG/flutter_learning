import 'package:flutter/material.dart';

/// Row和Column都只会在主轴方向占用尽可能大的空间，而纵轴的长度则取决于他们最大子元素的长度。
class RowColumnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row and Column"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hello world"),
              Text("I'm Quest"),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hello world"),
              Text("I'm Quest"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text("Hello world"),
              Text("I'm Quest"),
            ],
          ),
          //crossAxisAlignment的参考系是verticalDirection，
          // 即verticalDirection值为VerticalDirection.down时crossAxisAlignment.start指顶部对齐，
          // verticalDirection值为VerticalDirection.up时，crossAxisAlignment.start指底部对齐；
          // 而crossAxisAlignment.end和crossAxisAlignment.start正好相反；
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Text("底部对齐："),
              Text(
                "Hello world",
                style: TextStyle(fontSize: 24),
              ),
              Text("I'm Quest"),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text("hi"), Text("world")],
          ),
          //将Column的宽度指定为屏幕宽度；这可以通过ConstrainedBox或SizedBox
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Text("hi"), Text("world")],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: <Widget>[
                              Text("Hello world"),
                              Text("I'm Quest"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //如果要让里面的Column占满外部Column，可以使用Expanded 组件
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: <Widget>[
                                  Text("Hello world"),
                                  Text("I'm Quest"),
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
