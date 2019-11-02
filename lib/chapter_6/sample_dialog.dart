import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//由于AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，
// 这就导致他们的子组件不能是延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）
class DialogTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            //showDialog是Material组件库提供的一个用于弹出Material风格对话框的方法
            //如果想打开非Material风格的普通Dialog，则可以使用showGeneralDialog
            onPressed: () => showCustomDialog(
                context: context, builder: (context) => AlertDialog1Test()),
            child: Text("对话框1"),
          ),
          RaisedButton(
            onPressed: () async {
              int i = await showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialogTest();
                  });
              if (i != null) {
                print("语言选择：${i == 1 ? "中文简体" : "英文"}");
              }
            },
            child: Text("对话框2"),
          ),
          RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => DialogWithCheckBox1());
            },
            child: Text("对话框3（复选框可点击）"),
          ),
          RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => DialogWithCheckBox2());
            },
            child: Text("对话框4（复选框可点击）"),
          ),
          RaisedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetDialogTest());
            },
            child: Text("底部菜单列表"),
          ),
          RaisedButton(
            onPressed: () {
              var date = DateTime.now();
              showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: date,
                  lastDate: date.add(Duration(days: 30)));
            },
            child: Text("Material风格日历"),
          ),
          RaisedButton(
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    var dateTime = DateTime.now();
                    return SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (value) {
                          print("iso time changed: $value");
                        },
                        mode: CupertinoDatePickerMode.dateAndTime,
                        minimumDate: dateTime,
                        maximumDate: dateTime.add(Duration(days: 30)),
                        maximumYear: dateTime.year + 1,
                      ),
                    );
                  });
            },
            child: Text("IOS风格日历"),
          )
        ].map((w) {
          return Padding(
            padding: EdgeInsets.only(top: 16),
            child: w,
          );
        }).toList(),
      ),
    );
  }
}

class AlertDialog1Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("提示"),
      content: Text("您确定要删除当前文件吗?"),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("取消")),
        FlatButton(
            onPressed: () {
              //...执行删除操作
              Navigator.of(context).pop();
            },
            child: Text("删除"))
      ],
    );
  }
}

class SimpleDialogTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("请选择语言"),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, 1);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text("中文简体"),
          ),
        ),
        SimpleDialogOption(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text("美国英语"),
          ),
          onPressed: () {
            Navigator.pop(context, 2);
          },
        )
      ],
    );
  }
}

//自定义对话框
Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

///可点击的复选框
///
/// 三种方式：
/// 1.将复选框的选中逻辑单独封装为一个StatefulWidget，在内部管理选中状态。 缺点：对于每一个需要改变状态的Widget都需要单独封装，没有复用性，不建议使用。
/// 2.StatefulBuilder,本质是子Widget通知父Widget重新rebuild子Widget，实现UI更新。
/// 3.参考setState的原理，使用Element的markNeedsBuild，将复选框的Element标记为"dirty"
///
class DialogWithCheckBox1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DialogWithCheckedBox1State();
  }
}

class _DialogWithCheckedBox1State extends State<DialogWithCheckBox1> {
  bool _withTree = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("提示"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("确定删除当前文件吗？"),
          Row(
            children: <Widget>[
              Text("同时删除子目录？"),
              StatefulBuilder(builder: (context, _setState) {
                return Checkbox(
                    value: _withTree,
                    onChanged: (value) {
                      setState(() {
                        _withTree = !_withTree;
                      });
                    });
              })
            ],
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("取消")),
        FlatButton(
            onPressed: () {
              //...执行删除操作
              Navigator.of(context).pop();
            },
            child: Text("删除"))
      ],
    );
  }
}

class DialogWithCheckBox2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DialogWithCheckedBox2State();
  }
}

class _DialogWithCheckedBox2State extends State<DialogWithCheckBox2> {
  bool _withTree = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("提示"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("确定删除当前文件吗？"),
          Row(
            children: <Widget>[
              Text("同时删除子目录？"),
              // 通过Builder来获得构建Checkbox的`context`，
              // 这是一种常用的缩小`context`范围的方式
              Builder(builder: (context) {
                return Checkbox(
                    value: _withTree,
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                      _withTree = !_withTree;
                    });
              })
            ],
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("取消")),
        FlatButton(
            onPressed: () {
              //...执行删除操作
              Navigator.of(context).pop();
            },
            child: Text("删除"))
      ],
    );
  }
}

/// 底部弹出菜单
/// showModalBottomSheet
class BottomSheetDialogTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("$index"),
          onTap: () => Navigator.of(context).pop(index),
        );
      },
    );
  }
}
