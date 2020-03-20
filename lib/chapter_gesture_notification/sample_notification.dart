import 'package:flutter/material.dart';

///在widget树中，每一个节点都可以分发通知，
///通知会沿着当前节点向上传递，所有父节点都可以通过NotificationListener来监听通知。
///Flutter中将这种由子向父的传递通知的机制称为通知冒泡（Notification Bubbling），它是可中止的。
class NotificationTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationTestState();
  }
}

class _NotificationTestState extends State<NotificationTest> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        //NotificationListener 可以指定一个模板参数，该模板参数类型必须是继承自Notification；
        //当显式指定模板参数时，NotificationListener 便只会接收该参数类型的通知。
        body: NotificationListener<CustomNotification>(
          //在收到notification回调时，要更新状态
          onNotification: (notification) {
            setState(() {
              _msg += notification.msg + " ";
            });
            //此bool值表示是否要阻止冒泡，为true表示阻止，如果其有父NotificationListener，则不会收到通知；
            //false表示不阻止冒泡，如果其有父NotificationListener，则会收到通知。
            return true;
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Builder(builder: (context) {
                  return RaisedButton(
                    onPressed: () => CustomNotification("Hi").dispatch(context),
                    child: Text("Send Notification"),
                  );
                }),
                Text(_msg)
              ],
            ),
          ),
        ));
  }
}

//Notification有一个dispatch(context)方法，它是用于分发通知的
class CustomNotification extends Notification {
  CustomNotification(this.msg);

  final String msg;
}
