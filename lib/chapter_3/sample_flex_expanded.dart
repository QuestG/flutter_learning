import 'package:flutter/material.dart';

class FlexRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex and Expanded"),
      ),
      body: Column(
        children: <Widget>[
          //Flex的两个子widget按1：2来占据水平空间
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    height: 30,
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.green,
                    height: 30,
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 100,
              //Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.red,
                    ),
                    flex: 2,
                  ),
                  //Spacer的功能是占用指定比例的空间，实际上它只是Expanded的一个包装类
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
